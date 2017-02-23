//
//  ForecastRouter.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit

class ForecastRouter: ForecastWireframe {
  weak var view: UIViewController?

  static func assembleModule(city: City) -> UIViewController {
    guard let viewController = R.storyboard.weather.forecastViewController() else {
      fatalError()
    }

    let router = ForecastRouter()
    let interactor = ForecastInteractor(service: ForecastWebService(), city: city)
    let presenter = ForecastPresenter(router: router, interactor: interactor)

    viewController.presenter = presenter
    presenter.output = viewController
    interactor.output = presenter
    router.view = viewController

    return viewController
  }
}
