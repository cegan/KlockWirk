//
//  MerchantTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/23/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class MerchantTabBarController :UITabBarController{
    
    
    let homeViewController                  = HomeViewController(nibName: "HomeViewController", bundle: nil)
    let scheduleViewController              = ScheduleViewController(value: "")
    let manageKlockWirkersViewController    = ManageKlockWirkersViewController(nibName: "ManageKlockWirkersViewController", bundle: nil)
    let settingsViewController              = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        homeViewController.tabBarItem      = UITabBarItem(title: "Home", image: UIImage(named:"home.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        scheduleViewController.tabBarItem      = UITabBarItem(title: "Schedules", image: UIImage(named:"calendar.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        manageKlockWirkersViewController.tabBarItem     = UITabBarItem(title: "Manage KlockWirkers", image: UIImage(named:"manageKlockwirkers.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 3)
        settingsViewController.tabBarItem     = UITabBarItem(title: "Setings", image: UIImage(named:"settings.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 4)
        
        
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