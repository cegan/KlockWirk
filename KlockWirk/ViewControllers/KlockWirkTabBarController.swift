//
//  KlockWirkTabBarController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirkTabBarController : UITabBarController{
    
    let homeViewController  = HomeViewController(nibName: "HomeViewController", bundle: nil)
    let settingsViewController  = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
    
    
    init(){
        
        super.init(nibName: nil, bundle: nil);
        
        homeViewController.tabBarItem     = UITabBarItem(title: "Home", image: UIImage(named:"home.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 1)
        settingsViewController.tabBarItem     = UITabBarItem(title: "Settings", image: UIImage(named:"settings.png")?.imageWithRenderingMode(.AlwaysOriginal), tag: 2)
        
        self.viewControllers = [
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: settingsViewController)]
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
