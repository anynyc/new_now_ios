//
//  AppDelegate.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import UIKit

extension UIApplication {
  var statusBarView: UIView? {
    return value(forKey: "statusBar") as? UIView
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    createNavController()
    UIApplication.shared.statusBarView?.backgroundColor = .white

    return true
  }

  func createNavController() {
    let navController = UINavigationController()
    navController.setNavigationBarHidden(true, animated: false)
    navController.view.layer.backgroundColor = UIColor.white.cgColor
    
    let navBar = navController.navigationBar
    navBar.backgroundColor = (UIColor.white)

//    navBar.setBackgroundImage(UIImage(), for: .default)
    navBar.shadowImage = UIImage()
    navBar.isTranslucent = true
    
    let backBarImage = UIImage(named: "reshetNavLogo")
    let renderedBackBarImage = backBarImage?.withRenderingMode(.alwaysTemplate)
    navBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    navBar.backIndicatorImage = renderedBackBarImage
    navBar.backIndicatorImage?.withAlignmentRectInsets(UIEdgeInsetsMake(10, 10, 10, 10))
    navController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    

    
    //back button
    UINavigationBar.appearance().tintColor = UIColor.lightGray
    UINavigationBar.appearance().isOpaque = true
    UINavigationBar.appearance().titleTextAttributes = ([NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 17)!, NSForegroundColorAttributeName: UIColor.lightGray])
    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -500, vertical: -500), for: .default)
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    
    if let launchVC = LaunchViewController.storyboardInstance() {
      navController.setViewControllers([launchVC], animated: false)
    }
    window?.makeKeyAndVisible()
  }

  
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

