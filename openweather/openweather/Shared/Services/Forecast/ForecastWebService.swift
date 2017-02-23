//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class ForecastWebService {
  func fetch(cityId id: Int) -> Observable<City> {
    return Observable.create { observer in

      Alamofire.request("\(API.baseUrl)/forecast?id=\(id)&units=metric&cnt=5", method: .get, parameters: API.appKeyParameter)
        .validate()
        .responseJSON { response in
          switch response.result {
          case .failure(let error):
            observer.onError(error)
          case .success(let data):
            let json = JSON(data)
            observer.onNext(City(json: json))
            observer.onCompleted()
          }
        }

      return Disposables.create()
    }
  }
}
