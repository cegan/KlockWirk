//
//  KlockWirkTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirkTabBarController : UITabBarController{
    
    let scheduleViewController  = ScheduleViewController(value: "Welcome KlockWirker")
    let settingsViewController  = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        scheduleViewController.tabBarItem     = UITabBarItem(title: "Schedule", image: UIImage(named:"calendar.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        settingsViewController.tabBarItem     = UITabBarItem(title: "Setings", image: UIImage(named:"settings.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        
        self.viewControllers = [
            UINavigationController(rootViewController: scheduleViewController),
            UINavigationController(rootViewController: settingsViewController)]
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
