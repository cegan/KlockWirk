//
//  KlockWirkTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirkTabBarController : UITabBarController{
    
    let scheduleViewController   = ScheduleViewController(nibName: "ScheduleViewController", bundle: nil)
    let scheduleViewController2  = ManageKlockWirkersViewController(nibName: "ManageKlockWirkersViewController", bundle: nil)
    let scheduleViewController3  = ReportsViewController(nibName: "ReportsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        scheduleViewController.tabBarItem      = UITabBarItem(title: "Schedule", image: UIImage(named:"calendar.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        scheduleViewController2.tabBarItem     = UITabBarItem(title: "Manage KlockWirkers", image: UIImage(named:"manageKlockwirkers.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        scheduleViewController3.tabBarItem     = UITabBarItem(title: "Reports", image: UIImage(named:"reports.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        
        
        self.viewControllers =
            [UINavigationController(rootViewController: scheduleViewController),
                UINavigationController(rootViewController: scheduleViewController2),
                UINavigationController(rootViewController: scheduleViewController3)]
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
