//
//  MerchantTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/23/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class MerchantTabBarController :UITabBarController{
    

    //let homeViewController                  = HomeViewController(nibName: "HomeViewController", bundle: nil)
    let homeViewController                  = ChartViewController(schedule: Schedule())
    let scheduleViewController              = SchedulesTableViewController(nibName: "SchedulesTableViewController", bundle: nil)
    let manageKlockWirkersViewController    = ManageKlockWirkersViewController(nibName: "ManageKlockWirkersViewController", bundle: nil)
    let settingsViewController              = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        homeViewController.tabBarItem      = UITabBarItem(title: "Home", image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        homeViewController.tabBarItem.selectedImage = UIImage(named:"home_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
    
        scheduleViewController.tabBarItem      = UITabBarItem(title: "Schedules", image: UIImage(named:"calendar_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        scheduleViewController.tabBarItem.selectedImage = UIImage(named:"calendar_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        manageKlockWirkersViewController.tabBarItem     = UITabBarItem(title: "KlockWirkers", image: UIImage(named:"manageKlockwirkers_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 3)
        manageKlockWirkersViewController.tabBarItem.selectedImage = UIImage(named:"manageKlockwirkers_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        
        settingsViewController.tabBarItem     = UITabBarItem(title: "Settings", image: UIImage(named:"settings_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 4)
        settingsViewController.tabBarItem.selectedImage = UIImage(named:"settings_selected.png")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        self.viewControllers =
            [UINavigationController(rootViewController: homeViewController),
                UINavigationController(rootViewController: scheduleViewController),
                UINavigationController(rootViewController: manageKlockWirkersViewController),
                UINavigationController(rootViewController: settingsViewController)]
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}