//
//  KlockWirkTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirkTabBarController : UITabBarController,UITabBarControllerDelegate{
    
    
    let noActiveScheduleViewController      = NoCurrentSchedulesViewController(nibName: "NoCurrentSchedulesViewController", bundle: nil)
    let activeScheduleViewController        = KlockWirkerActiveScheduleViewController(schedule: Schedule())
    let scheduleViewController              = SchedulesTableViewController(nibName: "SchedulesTableViewController", bundle: nil)
    let settingsViewController              = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        registerNotification()
        
        noActiveScheduleViewController.tabBarItem   = UITabBarItem(title: "Home", image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        noActiveScheduleViewController.tabBarItem.selectedImage = UIImage(named:"home_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        activeScheduleViewController.tabBarItem     = UITabBarItem(title: "Home", image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        activeScheduleViewController.tabBarItem.selectedImage = UIImage(named:"home_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        scheduleViewController.tabBarItem           = UITabBarItem(title: "Schedules", image: UIImage(named:"calendar_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 3)
        scheduleViewController.tabBarItem.selectedImage = UIImage(named:"calendar_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        settingsViewController.tabBarItem           = UITabBarItem(title: "Settings", image: UIImage(named:"settings_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 4)
        settingsViewController.tabBarItem.selectedImage = UIImage(named:"settings_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        

        if(shouldShowActiveSchedule()){
            
            self.viewControllers =
                [UINavigationController(rootViewController: activeScheduleViewController),
                    UINavigationController(rootViewController: scheduleViewController),
                    UINavigationController(rootViewController: settingsViewController)]
            
        }
        else{
            
            self.viewControllers =
                [UINavigationController(rootViewController: noActiveScheduleViewController),
                    UINavigationController(rootViewController: scheduleViewController),
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
    
    func userDidRefreshSchedule(){
        
        refreshTabBar()
    }

    
    
    //MARK: Utility Methods
    
    func shouldShowActiveSchedule() -> Bool{
    
        let klockWirker = KlockWirkerManager.sharedInstance.klockWirker
        
        if(klockWirker.schedules.count > 0){
            
            if let _ = DateUtilities.getCurrentSchedule(klockWirker.schedules){
                
                return true
            }
        }
        
        return false
    }
    
    func refreshTabBar(){
        
        if(shouldShowActiveSchedule()){
            
            self.viewControllers =
                [UINavigationController(rootViewController: activeScheduleViewController),
                    UINavigationController(rootViewController: scheduleViewController),
                    UINavigationController(rootViewController: settingsViewController)]
            
        }
        else{
            
            self.viewControllers =
                [UINavigationController(rootViewController: noActiveScheduleViewController),
                    UINavigationController(rootViewController: scheduleViewController),
                    UINavigationController(rootViewController: settingsViewController)]
            
        }
    }
}
