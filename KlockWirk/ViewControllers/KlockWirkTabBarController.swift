//
//  KlockWirkTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirkTabBarController : UITabBarController{
    
    
    let NoActiveScheduleViewController      = NoCurrentSchedulesViewController(nibName: "NoCurrentSchedulesViewController", bundle: nil)
    let homeViewController                  = ActiveScheduleViewController(schedule: Schedule())
    let scheduleViewController              = SchedulesTableViewController(nibName: "SchedulesTableViewController", bundle: nil)
    let settingsViewController              = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        homeViewController.tabBarItem           = UITabBarItem(title: "Home", image: UIImage(named:"home_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        scheduleViewController.tabBarItem       = UITabBarItem(title: "Schedules", image: UIImage(named:"calendar_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        settingsViewController.tabBarItem       = UITabBarItem(title: "Settings", image: UIImage(named:"settings_normal.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 3)
        
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
