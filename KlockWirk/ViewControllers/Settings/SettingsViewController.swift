//
//  SettingsViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/23/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {


    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
    }
    
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Settings"
    }
    

    @IBAction func logoutTouched(sender: AnyObject) {
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window!.rootViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
    }

}
