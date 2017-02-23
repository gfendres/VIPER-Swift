//
//  SearchMocks.swift
//  openweather
//
//  Created by Guilherme Endres on 07/02/17.
//  Copyright © 2017 openweather. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SwiftyJSON
@testable import openweather

class SearchPresenterMock: SearchPresenterInput, SearchInteractorOutput {
  var interactor: SearchInteractorInput
  var output: SearchPresenterOutput?
  var router: SearchWireframe
  
  var didLoadView = false
  var didSearchText = false
  var searchedText = ""
  var didSelectItem = false
  var indexSelected = -1
  
  var didFetchCities = false
  var citiesFetched: [CityViewData] = []
  var didFetchCity = false
  var cityFetched: City?
  
  var didHandleError = false
  var error: Error?
  
  required init(router: SearchWireframe, interactor: SearchInteractorInput) {
    self.router = router
    self.interactor = interactor
  }
  
  func viewDidLoad() {
    didLoadView = true
  }
  
  func didSearch(with text: String) {
    didSearchText = true
    searchedText = text
  }
  
  func didSelectItem(at index: Int) {
    didSelectItem = true
    indexSelected = index
    
  }
  
  // MARK: Output
  
  func fetchedCities(_ cities: [CityViewData]) {
    didFetchCities = true
    citiesFetched = cities
  }
  
  func fetchedCity(city: City) {
    didFetchCity = true
    cityFetched = city
  }
  
  func handleError(_ error: Error) {
    didHandleError = true
    self.error = error
  }
}

class SearchInteractorMock: SearchInteractorInput {
  var output: SearchInteractorOutput?
  
  var didFetchCity = false
  var cityIndex = -1
  var didFetchCities = false
  var cityName = ""
  
  required init(service: WeatherWebService) {
    
  }
  func fetchCity(at index: Int) {
    didFetchCity = true
    cityIndex = index
  }
  func fetchCities(withName name: String) {
    didFetchCities = true
    cityName = name
  }
}

class SearchViewMock: SearchPresenterOutput {
  var presenter: SearchPresenterInput?
  
  var didShowCities = false
  var cities: [CityViewData] = []
  var didShowError = false
  var error = ""
  
  func showCities(_ cities: [CityViewData]) {
    didShowCities = true
    self.cities = cities
  }
  func showError(_ error: String) {
    didShowError = true
    self.error = error
  }
}

class SearchRouterMock: SearchWireframe {
  var view: UIViewController?
  
  var didPresentForecastScreen = false
  var city: City?
  
  static func assembleModule() -> UIViewController {
    return UIViewController()
  }
  func presentForecastScreen(city: City) {
    didPresentForecastScreen = true
    self.city = city
  }
}

class WeatherWebServiceMock: WeatherWebService {
  
  static var cityJsonMock = [
    "city":
      [
        "id": 1,
        "name": "Berlin",
        "country": "GE"
      ],
    "list":
      [
        "": ""
      ]
  ]
  var citiesMock = [City(json: JSON(cityJsonMock))]
  
  override func fetch(city: String) -> Observable<[City]> {
    return Observable.just(citiesMock)
  }
}

