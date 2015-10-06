//
//  ForgotPasswordViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/6/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    

    init(){
        
        super.init(nibName: "ForgotPasswordViewController", bundle: nil);
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavigationButtons()
    }
    

    
    func setupNavigationButtons(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
    }
    
    
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
