//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CityViewData: Equatable {
  let name: String
  let country: String
  let temperature: String
  let weather: String
  let iconUrl: URL?

  init(city: City) {
    name = city.name
    country = city.country
    guard let forecast = city.forecasts.first,
      let weather = forecast.weather else {
      temperature = ""
      self.weather = ""
      iconUrl = URL(string: "http://openweathermap.org/img/w/01d.png")
      return
    }
    temperature = forecast.temperature.description
    self.weather = weather.main
    iconUrl = URL(string: "http://openweathermap.org/img/w/\(weather.icon).png")
  }
}

func == (lhs: CityViewData, rhs: CityViewData) -> Bool {
  return
    lhs.name == rhs.name &&
    lhs.country == rhs.country &&
    lhs.temperature == rhs.temperature &&
    lhs.weather == rhs.weather &&
    lhs.country == rhs.country
}
