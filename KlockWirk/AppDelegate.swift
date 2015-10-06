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
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        window?.makeKeyAndVisible()
        
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
        
        if let font = UIFont(name: "Gotham-Medium", size: 16) {
            
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font,
                NSForegroundColorAttributeName : UIColor(red: 109.0/255.0, green: 110.0/255.0, blue: 113.0/255.0, alpha: 1.0)]
        }
        
        
        //UINavigationBar Attributes
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0)
        
        
        //UITextField attributes
        UITextField.appearance().tintColor = UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0)
        
       
        //UITabbar attributes
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 109.0/255.0, green: 110.0/255.0, blue: 113.0/255.0, alpha: 1.0)], forState: UIControlState.Normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0)], forState: UIControlState.Selected)
        
        
        //UINavigation attributes
        
        
  
        

    }


}

