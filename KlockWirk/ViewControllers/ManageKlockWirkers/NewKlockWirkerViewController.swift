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
        
        merchant = ApplicationInformation.getMerchant()!
        klockWirkerRegistrationFields = getKlockWirkerRegistrationFields()
    }
    
    
    func getKlockWirkerRegistrationFields() -> NSMutableArray{
        
        let klockWirkerRegistrationFields = NSMutableArray()
        
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "First Name", val: "", tag: 1))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Last Name", val: "", tag: 2))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Email Address", val: "", tag: 3))
        klockWirkerRegistrationFields.addObject(AccountSetupField(lbl: "Phone", val: "", tag: 4))
        
        return klockWirkerRegistrationFields
    }
    
    func getCompletedKlockWirkerRegistration() -> KlockWirker{
        
        let klockWirker = KlockWirker()
        
        let firstName = newKlockWirkerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! EnrollmentViewCell
        let lastName = newKlockWirkerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! EnrollmentViewCell
        let emailAddress = newKlockWirkerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! EnrollmentViewCell
        let phoneNumber = newKlockWirkerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! EnrollmentViewCell
        
        klockWirker.firstName = firstName.enrollmentTextField.text!
        klockWirker.lastName = lastName.enrollmentTextField.text!
        klockWirker.emailAddress = emailAddress.enrollmentTextField.text!
        klockWirker.phoneNumber = phoneNumber.enrollmentTextField.text!
        klockWirker.password = ""
        
        return klockWirker
    }
    
    
    func setupTableViewProperties(){
        
        newKlockWirkerTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func setupTableViewDelegates(){
        
        newKlockWirkerTableView.delegate = self
        newKlockWirkerTableView.dataSource = self
        newKlockWirkerTableView.registerNib(UINib(nibName: "EnrollmentViewCell", bundle: nil), forCellReuseIdentifier: "enrollmentTableViewCell")
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
    
        klockWirkService.addNewKlockWirker(getCompletedKlockWirkerRegistration()) { (response: NSDictionary) in
            
            self.merchant.klockWirkers.addObject(JSONUtilities.parseKlockWirker(response))
            
            ApplicationInformation.setMerchant(self.merchant)
            
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
        let cell:EnrollmentViewCell = newKlockWirkerTableView.dequeueReusableCellWithIdentifier("enrollmentTableViewCell") as! EnrollmentViewCell
       
        cell.bindCellDetail(accountField)
        
        return cell
  
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
}
