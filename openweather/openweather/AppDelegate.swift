//
//  AppDelegate.swift
//  openweather
//
//  Created by Guilherme Endres on 05/02/17.
//  Copyright © 2017 openweather. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var rootRouter: RootRouter?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    rootRouter = RootRouter()
    rootRouter?.assembleRootModule(inWindow: window!)
    decorateNavigationBar()

    return true
  }

  // MARK: Private

  private func decorateNavigationBar() {
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.1296478808, green: 0.5872035623, blue: 0.9542422891, alpha: 1)
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    UINavigationBar.appearance().isTranslucent = true
  }
}

