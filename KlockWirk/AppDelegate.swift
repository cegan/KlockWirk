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
        
        loadApplicationSettings()
        setUserInterfaceDefaults()
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = self.loginControllerNavigationController
        self.window?.makeKeyAndVisible()
        
        
        
        
        
        let service = KlockWirkServices()
        service.getAllKlockWirkers()
        
        var k = KlockWirker()
        
        
        
        k.firstName = "CaseyEE"
        k.lastName = "Egan"
        k.emailAddress = "c.egan@me.com"
        k.phoneNumber = "2222222222"
        k.password  = "tester1111"
        
        service.addNewKlockWirker(k)
        
        
        return true
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
    
    
    
    func loadApplicationSettings(){
        
        ApplicationInformation.setKlockWirkBaseUrl((NSBundle.mainBundle().infoDictionary?["KlockWirkBaseAPI"] as? String)!)
    }
    
    
    func setUserInterfaceDefaults(){
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orangeColor()], forState: UIControlState.Normal)
        UINavigationBar.appearance().translucent = true
    }


}

