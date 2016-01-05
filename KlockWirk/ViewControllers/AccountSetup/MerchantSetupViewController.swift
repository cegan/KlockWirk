//
//  TestTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/8/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit


class MerchantSetupItem: NSObject{
    
    var sections:[String]           = []
    var items:[[AccountSetupField]] = []
    
    func addSection(section: String, item:[AccountSetupField]){
        
        sections    = sections + [section]
        items       = items + [item]
    }
}



class MerchantSetupItems: MerchantSetupItem {
    
    override init() {
        
        super.init()
    }
}





class MerchantSetupViewController: UITableViewController {
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
        }()
    
    var merchantSetupItems  = MerchantSetupItems()
    let merchantService     = MerchantServices()
    let klockWirkService    = KlockWirkerServices()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        merchantSetupItems = getMerchantSetupItems()
        
        setupViewProperties()
        setupTableViewProperties()
        setupNavigationButtons()
        setupActivityIndicator()
    }
    

    
    func endEditing(){
        
        view.endEditing(true)
    }
    
    func loadMerchantTabBarController(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let tabBarController:MerchantTabBarController = MerchantTabBarController()
        
        appDelegate.window!.rootViewController = tabBarController
    }
    
    
    
    //MARK: Setup Methods

    func setupTableViewProperties(){
        
        self.tableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
        self.tableView.registerNib(UINib(nibName: "SelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectionTableViewCell")
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
    
    
    
    //MARK: Utility Methods
    
    func getCompletedMerchantRegistration() -> Merchant{
        
        let returnMerchant = Merchant()
        
        let firstName = merchantSetupItems.items[0][0]
        let lastName = merchantSetupItems.items[0][1]
        let company = merchantSetupItems.items[0][2]
        let address = merchantSetupItems.items[0][3]
        let city = merchantSetupItems.items[0][4]
        let state = merchantSetupItems.items[0][5]
        let zipCode = merchantSetupItems.items[0][6]
        let phone = merchantSetupItems.items[0][7]
        let email = merchantSetupItems.items[0][8]
        let manager = merchantSetupItems.items[0][9]
        let password = merchantSetupItems.items[2][0]
        let confirmPassword = merchantSetupItems.items[2][1]
        let posSystem = getSelectedPOSSystem()
        
        returnMerchant.firstName = firstName.value!
        returnMerchant.lastName = lastName.value!
        returnMerchant.company = company.value!
        returnMerchant.address = address.value!
        returnMerchant.city = city.value!
        returnMerchant.state = state.value!
        returnMerchant.zipCode = zipCode.value!
        returnMerchant.phone = phone.value!
        returnMerchant.email = email.value!
        returnMerchant.manager = manager.value!
        returnMerchant.posSystemId = posSystem
        returnMerchant.password = password.value!
        returnMerchant.confirmPassword = confirmPassword.value!
        
        return returnMerchant
        
    }
    
    func getMerchantGeneralInformationFields() -> [AccountSetupField]{
        
        var merchantFields:[AccountSetupField] = []
        
        merchantFields.append(AccountSetupField(lbl: "First Name", val: "",type:.String, required:true, tag: 1))
        merchantFields.append(AccountSetupField(lbl: "Last Name", val: "",type:.String, required:true, tag: 2))
        merchantFields.append(AccountSetupField(lbl: "Company", val: "",type:.String, required:true, tag: 3))
        merchantFields.append(AccountSetupField(lbl: "Address", val: "", type:.String, required:true, tag: 4))
        merchantFields.append(AccountSetupField(lbl: "City", val: "", type:.String, required:true, tag: 5))
        merchantFields.append(AccountSetupField(lbl: "State", val: "", type:.String, required:true, tag: 6))
        merchantFields.append(AccountSetupField(lbl: "ZipCode", val: "", type:.String, required:true, tag: 7))
        merchantFields.append(AccountSetupField(lbl: "Phone", val: "", type:.String, required:true, tag: 8))
        merchantFields.append(AccountSetupField(lbl: "Email", val: "", type:.String, required:true, tag: 9))
        merchantFields.append(AccountSetupField(lbl: "Manager", val: "",type:.String, required:true, tag: 10))
       
        return merchantFields
    }

    func getPointOfSaleSystemFields() -> [AccountSetupField]{
        
        var POSFields:[AccountSetupField] = []
        
        POSFields.append(AccountSetupField(lbl: "Revel", val: "",type:.String, required:false, tag: 1))
        POSFields.append(AccountSetupField(lbl: "Clover", val: "",type:.String, required:false, tag: 2))
        POSFields.append(AccountSetupField(lbl: "Micros", val: "", type:.String, required:false, tag: 3))
        POSFields.append(AccountSetupField(lbl: "Square", val: "", type:.String, required:false, tag: 4))
        POSFields.append(AccountSetupField(lbl: "Shopkeep", val: "", type:.String, required:false, tag: 5))
        POSFields.append(AccountSetupField(lbl: "LightSpeed", val: "", type:.String, required:false, tag: 6))
        POSFields.append(AccountSetupField(lbl: "Aloha", val: "", type:.String, required:false, tag: 7))
        POSFields.append(AccountSetupField(lbl: "Squirrel", val: "", type:.String, required:false, tag: 8))
        POSFields.append(AccountSetupField(lbl: "Breadcrumb", val: "", type:.String, required:false, tag: 9))
        
       
        return POSFields
    }
    
    func getPasswordFields() -> [AccountSetupField]{
        
        var passwordFields:[AccountSetupField] = []
        
        passwordFields.append(AccountSetupField(lbl: "Password", val: "",type:.Password, required:true, tag: 1))
        passwordFields.append(AccountSetupField(lbl: "Confirm", val: "",type:.Password, required:true, tag: 2))
       
        return passwordFields
    }
    
    func displayAlert(message: String){
        
        let alertController = UIAlertController(title: "Setup", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func getSelectedPOSSystem() -> POSSystem{
        
        let allPOSSystems = merchantSetupItems.items[1]
        
        for posItem in allPOSSystems{
            
            if(posItem.isSelected){
                
                if let posSystem = POSSystem(rawValue: Int(posItem.value!)!) {
                    
                    return posSystem
                }
            }
        }
        
        return .None
    }
    
    func setSelectedPOSSystem(selectedIndexPath: NSIndexPath){
        
        let selectedItem    = merchantSetupItems.items[selectedIndexPath.section][selectedIndexPath.row]
        let allItems        = merchantSetupItems.items[selectedIndexPath.section]
        
        for posItem in allItems{
            
            posItem.isSelected = false;
        }
        selectedItem.value = String(selectedIndexPath.row + 1)
        selectedItem.isSelected = true;
        
        tableView.reloadData()
    }
    
    func doesMerchantPasswordsMatch() -> Bool{
        
        let m = getCompletedMerchantRegistration()
        
        if(m.password != m.confirmPassword){
            
            return false
        }
        
        return true
    }
    
    func getMerchantSetupItems() -> MerchantSetupItems{
        
        let merchantSetupItems = MerchantSetupItems()
        
        merchantSetupItems.addSection("Merchant Information", item: getMerchantGeneralInformationFields())
        merchantSetupItems.addSection("Point Of Sale System", item: getPointOfSaleSystemFields())
        merchantSetupItems.addSection("Password", item: getPasswordFields())
        
        
        return merchantSetupItems
    }
    
    
    
    
    //MARK: Event Handlers
    
    func submitButtonTapped(){
        
        endEditing()
        
        if(doesMerchantPasswordsMatch()){
            
            activityIndicator.startAnimating()
            
            merchantService.registerMerchant(getCompletedMerchantRegistration()) { (response: Merchant) in
                
                ApplicationInformation.setIsMerchant(true)
                
                self.loadMerchantTabBarController()
            }
        }
        else{
            
            displayAlert("Password does not match")
        }
    }
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    

    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return merchantSetupItems.sections.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return merchantSetupItems.sections[section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return merchantSetupItems.items[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        var accountSetupField = AccountSetupField()
        
        switch(indexPath.section){
            
            case 0:
                accountSetupField = merchantSetupItems.items[indexPath.section][indexPath.row]
                let cell:InputTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("InputTableViewCell") as! InputTableViewCell
                cell.bindCellDetail(accountSetupField)
                return cell
            
            case 1:
                
                accountSetupField = merchantSetupItems.items[indexPath.section][indexPath.row]
                let cell:SelectionTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("SelectionTableViewCell") as! SelectionTableViewCell
                cell.bindCellDetails(accountSetupField.defaluValue!)
                
                
                if(accountSetupField.isSelected){
                    
                    cell.setIsImageViewHidden(false)
                }
                else{
                    
                    cell.setIsImageViewHidden(true)
                }
                
            
            return cell
            
            case 2:
                accountSetupField = merchantSetupItems.items[indexPath.section][indexPath.row]
                let cell:InputTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("InputTableViewCell") as! InputTableViewCell
                cell.bindCellDetail(accountSetupField)
                return cell
            
            default:
                return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.section){
            
            case 1:
                setSelectedPOSSystem(indexPath)
            
            default:
                return
        }
    }

}
