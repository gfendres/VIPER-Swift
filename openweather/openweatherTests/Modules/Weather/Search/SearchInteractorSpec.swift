//
//  SearchInteractorSpec.swift
//  openweather
//
//  Created by Guilherme Endres on 07/02/17.
//  Copyright © 2017 openweather. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import openweather
class SearchInteractorSpec: QuickSpec {
  
  override func spec() {
    describe("Search Interactor") {
      var presenter: SearchPresenterMock!
      var interactor: SearchInteractor!
      var view: SearchViewMock!
      var router: SearchRouterMock!
      
      beforeEach {
        view = SearchViewMock()
        router = SearchRouterMock()
        interactor = SearchInteractor(service: WeatherWebServiceMock())
        presenter = SearchPresenterMock(router: router, interactor: interactor)
        
        presenter.output = view
        interactor.output = presenter
      }
      
      describe("fetch cities") {
        beforeEach {
          interactor.fetchCities(withName: "Berlin")
        }
        
        it("should fetch cities") {
          expect(presenter.didFetchCities).to(beTrue())
          expect(presenter.citiesFetched).toNot(beNil())
        }
      }
      
      describe("fetch city") {
        beforeEach {
          interactor.fetchCities(withName: "")
        }
        
        context("if is out of index") {
          beforeEach {
            interactor.fetchCity(at: 2)
          }
          
          it("should not fetch city") {
            expect(presenter.didFetchCity).to(beFalse())
            expect(presenter.cityFetched).to(beNil())
          }
        }

        context("if the index is valid") {
          beforeEach {
            interactor.fetchCity(at: 0)
          }
          
          it("should fetch city") {
            expect(presenter.didFetchCity).to(beTrue())
            expect(presenter.cityFetched).toNot(beNil())
          }
        }
      
      }
    }
  }
}
