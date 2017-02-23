//
//  ForecastPresenter.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit

class ForecastPresenter: ForecastPresenterInput {

  //MARK: Variables

  weak var output: ForecastPresenterOutput?
  private(set) var router: ForecastWireframe
  private(set) var interactor: ForecastInteractorInput

  //MARK: Lifecycle

  required init(router: ForecastWireframe,
                interactor: ForecastInteractorInput) {
    self.router = router
    self.interactor = interactor
  }

  //MARK: Input

  func viewDidLoad() {
    interactor.fetchCity()
    interactor.fetchForecast()
  }
  
}

extension ForecastPresenter: ForecastInteractorOutput {
  func fetchCity(name: String) {
    output?.showCity(name: name)
  }

  func fetchedForecast(_ forecast: [ForecastViewData]) {
    output?.showForecast(forecast)
  }

  func handleError(_ error: Error) {
    output?.showError(error.localizedDescription)
  }
}
