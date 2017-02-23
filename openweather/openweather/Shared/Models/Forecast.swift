//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Forecast {
  let temperature: Double
  let maxTemperature: Double
  let minTemperature: Double
  let pressure: Double
  let humidity: Int
  let weather: Weather?
  let windSpeed: Double

  init(json: JSON) {
    let main = json["main"]
    temperature = main["temp"].doubleValue
    maxTemperature = main["temp_max"].doubleValue
    minTemperature = main["temp_min"].doubleValue
    pressure = main["pressure"].doubleValue
    humidity = main["humidity"].intValue
    if let weatherJson = json["weather"].arrayValue.first {
      weather = Weather(json: weatherJson)
    } else {
      weather = nil
    }
    windSpeed = json["wind"]["speed"].doubleValue
  }
}
