//
//  AppDelegate.swift
//  new_now
//
//  Created by Mike on 3/16/17.
//  Copyright © 2017 AnyNYC. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
import Flurry_iOS_SDK //this is only needed if the libraries were obtained using CocoaPods

extension UIApplication {
  var statusBarView: UIView? {
    return value(forKey: "statusBar") as? UIView
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

  var window: UIWindow?
  var locationManager: CLLocationManager!
  var locationFixAchieved : Bool = false
  var locationStatus : NSString = "Not Started"
  var seenError : Bool = false


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    createNavController()
    UIApplication.shared.statusBarView?.backgroundColor = .white
    initLocationManager()

    // Replace YOUR_API_KEY with the api key in the downloaded package
    
    // iOS 10 support
    if #available(iOS 10, *) {
      UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
      application.registerForRemoteNotifications()
    }
      // iOS 9 support
    else if #available(iOS 9, *) {
      UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
      UIApplication.shared.registerForRemoteNotifications()
    }
      // iOS 8 support
    else if #available(iOS 8, *) {
      UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
      UIApplication.shared.registerForRemoteNotifications()
    }
      // iOS 7 support
    else {
      application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
    }
    
    let builder = FlurrySessionBuilder.init()
//      .withAppVersion("1.0")
      .withLogLevel(FlurryLogLevelAll)
      .withCrashReporting(true)
      .withSessionContinueSeconds(10)
    Flurry.startSession("CNF9449G8TK3FTHTJ77H", with: builder)

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
    print("app entered background")
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    

  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    print("app became active")

  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  //LOCATION MANAGER STUFF
  
  // Location Manager helper stuff
  func initLocationManager() {
    let prefs = UserDefaults.standard
    prefs.set("", forKey: "latitude")
    prefs.set("", forKey: "longitude")
    seenError = false
    locationFixAchieved = false
    locationManager = CLLocationManager()
    locationManager.delegate = self
    CLLocationManager.locationServicesEnabled()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
  }
  
  // Location Manager Delegate stuff
  
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationManager.stopUpdatingLocation()
    if (seenError == false) {
      seenError = true
      print(error)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if (locationFixAchieved == false) {
      locationFixAchieved = true
      let locationArray = locations as NSArray
      let locationObj = locationArray.lastObject as! CLLocation
      let coord = locationObj.coordinate
      let prefs = UserDefaults.standard
      
      prefs.set(coord.latitude, forKey: "latitude")
      prefs.set(coord.longitude, forKey: "longitude")
      prefs.set("true", forKey: "locationGiven")
      locationManager.stopUpdatingLocation()
      
    } else {
      locationManager.stopUpdatingLocation()
      locationManager = nil
    }
  }
  
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    var shouldIAllow = false
    switch status {
    case CLAuthorizationStatus.restricted:
      locationStatus = "Restricted Access to location"
    case CLAuthorizationStatus.denied:
      locationStatus = "User denied access to location"
      locationManager.stopUpdatingLocation()
    case CLAuthorizationStatus.notDetermined:
      locationStatus = "Status not determined"
    default:
      locationStatus = "Allowed to location Access"
      shouldIAllow = true
    }
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LabelHasbeenUpdated"), object: nil)
    if (shouldIAllow == true) {
      NSLog("Location to Allowed")
      // Start location services
      locationManager.startUpdatingLocation()
    } else {
      NSLog("Denied access: \(locationStatus)")
    }
  }
  
  // Called when APNs has assigned the device a unique token
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // Convert token to string
    let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
    var tokenString = ""
    
    for i in 0..<deviceToken.count {
      tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
    }
    let prefs = UserDefaults.standard
    prefs.set(tokenString, forKey: "pushtoken")
    print("Device Token:", tokenString)
    
    // Persist it in your backend in case it's new
  }
  
  // Called when APNs failed to register the device for push notifications
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    // Print the error to console (you should alert the user that registration failed)
    print("APNs registration failed: \(error)")
  }
  
  // Push notification received
  func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
    // Print notification payload data
    print("Push notification received: \(data)")
  }


}

