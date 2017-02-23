//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ForecastViewData {
  let temperature: String
  let maxTemperature: String
  let minTemperature: String
  let pressure: String
  let humidity: String
  let weatherDescription: String
  let windSpeed: String
  let weatherIconUrl: URL?

  init(forecast: Forecast) {
    temperature = forecast.temperature.description
    maxTemperature = forecast.maxTemperature.description
    minTemperature = forecast.minTemperature.description
    pressure = String(forecast.pressure.rounded())
    humidity = String(forecast.humidity)
    windSpeed = String(forecast.windSpeed)
    guard let weather = forecast.weather else {
      weatherDescription = ""
      weatherIconUrl = URL(string: "http://openweathermap.org/img/w/01d.png")
      return
    }
    weatherDescription = weather.description
    weatherIconUrl = URL(string: "http://openweathermap.org/img/w/\(weather.icon).png")
  }
}
