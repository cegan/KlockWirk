//
//  MerchantTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/23/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class MerchantTabBarController :UITabBarController{
    
    
    let scheduleViewController              = ScheduleViewController(value: "Welcome Merchant")
    let manageKlockWirkersViewController    = ManageKlockWirkersViewController(nibName: "ManageKlockWirkersViewController", bundle: nil)
    let reportsViewController               = ReportsViewController(nibName: "ReportsViewController", bundle: nil)
    let settingsViewController              = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        scheduleViewController.tabBarItem      = UITabBarItem(title: "Schedule", image: UIImage(named:"calendar.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        manageKlockWirkersViewController.tabBarItem     = UITabBarItem(title: "Manage KlockWirkers", image: UIImage(named:"manageKlockwirkers.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        reportsViewController.tabBarItem     = UITabBarItem(title: "Reports", image: UIImage(named:"reports.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 3)
        settingsViewController.tabBarItem     = UITabBarItem(title: "Setings", image: UIImage(named:"settings.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 4)
        
        
        self.viewControllers =
            [UINavigationController(rootViewController: scheduleViewController),
                UINavigationController(rootViewController: manageKlockWirkersViewController),
                UINavigationController(rootViewController: reportsViewController),
                UINavigationController(rootViewController: settingsViewController)]
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}