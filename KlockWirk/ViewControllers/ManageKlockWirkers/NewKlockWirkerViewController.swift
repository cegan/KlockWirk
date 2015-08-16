//
//  NewKlockWirkerViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class NewKlockWirkerViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupViewProperties()
        
        
        
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = done
        
    }
    
    
    func doneButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Add KlockWirker"
    }
}
