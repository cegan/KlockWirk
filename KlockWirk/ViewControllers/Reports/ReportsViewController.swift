//
//  ReportsViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        setupViewProperties()
    }

    
    func setupViewProperties(){
        
        self.tabBarController?.navigationItem.title = "Reports"
    }
   
    
    

}
