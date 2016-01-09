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
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
    }()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = SplashScreenViewController()
        
        setupActivityIndicator()
        
        loadApplicationSettings()
        loadUserInterfaceDefaults()
        registerForApplicationNotifications(application)
        displayUserInterface()

        return true
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
       
    }
 
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        let trimEnds = {
            
            deviceToken.description.stringByTrimmingCharactersInSet(
                NSCharacterSet(charactersInString: "<>"))
        }
        
        let cleanToken = {
            
            trimEnds().stringByReplacingOccurrencesOfString(
                " ", withString: "")
        }
        
        print("Cleaned Token " + cleanToken())
        
        ApplicationInformation.setDeviceToken(cleanToken())
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
    
    
    
    func setupActivityIndicator () {
        
        self.activityIndicator.center       = (window?.rootViewController!.view.center)!;
        activityIndicator.autoresizingMask  = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        window?.rootViewController!.view.addSubview(activityIndicator)
    }
    
    
    func displayUserInterface(){
        
        let loginService = LoginService()
        
        if(ApplicationInformation.shouldAutoLogin()){
            
            activityIndicator.startAnimating()
            
            loginService.login(ApplicationInformation.getUserName() as String, password: ApplicationInformation.getPassword() as String) { (response:NSDictionary) in
                
                if(ApplicationInformation.isKlockWirker()){
                    
                    let klockWirkService = KlockWirkerServices()

                    klockWirkService.getKlockWirker(ApplicationInformation.getKlockWirkerId()) {(response: KlockWirker) in
                        
                        self.window?.rootViewController = KlockWirkTabBarController()
                    }
                }
                if(ApplicationInformation.isMerchant()){
                    
                    let merchantService = MerchantServices()
                    
                    merchantService.getMerchant(ApplicationInformation.getMerchantId()) {(response: Merchant) in
                        
                        self.window?.rootViewController = MerchantTabBarController()
                    }
                }
                
                self.activityIndicator.stopAnimating()
            }
        }
        else{
            
            window?.rootViewController = LoginViewController()
        }
        
        window?.makeKeyAndVisible()
    }
    
    func loadApplicationSettings(){
        
        ApplicationInformation.setKlockWirkBaseUrl((NSBundle.mainBundle().infoDictionary?["KlockWirkBaseAPI"] as? String)!)
    }
    
    func loadUserInterfaceDefaults(){
        
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
        
    }
    
    func registerForApplicationNotifications(application: UIApplication){
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
    }

}

