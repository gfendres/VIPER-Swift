//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation

extension Double {
  func toCelsius() -> Int {
    return Int(5.0 / 9.0 * (self - 32.0))
  }
}