//
//  NewKlockWirkerViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class NewKlockWirkerViewController: UIViewController {

    
    let klockWirkService = KlockWirkServices()
   
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        registerNotification()
        setupViewProperties()
        setupNavigationButtons()
    }
    
    
    func setupNavigationButtons(){
        
        let submit = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: "submitButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = submit
    }
    
    
    
    func newKlockWirkerWasSuccessfullyAdded(notification: NSNotification){
        
        var data = notification.userInfo as! Dictionary<String,NSDictionary>
    
        ApplicationInformation.addKlockWirker(JSONUtilities.parseKlockWirker(data[Keys.KlockWirkerKey]!))
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func registerNotification(){
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(
            self,
            selector: "newKlockWirkerWasSuccessfullyAdded:",
            name:NotificationConstants.AddNewKlockWirkerCompeleted,
            object: nil
        )
    }
    
    
    func submitButtonTapped(){

        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
       
        klockWirkService.addNewKlockWirker(KlockWirker(firstName: firstName.text!, lastName: lastName.text!, emailAddress: emailAddress.text!, phoneNumber: phone.text!, password: ""))
    }
    
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Add KlockWirker"
    }
}
