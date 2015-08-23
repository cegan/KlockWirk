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
        
        registerNotifications()
        loadApplicationSettings()
        setUserInterfaceDefaults()
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = self.loginControllerNavigationController
        self.window?.makeKeyAndVisible()
        
        
        let service = KlockWirkServices()
        service.getAllKlockWirkers()
        

        
        return true
    }
    
    
    func registerNotifications(){
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(
            self,
            selector: "addKlockWirkers:",
            name:NotificationConstants.RetrieveKlockWirkersCompeleted,
            object: nil
        )
    }
    
    
    
    func addKlockWirkers(notification: NSNotification){
        
        var data = notification.userInfo as! Dictionary<String, NSArray>
        
        ApplicationInformation.setKlockWirkers(JSONUtilities.parseKlockWirkers(data[Keys.KlockWirkersKey]!))
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
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orangeColor()], forState: UIControlState.Normal)
        UINavigationBar.appearance().translucent = true
    }


}

