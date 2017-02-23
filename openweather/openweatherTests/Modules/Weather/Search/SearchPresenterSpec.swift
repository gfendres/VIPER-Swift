//
//  SearchPresenterSpec.swift
//  openweather
//
//  Created by Guilherme Endres on 07/02/17.
//  Copyright © 2017 openweather. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import openweather
class SearchPresenterSpec: QuickSpec {
 
  override func spec() {
    describe("Search Presenter") { 
      
      var presenter: SearchPresenter!
      var interactor: SearchInteractorMock!
      var view: SearchViewMock!
      var router: SearchRouterMock!
      
      beforeEach {
        view = SearchViewMock()
        router = SearchRouterMock()
        interactor = SearchInteractorMock(service: WeatherWebServiceMock())
        presenter = SearchPresenter(router: router, interactor: interactor)
        
        presenter.output = view
        interactor.output = presenter
      }
      
      describe("view did load") {
        beforeEach {
          presenter.viewDidLoad()
        }
        
        it("should fetch cities") {
          expect(interactor.didFetchCities).to(beTrue())
        }
        
        it("should fetch Berlin,DE") {
          expect(interactor.cityName).to(equal("Berlin,DE"))
        }
      }
      
      describe("search city") {

        context("less than 3 characters") {
          beforeEach {
            presenter.didSearch(with: "FA")
          }
          
          it("should not fetch the city") {
            expect(interactor.didFetchCities).to(beFalse())
          }
        }
        
        context("more than or equal to 3 characters") {
          beforeEach {
            presenter.didSearch(with: "Florianopolis")
          }
        
          it("should fetch the city") {
            expect(interactor.didFetchCities).to(beTrue())
            expect(interactor.cityName).to(equal("Florianopolis"))
          }
        }
      }
      
      describe("selects an item") {
        beforeEach {
          presenter.didSelectItem(at: 0)
        }
        
        it("should fetch city") {
          expect(interactor.didFetchCity).to(beTrue())
        }
      
        it("should fetch city the city at correct index") {
          expect(interactor.cityIndex).to(equal(0))
        }
      }
      
      describe("fetched cities") {
        let cities = [CityViewData(city: City(json: ["":""]))]

        beforeEach {
          presenter.fetchedCities(cities)
        }
        
        it("should show cities") {
          expect(view.didShowCities).to(beTrue())
        }
        
        it("should show correct cities") {
          expect(view.cities).to(equal(cities))
        }
      }
      
      describe("handle error") {
        let error = "testError"
        beforeEach {
          presenter.handleError(NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: error]))
        }
        
        it("should show the error") {
          expect(view.didShowError).to(beTrue())
          expect(view.error).to(equal(error))
        }
      }
      
      describe("fetched city") {
        let city = City(json: ["":""])
        beforeEach {
          presenter.fetchedCity(city: city)
        }
        
        it("should present the forecast screen") {
          expect(router.didPresentForecastScreen).to(beTrue())
        }
      }
    }
  }
}

