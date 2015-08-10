//
//  KlockWirkTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirkTabBarController : UITabBarController{
    
    let scheduleViewController  = ScheduleViewController(nibName: "ScheduleViewController", bundle: nil)
    let scheduleViewController2  = ScheduleViewController(nibName: "ScheduleViewController", bundle: nil)
    let scheduleViewController3  = ScheduleViewController(nibName: "ScheduleViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        scheduleViewController.tabBarItem       = UITabBarItem(title: "Schedule", image: UIImage(named:"calendar.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        scheduleViewController2.tabBarItem     = UITabBarItem(title: "Misc", image: UIImage(named:"clock.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        scheduleViewController3.tabBarItem           = UITabBarItem(title: "Misc", image: UIImage(named:"clock.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        
        
       
        
        self.viewControllers =
            [UINavigationController(rootViewController: scheduleViewController),
                UINavigationController(rootViewController: scheduleViewController2),
                UINavigationController(rootViewController: scheduleViewController3)]
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
