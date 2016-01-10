//
//  KlockWirkerSetupViewController2.swift
//  KlockWirk
//
//  Created by Casey Egan on 11/29/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit


class KlockWirkerSetupItem: NSObject{
    
    var sections:[String]           = []
    var items:[[AccountSetupField]] = []
    
    func addSection(section: String, item:[AccountSetupField]){
        
        sections    = sections + [section]
        items       = items + [item]
    }
}



class KlockWirkerSetupItems: KlockWirkerSetupItem {
    
    override init() {
        
        super.init()
    }
}



class KlockWirkerSetupViewController: UITableViewController {
    
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    
    let klockWirkService = KlockWirkerServices()
    var klockWirkerSetupItems  = KlockWirkerSetupItems()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        klockWirkerSetupItems = getKlockWirkerSetupItems()
        
        setupViewProperties()
        setupNavigationButtons()
        setupTableViewProperties()
        setupActivityIndicator()
    }
    
    
    
    func getKlockWirkerSetupItems() -> KlockWirkerSetupItems{
        
        let klockwirkerSetupItems = KlockWirkerSetupItems()
        
        klockwirkerSetupItems.addSection("KlockWirker Information", item: getKlockWirkerInformationFields())
        klockwirkerSetupItems.addSection("Password", item: getPasswordFields())
        
        return klockwirkerSetupItems
    }
    
    
    func getKlockWirkerInformationFields() -> [AccountSetupField]{
        
        var fields:[AccountSetupField] = []
        
        fields.append(AccountSetupField(lbl: "Email", val: "",type:.Email, required:true, tag: 1))
        fields.append(AccountSetupField(lbl: "Phone", val: "",type:.Phone, required:true, tag: 2))
       
        return fields
    }
    
    func getPasswordFields() -> [AccountSetupField]{
        
        var passwordFields:[AccountSetupField] = []
        
        passwordFields.append(AccountSetupField(lbl: "Password", val: "",type:.Password, required:true, tag: 1))
        passwordFields.append(AccountSetupField(lbl: "Confirm", val: "",type:.Password, required:true, tag: 2))
        
        return passwordFields
    }
    
    
    func doesKlockWirkerPasswordsMatch() -> Bool{
        
        let kw = getCompletedKlockWirkerRegistration()
        
        if(kw.password != kw.confirmPassword){
            
            return false
        }
        
        return true
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
    
    func setupActivityIndicator () {
        
        self.activityIndicator.center       = view.center;
        activityIndicator.autoresizingMask  = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        self.view.addSubview(activityIndicator)
    }
    
    

    
    func getCompletedKlockWirkerRegistration() -> KlockWirker{
        
        let klockWirker = KlockWirker()
        
        let emailAddress    = klockWirkerSetupItems.items[0][0]
        let phone           = klockWirkerSetupItems.items[0][1]
        let password        = klockWirkerSetupItems.items[1][0]
        let confirmPassword = klockWirkerSetupItems.items[1][1]
        
        klockWirker.emailAddress    = emailAddress.value!
        klockWirker.phoneNumber     = phone.value!
        klockWirker.password        = password.value!
        klockWirker.confirmPassword = confirmPassword.value!
        
        return klockWirker
    }
    
    func displayAlert(message: String, title:String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func submitButtonTapped(){
        
        tableView.endEditing(true)
        
        if(doesKlockWirkerPasswordsMatch()){
            
            activityIndicator.startAnimating()
            
            klockWirkService.registerKlockWirker(getCompletedKlockWirkerRegistration()) { (response: NSDictionary) in
                
                self.activityIndicator.stopAnimating()
                
                if let statusCode = response.objectForKey("statusCode"){
                    
                    if(statusCode as! Int == HTTPStatusCodes.HTTPNotFound){
                        
                        self.displayAlert("Please try again or email support at support@klockwirk.com", title: "User Not Found")
                    }
                }
                else{
                    
                    let tabBarController:KlockWirkTabBarController = KlockWirkTabBarController()
                    
                    ApplicationInformation.setIsKlockWirker(true)
                    
                    self.navigationController?.pushViewController(tabBarController, animated: false)
                }
            }
        }
        else{
            
            displayAlert("Password mismatch", title: "KlockWirker Registration")
        }
    }
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func setupTableViewProperties(){
        
        self.tableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
    }
    
    
    
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return klockWirkerSetupItems.sections.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return klockWirkerSetupItems.sections[section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return klockWirkerSetupItems.items[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var accountSetupField = AccountSetupField()
        
        switch(indexPath.section){
            
        case 0:
            accountSetupField = klockWirkerSetupItems.items[indexPath.section][indexPath.row]
            let cell:InputTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("InputTableViewCell") as! InputTableViewCell
            cell.bindCellDetail(accountSetupField)
            return cell
            
        case 1:
            
            accountSetupField = klockWirkerSetupItems.items[indexPath.section][indexPath.row]
            let cell:InputTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("InputTableViewCell") as! InputTableViewCell
            cell.bindCellDetail(accountSetupField)
            
            return cell
            
            
        default:
            return UITableViewCell()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
