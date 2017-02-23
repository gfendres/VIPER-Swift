//
//  RootRouter.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright © 2017 openweather. All rights reserved.
//

import Foundation
import UIKit

class RootRouter {
  func assembleRootModule(inWindow window: UIWindow) {
    window.makeKeyAndVisible()
    let navigationController = UINavigationController(rootViewController: SearchRouter.assembleModule())
    navigationController.navigationBar.isTranslucent = true
    window.rootViewController = navigationController
  }
}
