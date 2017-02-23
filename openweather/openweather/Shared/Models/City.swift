//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation
import SwiftyJSON

struct City {
  let id: Int
  let name: String
  let country: String
  let forecasts: [Forecast]

  init(json: JSON) {
    let city = json["city"]
    if city.exists() { // JSON for Forecast is different tha Weather
      id = city["id"].intValue
      name = city["name"].stringValue
      country = city["country"].stringValue
      forecasts = json["list"].arrayValue.map(Forecast.init)
    } else {
      id = json["id"].intValue
      name = json["name"].stringValue
      country = json["sys"]["country"].stringValue
      forecasts = [Forecast(json: json)]
    }
  }
}
