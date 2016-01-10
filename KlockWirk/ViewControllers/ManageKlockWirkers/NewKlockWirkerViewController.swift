//
//  NewKlockWirkerViewController2.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/31/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class NewKlockWirkerViewController: UITableViewController {
    
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
        }()
    
    
    var merchant = Merchant()
    let klockWirkService = KlockWirkerServices()
    var klockWirkerRegistrationFields = NSMutableArray()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupNavigationButtons()
        setupTableViewDelegates()
        setupTableViewProperties()
        setupActivityIndicator()
        
        merchant = MerchantManager.sharedInstance.merchant
        klockWirkerRegistrationFields = getKlockWirkerRegistrationFields()
    }
    
    
    
    //MARK: Utility Methods
    
    func displayValidationError(validationError: String){
        
        let alert = UIAlertController(title: "Validation", message: validationError, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func validateKlockwirkerRegistration() -> Bool{
        
        let kw = getCompletedKlockWirkerRegistration()
        
        if(kw.firstName == "" || kw.lastName == "" || kw.phoneNumber == "" || kw.emailAddress == "" || !StringUtilities.isValidEmail(kw.emailAddress) || !StringUtilities.isPhoneNumberValid(kw.phoneNumber)){
            
            if(kw.firstName == ""){
                
                displayValidationError("First Name is required")
            }
            else if(kw.lastName == ""){
                
                displayValidationError("Last Name is required")
            }
            else if(kw.emailAddress == ""){
                
                displayValidationError("Email is required")
            }
                
            else if(!StringUtilities.isValidEmail(kw.emailAddress)){
                
                displayValidationError("Invalid email address")
            }
            else if(kw.phoneNumber == ""){
                
                displayValidationError("Phone is required")
            }
            else if(!StringUtilities.isPhoneNumberValid(kw.phoneNumber)){
                
                displayValidationError("Invalid phone number")
            }
            
            return false
        }
        
        return true
    }
    
    func getKlockWirkerRegistrationFields() -> NSMutableArray{
        
        let klockWirkerRegistrationFields = NSMutableArray()
        
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "First Name", val: "", type:.String, required:true, tag: 1))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Last Name", val: "", type:.String, required:true, tag: 2))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Email", val: "", type:.Email, required:true, tag: 3))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Phone", val: "", type:.Phone, required:true, tag: 4))
        
        return klockWirkerRegistrationFields
    }
    
    func getCompletedKlockWirkerRegistration() -> KlockWirker{
        
        let klockWirker = KlockWirker()
        
        let firstName = klockWirkerRegistrationFields.objectAtIndex(0) as! AccountSetupField
        let lastName = klockWirkerRegistrationFields.objectAtIndex(1) as! AccountSetupField
        let email = klockWirkerRegistrationFields.objectAtIndex(2) as! AccountSetupField
        let phone = klockWirkerRegistrationFields.objectAtIndex(3) as! AccountSetupField
        
        klockWirker.firstName = firstName.value!
        klockWirker.lastName = lastName.value!
        klockWirker.emailAddress = email.value!
        klockWirker.phoneNumber = phone.value!
        
        return klockWirker
    }
    
    
    
    //MARK: Setup Methods
    
    func setupTableViewProperties(){
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
    }
    
    func setupTableViewDelegates(){
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationButtons(){
        
        let submit = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = submit
    }
    
    func addButtonTapped(){
        
        tableView.endEditing(true)
        
        if(validateKlockwirkerRegistration()){
            
            activityIndicator.startAnimating()
            
            klockWirkService.addNewKlockWirker(getCompletedKlockWirkerRegistration()) { (response: KlockWirker) in
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "New KlockWirker"
    }
    
    func setupActivityIndicator () {
        
        self.activityIndicator.center       = view.center;
        activityIndicator.autoresizingMask  = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        self.view.addSubview(activityIndicator)
    }
    
    
    
    
    
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return klockWirkerRegistrationFields.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let accountField = klockWirkerRegistrationFields.objectAtIndex(indexPath.row) as! AccountSetupField
        let cell:InputTableViewCell = tableView.dequeueReusableCellWithIdentifier("InputTableViewCell") as! InputTableViewCell
        
        cell.bindCellDetail(accountField)
        
        return cell
        
    }
}
