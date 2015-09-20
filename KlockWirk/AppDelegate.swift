//
//  AppDelegate.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController:KlockWirkTabBarController = KlockWirkTabBarController()
    var loginControllerNavigationController: UINavigationController = UINavigationController(rootViewController: LoginViewController(nibName: "LoginViewController", bundle: nil))
    
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NumberFormatter.formatDoubleToCurrency(200000)
        
        loadApplicationSettings()
        setUserInterfaceDefaults()
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //self.window?.rootViewController = self.loginControllerNavigationController
        
        self.window?.rootViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
       
    }

    func applicationDidEnterBackground(application: UIApplication) {
       
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
       
    }

    func applicationWillTerminate(application: UIApplication) {
        
        
    }
    
    
    
    func loadApplicationSettings(){
        
        ApplicationInformation.setKlockWirkBaseUrl((NSBundle.mainBundle().infoDictionary?["KlockWirkBaseAPI"] as? String)!)
    }
    
    
    func setUserInterfaceDefaults(){
      
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor(red: 255.0/255.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 30.0/255, green: 171.0/255, blue: 242.0/255, alpha: 1.0)]
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1.0)], forState: UIControlState.Normal)
        UINavigationBar.appearance().translucent = true
    }


}

