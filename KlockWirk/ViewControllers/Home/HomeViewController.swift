//
//  HomeViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/7/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Home"
    }
}
