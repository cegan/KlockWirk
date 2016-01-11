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
    let activeScheduleViewController        = MerchantActiveScheduleViewController(schedule: Schedule())
    let activeScheduleAchievedViewController = MerchantActiveScheduleAchievedViewController(schedule: Schedule())
    let scheduleViewController              = SchedulesTableViewController(nibName: "SchedulesTableViewController", bundle: nil)
    let manageKlockWirkersViewController    = ManageKlockWirkersViewController(klockWirkersToDisplay: MerchantManager.sharedInstance.merchant.klockWirkers, asReadonly: false)
    let settingsViewController              = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    

    
    //MARK: Initializers
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        self.delegate = self
        
        noActiveScheduleViewController.tabBarItem      = UITabBarItem(title: "Home",
            image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        noActiveScheduleViewController.tabBarItem.selectedImage = UIImage(named:"home_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        activeScheduleViewController.tabBarItem      = UITabBarItem(title: "Home",
            image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        activeScheduleViewController.tabBarItem.selectedImage = UIImage(named:"home_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        activeScheduleAchievedViewController.tabBarItem     = UITabBarItem(title: "Home", image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        activeScheduleAchievedViewController.tabBarItem.selectedImage = UIImage(named:"home_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
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
            
            
            if(isActiveScheduleAchieved()){
                
                self.viewControllers =
                    [UINavigationController(rootViewController: activeScheduleAchievedViewController),
                        UINavigationController(rootViewController: scheduleViewController),
                        UINavigationController(rootViewController: manageKlockWirkersViewController),
                        UINavigationController(rootViewController: settingsViewController)]
                
            }
            else{
                
                self.viewControllers =
                    [UINavigationController(rootViewController: activeScheduleViewController),
                        UINavigationController(rootViewController: scheduleViewController),
                        UINavigationController(rootViewController: manageKlockWirkersViewController),
                        UINavigationController(rootViewController: settingsViewController)]
                
            }
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
            
            if(isActiveScheduleAchieved()){
                
                self.viewControllers =
                    [UINavigationController(rootViewController: activeScheduleAchievedViewController),
                        UINavigationController(rootViewController: scheduleViewController),
                        UINavigationController(rootViewController: manageKlockWirkersViewController),
                        UINavigationController(rootViewController: settingsViewController)]
            }
            else{
                
                self.viewControllers =
                    [UINavigationController(rootViewController: activeScheduleViewController),
                        UINavigationController(rootViewController: scheduleViewController),
                        UINavigationController(rootViewController: manageKlockWirkersViewController),
                        UINavigationController(rootViewController: settingsViewController)]
                
            }
            
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
    
    func isActiveScheduleAchieved() -> Bool{
   
        let merchant = MerchantManager.sharedInstance.merchant
        
        if(merchant.schedules.count > 0){
            
            if let s = DateUtilities.getCurrentSchedule(merchant.schedules){
                
                if(s.hasGoalBeenReached()){
                    
                    return true
                }
                
                return false
            }
        }
        
        return false
    }
}