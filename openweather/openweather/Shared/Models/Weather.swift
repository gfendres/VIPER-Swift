//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Weather {
  let id: Int
  let main: String
  let description: String
  let icon: String

  init(json: JSON) {
    id = json["id"].intValue
    main = json["main"].stringValue
    description = json["description"].stringValue
    icon = json["icon"].stringValue
  }
}