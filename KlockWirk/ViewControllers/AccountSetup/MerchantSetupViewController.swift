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
        
        let firstName = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! EnrollmentViewCell
        let lastName = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! EnrollmentViewCell
        let address = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! EnrollmentViewCell
        let city = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! EnrollmentViewCell
        let state = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 4, inSection: 0)) as! EnrollmentViewCell
        let zipCode = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 5, inSection: 0)) as! EnrollmentViewCell
        let phone = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 6, inSection: 0)) as! EnrollmentViewCell
        let email = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 7, inSection: 0)) as! EnrollmentViewCell
        let manager = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 8, inSection: 0)) as! EnrollmentViewCell
        let posSystem = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 9, inSection: 0)) as! EnrollmentViewCell
        let password = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 10, inSection: 0)) as! EnrollmentViewCell
        
        returnMerchant.firstName = firstName.enrollmentTextField.text!
        returnMerchant.lastName = lastName.enrollmentTextField.text!
        returnMerchant.address = address.enrollmentTextField.text!
        returnMerchant.city = city.enrollmentTextField.text!
        returnMerchant.state = state.enrollmentTextField.text!
        returnMerchant.zipCode = zipCode.enrollmentTextField.text!
        returnMerchant.phone = phone.enrollmentTextField.text!
        returnMerchant.email = email.enrollmentTextField.text!
        returnMerchant.manager = manager.enrollmentTextField.text!
        returnMerchant.posSystem = posSystem.enrollmentTextField.text!
        returnMerchant.password = password.enrollmentTextField.text!
        
        return returnMerchant
        
    }
    
    func getMerchantSetupFields() -> NSMutableArray{
        
        let merchantFields = NSMutableArray()
        
        merchantFields.addObject(AccountSetupField(lbl: "First Name", val: "", tag: 1))
        merchantFields.addObject(AccountSetupField(lbl: "Last Name", val: "", tag: 2))
        merchantFields.addObject(AccountSetupField(lbl: "Address", val: "", tag: 3))
        merchantFields.addObject(AccountSetupField(lbl: "City", val: "", tag: 4))
        merchantFields.addObject(AccountSetupField(lbl: "State", val: "", tag: 5))
        merchantFields.addObject(AccountSetupField(lbl: "ZipCode", val: "", tag: 6))
        merchantFields.addObject(AccountSetupField(lbl: "Phone", val: "", tag: 7))
        merchantFields.addObject(AccountSetupField(lbl: "Email", val: "", tag: 8))
        merchantFields.addObject(AccountSetupField(lbl: "Manager", val: "", tag: 9))
        merchantFields.addObject(AccountSetupField(lbl: "Pos System", val: "", tag: 10))
        merchantFields.addObject(AccountSetupField(lbl: "Password", val: "", tag: 11))
        merchantFields.addObject(AccountSetupField(lbl: "Confirm Password", val: "", tag: 12))
        
        return merchantFields
    }
    
    func submitButtonTapped(){
        
        merchantService.registerMerchant(getCompletedMerchantRegistration()) { (response: NSDictionary) in
            
            ApplicationInformation.setMerchant(JSONUtilities.parseMerchant(response))
            ApplicationInformation.setKlockWirkers([KlockWirker]())
            

            let tabBarController:MerchantTabBarController = MerchantTabBarController()
            
            self.navigationController?.pushViewController(tabBarController, animated: false)
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
            var view = UIView() // The width will be the same as the cell, and the height should be set in tableView:heightForRowAtIndexPath:
            var label = UILabel()
            label.text="My Details"
            //let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
            // button.addTarget(self, action: "visibleRow:", forControlEvents:.TouchUpInside)
            //label.setTranslatesAutoresizingMaskIntoConstraints(false)
            // button.setTranslatesAutoresizingMaskIntoConstraints(false)
            //button.setTitle("Test Title", forState: .Normal)
            // let views = ["label": label,"button":button,"view": view]
            view.addSubview(label)
            //view.addSubview(button)
            // var horizontallayoutContraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label]-60-[button]-10-|", options: .AlignAllCenterY, metrics: nil, views: views)
            // view.addConstraints(horizontallayoutContraints)
            
            // var verticalLayoutContraint = NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0)
            // view.addConstraint(verticalLayoutContraint)
            return view
        }
        return nil
        
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
