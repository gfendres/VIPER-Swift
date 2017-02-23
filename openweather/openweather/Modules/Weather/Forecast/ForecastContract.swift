//
//  ForecastContract.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit

protocol ForecastPresenterInput: class {
  weak var output: ForecastPresenterOutput? { get set }
  var router: ForecastWireframe { get }

  init(router: ForecastWireframe,
       interactor: ForecastInteractorInput)
  func viewDidLoad()
}

protocol ForecastPresenterOutput: ShowError {
  var presenter: ForecastPresenterInput? { get set }
  func showForecast(_ forecast: [ForecastViewData])
  func showCity(name: String)
}

protocol ForecastInteractorInput: class {
  weak var output: ForecastInteractorOutput? { get set }
  var city: City { get }
  init(service: ForecastWebService, city: City)
  func fetchForecast()
  func fetchCity()
}

protocol ForecastInteractorOutput: class {
  var interactor: ForecastInteractorInput { get }
  func fetchedForecast(_ forecast: [ForecastViewData])
  func handleError(_ error: Error)
  func fetchCity(name: String)
}

protocol ForecastWireframe: class {
  weak var view: UIViewController? { get set }
  static func assembleModule(city: City) -> UIViewController

}
