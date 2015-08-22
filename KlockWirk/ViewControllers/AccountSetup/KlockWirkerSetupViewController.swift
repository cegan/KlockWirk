//
//  KlockWirkerSetupViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/14/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerSetupViewController: UIViewController {


    let klockWirkService = KlockWirkServices()
    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupViewProperties()
        setupNavigationButtons()
        registerNotification()
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
    
    
    
    func registerNotification(){
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(
            self,
            selector: "registerKlockWirkerCompeleted",
            name:NotificationConstants.RegisterKlockWirkerCompeleted,
            object: nil
        )
    }
    
    
    func registerKlockWirkerCompeleted(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func submitButtonTapped(){
        
        klockWirkService.registerKlockWirker(emailAddress.text!, phoneNumber: phoneNumber.text!, password: password.text!)
    }
    
    
    func cancelButtonTapped(){
     
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
