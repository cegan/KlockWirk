//
//  MerchantTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/23/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class MerchantTabBarController :UITabBarController,UITabBarControllerDelegate{
    

    let noActiveScheduleViewController      = NoCurrentSchedulesViewController(nibName: "NoCurrentSchedulesViewController", bundle: nil)
    let activeScheduleViewController        = ActiveScheduleViewController(schedule: Schedule())
    let scheduleViewController              = SchedulesTableViewController(nibName: "SchedulesTableViewController", bundle: nil)
    let manageKlockWirkersViewController    = ManageKlockWirkersViewController(klockWirkersToDisplay: MerchantManager.sharedInstance.merchant.klockWirkers, asReadonly: false)
    let settingsViewController              = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    //MARK: Register Notification
    
    func registerNotification(){
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(
            self,
            selector: "userDidAddNewSchedule",
            name:NotificationConstants.UserDidAddNewSchedule,
            object: nil
        )
        
        
        notificationCenter.addObserver(
            self,
            selector: "userDidRefreshSchedule",
            name:NotificationConstants.UserDidRefreshSchedule,
            object: nil
        )
    }
    
    
    
    //MARK: Notification Handlers
    
    func userDidAddNewSchedule(){
        
        refreshTabBar()
    }
    
    func userDidRefreshSchedule(){
        
        refreshTabBar()
    }
    
    
    
    //MARK: Initializers
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        registerNotification()
        
        self.delegate = self
        
        noActiveScheduleViewController.tabBarItem      = UITabBarItem(title: "Home",
            image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        noActiveScheduleViewController.tabBarItem.selectedImage = UIImage(named:"home_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        activeScheduleViewController.tabBarItem      = UITabBarItem(title: "Home",
            image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        activeScheduleViewController.tabBarItem.selectedImage = UIImage(named:"home_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        scheduleViewController.tabBarItem      = UITabBarItem(title: "Schedules",
            image: UIImage(named:"calendar_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 3)
        scheduleViewController.tabBarItem.selectedImage = UIImage(named:"calendar_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        manageKlockWirkersViewController.tabBarItem = UITabBarItem(title: "KlockWirkers",
            image: UIImage(named:"manageKlockwirkers_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 4)
        manageKlockWirkersViewController.tabBarItem.selectedImage = UIImage(named:"manageKlockwirkers_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        settingsViewController.tabBarItem     = UITabBarItem(title: "Settings",
            image: UIImage(named:"settings_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 5)
        settingsViewController.tabBarItem.selectedImage = UIImage(named:"settings_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        
        if(shouldShowActiveSchedule()){
            
            self.viewControllers =
                [UINavigationController(rootViewController: activeScheduleViewController),
                    UINavigationController(rootViewController: scheduleViewController),
                    UINavigationController(rootViewController: manageKlockWirkersViewController),
                    UINavigationController(rootViewController: settingsViewController)]
            
        }
        else{
            
            self.viewControllers =
                [UINavigationController(rootViewController: noActiveScheduleViewController),
                    UINavigationController(rootViewController: scheduleViewController),
                    UINavigationController(rootViewController: manageKlockWirkersViewController),
                    UINavigationController(rootViewController: settingsViewController)]
            
        }
        
    
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        refreshTabBar()
    }
    
    func refreshTabBar(){
        
        if(shouldShowActiveSchedule()){
            
            self.viewControllers =
                [UINavigationController(rootViewController: activeScheduleViewController),
                    UINavigationController(rootViewController: scheduleViewController),
                    UINavigationController(rootViewController: manageKlockWirkersViewController),
                    UINavigationController(rootViewController: settingsViewController)]
            
            
        }
        else{
            
            self.viewControllers =
                [UINavigationController(rootViewController: noActiveScheduleViewController),
                    UINavigationController(rootViewController: scheduleViewController),
                    UINavigationController(rootViewController: manageKlockWirkersViewController),
                    UINavigationController(rootViewController: settingsViewController)]
            
        }
    }
    
    func shouldShowActiveSchedule() -> Bool{
        
        let merchant = MerchantManager.sharedInstance.merchant
        
        if(merchant.schedules.count > 0){
            
            if let _ = DateUtilities.getCurrentSchedule(merchant.schedules){
                
                return true
            }
        }
        
        return false
    }
}