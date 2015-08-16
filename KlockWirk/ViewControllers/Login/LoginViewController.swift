//
//  LoginViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/9/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    @IBAction func login(sender: AnyObject) {
        
        var tabBarController:KlockWirkTabBarController = KlockWirkTabBarController()
        
        self.navigationController?.pushViewController(tabBarController, animated: false)
        
        
    }
    @IBAction func newMerchantAccount(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController: MerchantSetupViewController(nibName: "MerchantSetupViewController", bundle: nil)), animated: true, completion: nil)
    }

    @IBAction func newKlockWirkerAccount(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController: KlockWirkerSetupViewController(nibName: "KlockWirkerSetupViewController", bundle: nil)), animated: true, completion: nil)
    }
}
