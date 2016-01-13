//
//  ForgotPasswordViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/6/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class LoginResetItem: NSObject{
    
    var sections:[String]           = []
    var items:[[AccountSetupField]] = []
    
    func addSection(section: String, item:[AccountSetupField]){
        
        sections    = sections + [section]
        items       = items + [item]
    }
}



class LoginResetItems: LoginResetItem {
    
    override init() {
        
        super.init()
    }
}

class ForgotPasswordViewController: UITableViewController {
    
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
    }()
    

    let klockWirkService = KlockWirkerServices()
    var loginResetItems  = LoginResetItems()
    
    
    
    init(){
        
        super.init(nibName: "ForgotPasswordViewController", bundle: nil);
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func getLoginResetItems() -> LoginResetItems{
        
        let loginResetItems = LoginResetItems()
        
        loginResetItems.addSection("User Information", item: getUserInformationFields())
        loginResetItems.addSection("New Password", item: getPasswordFields())
        
        return loginResetItems
    }
    
    func getUserInformationFields() -> [AccountSetupField]{
        
        var fields:[AccountSetupField] = []
        
        fields.append(AccountSetupField(lbl: "Email", val: "",type:.String, required:true, tag: 1))
        fields.append(AccountSetupField(lbl: "Phone", val: "",type:.String, required:true, tag: 2))
        
        return fields
    }
    
    func getPasswordFields() -> [AccountSetupField]{
        
        var passwordFields:[AccountSetupField] = []
        
        passwordFields.append(AccountSetupField(lbl: "Password", val: "",type:.Password, required:true, tag: 1))
        passwordFields.append(AccountSetupField(lbl: "Confirm", val: "",type:.Password, required:true, tag: 2))
        
        return passwordFields
    }
    
    func getCompletedLoginReset() -> KlockWirker{
        
        let klockWirker = KlockWirker()
        
        let emailAddress    = loginResetItems.items[0][0]
        let phone           = loginResetItems.items[0][1]
        let password        = loginResetItems.items[1][0]
        let confirmPassword = loginResetItems.items[1][1]
        
        klockWirker.emailAddress    = emailAddress.value!
        klockWirker.phoneNumber     = phone.value!
        klockWirker.password        = password.value!
        klockWirker.confirmPassword = confirmPassword.value!
        
        return klockWirker
    }

    
       
    
    //MARK: UI Setup
    
    func setupViewProperties(){
        
        self.title = "Password Reset"
    }
    
    func setupNavigationButtons(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: UIBarButtonItemStyle.Plain, target: self, action: "resetButtonTapped")
    }
    
    func setupTableViewProperties(){
        
        tableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
    }
    
    func setupActivityIndicator () {
        
        self.activityIndicator.center       = view.center;
        activityIndicator.autoresizingMask  = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        self.view.addSubview(activityIndicator)
    }
    
   
    
    
    //MARK: Utility Methods
    
    func doPasswordsMatch() -> Bool{
        
        let loginReset = getCompletedLoginReset()
        
        if(loginReset.password != loginReset.confirmPassword){
            
            return false
        }
        
        return true
    }
    
    func displayAlert(message: String, title: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    
    
    //MARK: Events
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resetButtonTapped(){
        
        self.tableView.endEditing(true)
        
        if(doPasswordsMatch()){
            
            activityIndicator.startAnimating()
            
            klockWirkService.resetUserPassword(getCompletedLoginReset()) { (response: Int) in
                
                self.activityIndicator.stopAnimating()
                
                if(response == HTTPStatusCodes.HTTPNotFound){
                    
                    self.displayAlert("Please try again or email support at support@klockwirk.com", title: "Password Reset")
                }
                else if(response == HTTPStatusCodes.HTTPUnauthorized){
                    
                    self.displayAlert("Your device is not registered. Please email support@klockwirk.com to change your password.",title: "Password Reset")
                }
                else{
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
        else{
            
            displayAlert("Password mismatch",title: "Password Reset")
        }
    }
    
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loginResetItems = getLoginResetItems()
        
        setupViewProperties()
        setupTableViewProperties()
        setupNavigationButtons()
        setupActivityIndicator()
    }

    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return loginResetItems.sections.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return loginResetItems.sections[section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return loginResetItems.items[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var accountSetupField = AccountSetupField()
        
        switch(indexPath.section){
            
        case 0:
            accountSetupField = loginResetItems.items[indexPath.section][indexPath.row]
            let cell:InputTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("InputTableViewCell") as! InputTableViewCell
            cell.bindCellDetail(accountSetupField)
            return cell
            
        case 1:
            
            accountSetupField = loginResetItems.items[indexPath.section][indexPath.row]
            let cell:InputTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("InputTableViewCell") as! InputTableViewCell
            cell.bindCellDetail(accountSetupField)
            
            return cell
            
            
        default:
            return UITableViewCell()
        }
    }
    
}
