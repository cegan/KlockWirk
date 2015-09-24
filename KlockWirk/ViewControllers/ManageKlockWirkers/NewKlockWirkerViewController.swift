//
//  NewKlockWirkerViewController2.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/8/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class NewKlockWirkerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate   {

    
    var merchant = Merchant()
    let klockWirkService = KlockWirkerServices()
    var klockWirkerRegistrationFields = NSMutableArray()
    
    @IBOutlet weak var newKlockWirkerTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupNavigationButtons()
        setupTableViewDelegates()
        setupTableViewProperties()
        
        merchant = MerchantManager.sharedInstance.merchant
        klockWirkerRegistrationFields = getKlockWirkerRegistrationFields()
    }
    
    
    
    //MARK: Utility Methods
    
    func getKlockWirkerRegistrationFields() -> NSMutableArray{
        
        let klockWirkerRegistrationFields = NSMutableArray()
        
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "First Name", val: "", type:.String, tag: 1))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Last Name", val: "", type:.String, tag: 2))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Email", val: "", type:.Email, tag: 3))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Phone", val: "", type:.Phone, tag: 4))
        
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
        
        newKlockWirkerTableView.tableFooterView = UIView(frame: CGRectZero)
        newKlockWirkerTableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
    }
    
    func setupTableViewDelegates(){
        
        newKlockWirkerTableView.delegate = self
        newKlockWirkerTableView.dataSource = self
    }
    
    func setupNavigationButtons(){
        
        let submit = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = submit
    }

    func addButtonTapped(){
        
        newKlockWirkerTableView.endEditing(true)
        
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
    
        klockWirkService.addNewKlockWirker(getCompletedKlockWirkerRegistration()) { (response: KlockWirker) in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Add KlockWirker"
    }
    
    
    
    
    //MARK: TableView Delegates
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return klockWirkerRegistrationFields.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0) {
            
            let view = UIView()
            let label = UILabel()
            
            label.text = "Enter the below information to setup a new KlockWirker"
            label.textColor = UIColor.lightGrayColor()
            
            label.font = UIFont (name: "HelveticaNeue-LightItalic", size: 14)
            
            
            label.numberOfLines = 2
            label.frame = CGRectMake(20, 10, 330, 30)
            
            view.addSubview(label)
            
            return view
        }
       
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let accountField = klockWirkerRegistrationFields.objectAtIndex(indexPath.row) as! AccountSetupField
        let cell:InputTableViewCell = newKlockWirkerTableView.dequeueReusableCellWithIdentifier("InputTableViewCell") as! InputTableViewCell
       
        cell.bindCellDetail(accountField)
        
        return cell
  
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
}
