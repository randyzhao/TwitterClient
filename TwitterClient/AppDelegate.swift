//
//  AppDelegate.swift
//  TwitterClient
//
//  Created by randy_zhao on 5/31/16.
//  Copyright © 2016 randy_zhao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    instantiateInitialViewController()
    NSNotificationCenter.defaultCenter().addObserverForName("UserDidLogout", object: nil, queue: NSOperationQueue.mainQueue()) {
      (notification: NSNotification) in
      
      self.instantiateInitialViewController()
    }
    return true
  }

  func instantiateInitialViewController() {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    let nvc = UINavigationController()
    nvc.navigationBar.translucent = false
    let initialViewController: UIViewController
    
    if let currentUser = User.currentUser {
      print("There is a current user: \(currentUser.name)")
      let hvc = HamburgerViewController()
      initialViewController = hvc
      let mvc = SideoutMenuViewController()
      hvc.menuViewController = mvc
      mvc.hamburgerViewController = hvc
    } else {
      print("There is no current user")
      initialViewController = LoginViewController()
      
    }
    
    
    nvc.pushViewController(initialViewController, animated: false)
    window!.rootViewController = nvc
    window!.makeKeyAndVisible()
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    TwitterClient.sharedInstance.handleOpenUrl(url)
    return true
  }
}

