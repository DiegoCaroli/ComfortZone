//
//  AppDelegate.swift
//  ComfortZone
//
//  Created by Diego Caroli on 07/12/2017.
//  Copyright © 2017 Diego Caroli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    var viewController: UIViewController!
    
    Thread.sleep(forTimeInterval: 1.0)
    
    if DataModel.shared.isFirstTime {
      viewController = UIStoryboard(name: "FirstTime", bundle: nil).instantiateInitialViewController()
    } else {
      viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
    self.window?.rootViewController = viewController
    self.window?.makeKeyAndVisible()
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    DataModel.shared.saveProfile()
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    DataModel.shared.saveProfile()
  }


}

