//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class WeatherWebService {
  func fetch(city: String) -> Observable<[City]> {
    return Observable.create { observer in

      Alamofire.request("\(API.baseUrl)/find?q=\(city)&type=like&units=metric", method: .get, parameters: API.appKeyParameter)
        .validate()
        .responseJSON { response in
          switch response.result {
          case .failure(let error):
            observer.onError(error)
          case .success(let data):
            let json = JSON(data)
            let objects = json["list"].arrayValue.map(City.init)
            observer.onNext(objects)
            observer.onCompleted()
          }
        }

      return Disposables.create()
    }
  }
}
