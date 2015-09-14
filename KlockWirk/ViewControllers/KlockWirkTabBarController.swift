//
//  KlockWirkTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirkTabBarController : UITabBarController{
    
    let homeViewController          = HomeViewController(nibName: "HomeViewController", bundle: nil)
    let scheduleViewController      = SchedulesTableViewController(nibName: "SchedulesTableViewController", bundle: nil)
    let settingsViewController      = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        homeViewController.tabBarItem     = UITabBarItem(title: "Home", image: UIImage(named:"home.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        scheduleViewController.tabBarItem      = UITabBarItem(title: "Schedules", image: UIImage(named:"calendar.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        settingsViewController.tabBarItem     = UITabBarItem(title: "Settings", image: UIImage(named:"settings.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 3)
        
        self.viewControllers = [
            UINavigationController(rootViewController: homeViewController),
             UINavigationController(rootViewController: scheduleViewController),
            UINavigationController(rootViewController: settingsViewController)]
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
