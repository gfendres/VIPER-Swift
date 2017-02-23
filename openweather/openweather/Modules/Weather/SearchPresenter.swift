//
//  SearchPresenter.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright (c) 2017 openweather. All rights reserved.
//
//

import UIKit

class SearchPresenter: SearchPresenterInput {

  //MARK: Constants

  private let minimumSearchCharacters = 3

  //MARK: Variables

  weak var output: SearchPresenterOutput?
  private(set) var router: SearchWireframe
  private(set) var interactor: SearchInteractorInput

  //MARK: Lifecycle

  required init(router: SearchWireframe,
                interactor: SearchInteractorInput) {
    self.router = router
    self.interactor = interactor
  }

  //MARK: Input

  func viewDidLoad() {
    interactor.fetchCities(withName: "Berlin,DE")
  }

  func didSearch(with text: String) {
    if text.characters.count >= minimumSearchCharacters {
      interactor.fetchCities(withName: text)
    }
  }

  func didSelectItem(at index: Int) {
    interactor.fetchCity(at: index)
  }

}

extension SearchPresenter: SearchInteractorOutput {
  func fetchedCities(_ cities: [CityViewData]) {
    output?.showCities(cities)
  }

  func handleError(_ error: Error) {
    output?.showError(error.localizedDescription)
  }

  func fetchedCity(city: City) {
    router.presentForecastScreen(city: city)
  }
}
