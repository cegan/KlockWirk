//
//  NewKlockWirkerViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class NewKlockWirkerViewController: UIViewController {

    
    let klockWirkService = KlockWirkerServices()
   
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupViewProperties()
        setupNavigationButtons()
    }
    
    
    func setupNavigationButtons(){
        
        let submit = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: "submitButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = submit
    }
    

    
    func submitButtonTapped(){

        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        
        let kw = KlockWirker(firstName: firstName.text!, lastName: lastName.text!, emailAddress: emailAddress.text!, phoneNumber: phone.text!, password: "")
        
        klockWirkService.addNewKlockWirker(kw) { (response: NSDictionary) in
            
            ApplicationInformation.addKlockWirker(JSONUtilities.parseKlockWirker(response))
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Add KlockWirker"
    }
}
