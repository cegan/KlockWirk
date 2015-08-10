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
        
        initializeViewProperties()

       
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    func initializeViewProperties(){
        
        self.title = "KlockWirk"
    }
}
