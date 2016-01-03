//
//  KlockWirkerSetupViewController2ViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/7/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerSetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    let klockWirkService = KlockWirkerServices()
    
    var klockWirkerRegistrationFields = NSMutableArray()
    var klockWirkerLoginFields = NSMutableArray()
    
    @IBOutlet weak var klockWirkerSetupTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        klockWirkerRegistrationFields = getKlockWirkerRegistrationFields()
        klockWirkerLoginFields = getKlockWirkerLoginFields()
        
        
        registerNotification()
        setupViewProperties()
        setupNavigationButtons()
        
        setupTableViewDelegates()
        setupTableViewProperties()
    }
    
    
    func doesKlockWirkerPasswordsMatch() -> Bool{
        
        let kw = getCompletedKlockWirkerRegistration()
        
        if(kw.password != kw.confirmPassword){
            
            return false
        }
        
        return true
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
        
        let tabBarController:KlockWirkTabBarController = KlockWirkTabBarController()
        
        self.navigationController?.pushViewController(tabBarController, animated: false)
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
    
    
    func getKlockWirkerRegistrationFields() -> NSMutableArray{
        
        let klockWirkerRegistrationFields = NSMutableArray()
        
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Email", val: "", type:.String, required:true, tag: 1))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Phone", val: "", type:.String, required:true, tag: 2))
        
        return klockWirkerRegistrationFields
    }
    
    
    func getKlockWirkerLoginFields() -> NSMutableArray{
        
        let klockWirkerRegistrationFields = NSMutableArray()
        
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Password", val: "", type:.String, required:true, tag: 1))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Confirm Password", val: "", type:.String, required:true, tag: 1))
       
        return klockWirkerRegistrationFields
    }
    
    
    func getCompletedKlockWirkerRegistration() -> KlockWirker{
        
        let klockWirker = KlockWirker()
        
        let emailAddress = klockWirkerSetupTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! EnrollmentViewCell
        let phone = klockWirkerSetupTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! EnrollmentViewCell
        let password = klockWirkerSetupTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! EnrollmentViewCell
        let confirmPassword = klockWirkerSetupTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as! EnrollmentViewCell
        
        klockWirker.emailAddress = emailAddress.enrollmentTextField.text!
        klockWirker.phoneNumber = phone.enrollmentTextField.text!
        klockWirker.password = password.enrollmentTextField.text!
        klockWirker.confirmPassword = confirmPassword.enrollmentTextField.text!
        
        return klockWirker
    }
    
    
    func displayAlert(message: String){
        
        let alertController = UIAlertController(title: "Setup", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    
    
    func submitButtonTapped(){
        
        if(doesKlockWirkerPasswordsMatch()){
            
            klockWirkService.registerKlockWirker(getCompletedKlockWirkerRegistration()) { (response: NSDictionary) in
                
                let tabBarController:KlockWirkTabBarController = KlockWirkTabBarController()
                    
                self.navigationController?.pushViewController(tabBarController, animated: false)
            }
        }
        else{
            
            displayAlert("Password mismatch")
        }
    }
    
    
    
    
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func setupTableViewProperties(){
        
        klockWirkerSetupTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func setupTableViewDelegates(){
        
        klockWirkerSetupTableView.delegate = self
        klockWirkerSetupTableView.dataSource = self
        klockWirkerSetupTableView.registerNib(UINib(nibName: "EnrollmentViewCell", bundle: nil), forCellReuseIdentifier: "enrollmentTableViewCell")
    }
    
    
    
    
    //MARK: TableView Delegates
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            
            return klockWirkerRegistrationFields.count
        }
        else{
            
            return klockWirkerLoginFields.count
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0) {
            
            let view = UIView()
            let label = UILabel()
            
            label.text = "Enter the email address and phone number you received in your registration email"
            label.textColor = UIColor.lightGrayColor()
        
            label.font = UIFont (name: "HelveticaNeue-LightItalic", size: 14)
            
            
            label.numberOfLines = 3
            label.frame = CGRectMake(20, 10, 330, 75)
         
            view.addSubview(label)
       
            return view
        }
        else if(section == 1){
            
            let view = UIView() // The width will be the same as the cell, and the height should be set in tableView:heightForRowAtIndexPath:
            let label = UILabel()
            label.text="Create you password"
            label.textColor = UIColor.lightGrayColor()
            label.font = UIFont (name: "HelveticaNeue-LightItalic", size: 14)
            label.frame = CGRectMake(20, 10, 330, 50)
         
            view.addSubview(label)
           
            return view
            
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch (section) {
            
            case 0:
                return 75
            
        case 1:
            return 50
            
        default:
            return 50
    
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var accountField = AccountSetupField()
        let cell:EnrollmentViewCell = klockWirkerSetupTableView.dequeueReusableCellWithIdentifier("enrollmentTableViewCell") as! EnrollmentViewCell
        
        switch (indexPath.section) {
            
        case 0:
            accountField = klockWirkerRegistrationFields.objectAtIndex(indexPath.row) as! AccountSetupField
            
        case 1:
            accountField = klockWirkerLoginFields.objectAtIndex(indexPath.row) as! AccountSetupField
            
        default:
            cell.textLabel?.text = "Other"
        }
        
        cell.bindCellDetail(accountField)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }


}
