//
//  MerchantSetupViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/14/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class MerchantSetupViewController: UIViewController {
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupNavigationButtons()
    }
    
    func setupViewProperties(){
        
        self.title = "Registration"
    }
    
    
    func setupNavigationButtons(){
        
        let submit = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: "submitButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = submit
    }

    
    
    func submitButtonTapped(){
        
    }
    
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
  

}
