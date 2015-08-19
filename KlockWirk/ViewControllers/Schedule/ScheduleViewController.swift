//
//  ScheduleViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        setupViewProperties()
    }

   
    
    func setupViewProperties(){
        
        self.tabBarController?.navigationItem.title = "Schedule"
    }
}
