//
//  ForecastInteractor.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit
import RxSwift

class ForecastInteractor: ForecastInteractorInput {

  weak var output: ForecastInteractorOutput?
  var city: City
  private var service: ForecastWebService
  private var disposeBag = DisposeBag()

  // MARK: Lifecycle

  required init(service: ForecastWebService, city: City) {
    self.city = city
    self.service = service
  }

  // MARK: Input

  func fetchCity() {
    output?.fetchCity(name: city.name)
  }

  func fetchForecast() {
    service.fetch(cityId: city.id)
      .map { $0.forecasts.map(ForecastViewData.init) }
      .subscribe(
        onNext: { [weak self] forecast in
          self?.output?.fetchedForecast(forecast)
        },
        onError: { [weak self] error in
          self?.output?.handleError(error)
        }
      ).addDisposableTo(disposeBag)
  }

}
