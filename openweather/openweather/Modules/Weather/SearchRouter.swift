//
//  SearchRouter.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit

class SearchRouter: SearchWireframe {
  weak var view: UIViewController?

  static func assembleModule() -> UIViewController {
    guard let viewController = R.storyboard.weather.searchViewController() else {
      fatalError()
    }
    
    let router = SearchRouter()
    let interactor = SearchInteractor(service: WeatherWebService())
    let presenter = SearchPresenter(router: router, interactor: interactor)

    viewController.presenter = presenter
    presenter.output = viewController
    interactor.output = presenter
    router.view = viewController

    let backItem = UIBarButtonItem()
    backItem.title = ""
    viewController.navigationItem.backBarButtonItem = backItem

    return viewController
  }

  func presentForecastScreen(city: City) {
    DispatchQueue.main.async {
      self.view?.navigationController?.pushViewController(ForecastRouter.assembleModule(city: city), animated: true)
    }
  }

}
