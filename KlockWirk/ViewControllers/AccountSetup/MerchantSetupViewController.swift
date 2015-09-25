//
//  TestTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/8/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class MerchantSetupViewController: UITableViewController {
    
    
    var merchantSetupFields = NSMutableArray()
    let merchantService    = MerchantServices()
    let klockWirkService    = KlockWirkerServices()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
    
        setupTableViewProperties()
        setupNavigationButtons()
        
        merchantSetupFields = self.getMerchantSetupFields()
    }

    func displayActivityindicator(){
        
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
    }
    
    
    func endEditing(){
        
        view.endEditing(true)
    }
    
    func loadMerchantTabBarController(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let tabBarController:MerchantTabBarController = MerchantTabBarController()
        
        appDelegate.window!.rootViewController = tabBarController
    }

    func setupTableViewProperties(){
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerNib(UINib(nibName: "EnrollmentViewCell", bundle: nil), forCellReuseIdentifier: "enrollmentTableViewCell")
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
    
    func getCompletedMerchantRegistration() -> Merchant{
        
        let returnMerchant = Merchant()
        
        let firstName = merchantSetupFields.objectAtIndex(0) as! AccountSetupField
        let lastName = merchantSetupFields.objectAtIndex(1) as! AccountSetupField
        let address = merchantSetupFields.objectAtIndex(2) as! AccountSetupField
        let city = merchantSetupFields.objectAtIndex(3) as! AccountSetupField
        let state = merchantSetupFields.objectAtIndex(4) as! AccountSetupField
        let zipCode = merchantSetupFields.objectAtIndex(5) as! AccountSetupField
        let phone = merchantSetupFields.objectAtIndex(6) as! AccountSetupField
        let email = merchantSetupFields.objectAtIndex(7) as! AccountSetupField
        let manager = merchantSetupFields.objectAtIndex(8) as! AccountSetupField
        let posSystem = merchantSetupFields.objectAtIndex(9) as! AccountSetupField
        let password = merchantSetupFields.objectAtIndex(10) as! AccountSetupField
        
        returnMerchant.firstName = firstName.value!
        returnMerchant.lastName = lastName.value!
        returnMerchant.address = address.value!
        returnMerchant.city = city.value!
        returnMerchant.state = state.value!
        returnMerchant.zipCode = zipCode.value!
        returnMerchant.phone = phone.value!
        returnMerchant.email = email.value!
        returnMerchant.manager = manager.value!
        returnMerchant.posSystem = posSystem.value!
        returnMerchant.password = password.value!
        
        return returnMerchant
        
    }
    
    func getMerchantSetupFields() -> NSMutableArray{
        
        let merchantFields = NSMutableArray()
        
        merchantFields.addObject(AccountSetupField(lbl: "First Name", val: "",type:.String, tag: 1))
        merchantFields.addObject(AccountSetupField(lbl: "Last Name", val: "",type:.String, tag: 2))
        merchantFields.addObject(AccountSetupField(lbl: "Address", val: "", type:.String, tag: 3))
        merchantFields.addObject(AccountSetupField(lbl: "City", val: "", type:.String, tag: 4))
        merchantFields.addObject(AccountSetupField(lbl: "State", val: "", type:.String, tag: 5))
        merchantFields.addObject(AccountSetupField(lbl: "ZipCode", val: "", type:.String, tag: 6))
        merchantFields.addObject(AccountSetupField(lbl: "Phone", val: "", type:.String, tag: 7))
        merchantFields.addObject(AccountSetupField(lbl: "Email", val: "", type:.String, tag: 8))
        merchantFields.addObject(AccountSetupField(lbl: "Manager", val: "",type:.String, tag: 9))
        merchantFields.addObject(AccountSetupField(lbl: "Pos System", val: "", type:.String, tag: 10))
        merchantFields.addObject(AccountSetupField(lbl: "Password", val: "", type:.String, tag: 11))
        merchantFields.addObject(AccountSetupField(lbl: "Confirm Password", val: "", type:.String, tag: 12))
        
        return merchantFields
    }
    
    func submitButtonTapped(){
        
        endEditing()
        displayActivityindicator()
        
        merchantService.registerMerchant(getCompletedMerchantRegistration()) { (response: Merchant) in
            
            ApplicationInformation.setIsMerchant(true)
            
            self.loadMerchantTabBarController()
        }
    }
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0) {
            
            let view = UIView(frame: CGRectMake(20, 10, 330, 10))
            let label = UILabel(frame: CGRectMake(20, 10, 330, 40))
            
            label.text = "Enter the below information to register as a new merchant"
            label.textColor = UIColor.lightGrayColor()
            label.font = UIFont (name: "HelveticaNeue-LightItalic", size: 14)
            label.numberOfLines = 2
            
            view.addSubview(label)
            
            return view
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch (section) {
            
        case 0:
            return 80
            
        default:
            return 50
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return merchantSetupFields.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let accountField = merchantSetupFields.objectAtIndex(indexPath.row) as! AccountSetupField
        let cell:EnrollmentViewCell = self.tableView.dequeueReusableCellWithIdentifier("enrollmentTableViewCell") as! EnrollmentViewCell
        
   
        cell.bindCellDetail(accountField)
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
   
    
}
