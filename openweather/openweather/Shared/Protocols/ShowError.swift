//
// Created by Guilherme Endres on 05/02/17.
// Copyright (c) 2017 openweather. All rights reserved.
//

import Foundation
import UIKit

protocol ShowError: class {
  func showError(_ error: String)
}

extension ShowError where Self: UIViewController {
  func showError(_ error: String) {
    let alert = UIAlertController(title: "OPS!", message: error, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel))

    present(alert, animated: true)
  }
}