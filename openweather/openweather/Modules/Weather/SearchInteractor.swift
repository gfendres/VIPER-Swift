//
//  SearchInteractor.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit
import RxSwift

class SearchInteractor: SearchInteractorInput {

  weak var output: SearchInteractorOutput?
  private var service: WeatherWebService
  private var disposeBag = DisposeBag()
  private var cities: [City] = []

  // MARK: Lifecycle

  required init(service: WeatherWebService) {
    self.service = service
  }

  // MARK: Input

  func fetchCities(withName name: String) {
    service.fetch(city: name)
      .debug("Searching")
      .subscribe(
        onNext: { [weak self] cities in
          self?.cities = cities
          let citiesViewData = cities.map(CityViewData.init)
          self?.output?.fetchedCities(citiesViewData)
        },
        onError: { [weak self] error in
          self?.output?.handleError(error)
        }
      ).addDisposableTo(disposeBag)
  }

  func fetchCity(at index: Int) {
    guard index <= cities.count else { return }
    output?.fetchedCity(city: cities[index])
  }

}
