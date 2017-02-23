//
//  SearchContract.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit

protocol SearchPresenterInput: class {
  weak var output: SearchPresenterOutput? { get set }
  var router: SearchWireframe { get }

  init(router: SearchWireframe,
       interactor: SearchInteractorInput)

  func viewDidLoad()
  func didSearch(with text: String)
  func didSelectItem(at index: Int)
}

protocol SearchPresenterOutput: ShowError {
  var presenter: SearchPresenterInput? { get set }
  func showCities(_ cities: [CityViewData])
}

protocol SearchInteractorInput: class {
  weak var output: SearchInteractorOutput? { get set }
  init(service: WeatherWebService)
  func fetchCities(withName name: String)
  func fetchCity(at index: Int)
}

protocol SearchInteractorOutput: class {
  var interactor: SearchInteractorInput { get }
  
  func fetchedCities(_ cities: [CityViewData])
  func fetchedCity(city: City)
  func handleError(_ error: Error)
}

protocol SearchWireframe: class {
  weak var view: UIViewController? { get set }
  static func assembleModule() -> UIViewController
  func presentForecastScreen(city: City)
}
