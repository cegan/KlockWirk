//
//  KlockWirkerDetailViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/21/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerDetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
        }()
    
    
    @IBOutlet weak var klockWirkerDetailTableView: UITableView!
    
    let klockWirkerService = KlockWirkerServices()
    let merchantService = MerchantServices()
    
    var klockWirkerIndex  = 0
    var klockWirkerDetail = KlockWirker()
    var klockWirkerFields = NSMutableArray()
    
    
    init(klockWirker: KlockWirker, index: Int){
        
        super.init(nibName: "KlockWirkerDetailViewController", bundle: nil);
        
        klockWirkerDetail = klockWirker
        klockWirkerIndex  = index
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        klockWirkerFields = getKlockWirkerFields()
        
        setupViewProperties()
        setupTableViewProperties()
        setupNavigationBar()
        setupTableViewDelegates()
        setupActivityIndicator()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        klockWirkerDetailTableView.endEditing(true)
        
        if(isModified()){
            
            let klockWirker = getUpdateKlockWirker()
            
            ApplicationInformation.replaceKlockWirker(klockWirker, index: klockWirkerIndex)
            
            klockWirkerService.updateKlockWirker(klockWirker) { (response: NSDictionary) in
                
            }
        }
    }
    
    


    
    
    //MARK: Setup Methods
    
    func setupViewProperties(){
        
        navigationItem.title = klockWirkerDetail.firstName + " " + klockWirkerDetail.lastName
    }
    
    func setupTableViewDelegates(){
        
        klockWirkerDetailTableView.delegate = self
        klockWirkerDetailTableView.dataSource = self
    }
    
    func setupTableViewProperties(){
        
        klockWirkerDetailTableView.tableFooterView = UIView(frame: CGRectZero)
        klockWirkerDetailTableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
    }
    
    func setupNavigationBar(){
        
        if(!ApplicationInformation.isReadOnly()){

            let deleteKlockWirker = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action: "deleteButtonTapped")
            self.navigationItem.rightBarButtonItem = deleteKlockWirker
        }
    }
    
    func setupActivityIndicator () {
        
        self.activityIndicator.center       = view.center;
        activityIndicator.autoresizingMask  = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        self.view.addSubview(activityIndicator)
    }
    
    
    

    
    //MARK: Utility Methods
    
    func isModified() -> Bool{
        
        let firstName = klockWirkerFields.objectAtIndex(0) as! AccountSetupField
        let lastName = klockWirkerFields.objectAtIndex(1) as! AccountSetupField
        let email = klockWirkerFields.objectAtIndex(2) as! AccountSetupField
        let phone = klockWirkerFields.objectAtIndex(3) as! AccountSetupField
        
        
        if(firstName.value == klockWirkerDetail.firstName &&
            lastName.value == klockWirkerDetail.lastName &&
            email.value == klockWirkerDetail.emailAddress &&
            phone.value == klockWirkerDetail.phoneNumber){
                
                return false
        }
        
        
        return true;
        
    }
    
    func getKlockWirkerFields() -> NSMutableArray{
        
        let klockWirkerFields = NSMutableArray()
        
        klockWirkerFields.addObject(AccountSetupField(lbl: "First Name", val: klockWirkerDetail.firstName, type:.String, required:true, tag: 1))
        klockWirkerFields.addObject(AccountSetupField(lbl: "Last Name", val: klockWirkerDetail.lastName, type:.String, required:true, tag: 2))
        klockWirkerFields.addObject(AccountSetupField(lbl: "Email", val: klockWirkerDetail.emailAddress, type:.String, required:true, tag: 3))
        klockWirkerFields.addObject(AccountSetupField(lbl: "Phone", val: klockWirkerDetail.phoneNumber, type:.String, required:true, tag: 4))
       
        return klockWirkerFields
    }
    
    func getUpdateKlockWirker() -> KlockWirker{
        
        let firstName = klockWirkerFields.objectAtIndex(0) as! AccountSetupField
        let lastName = klockWirkerFields.objectAtIndex(1) as! AccountSetupField
        let email = klockWirkerFields.objectAtIndex(2) as! AccountSetupField
        let phone = klockWirkerFields.objectAtIndex(3) as! AccountSetupField
        
    
        klockWirkerDetail.firstName = firstName.value!
        klockWirkerDetail.lastName = lastName.value!
        klockWirkerDetail.emailAddress = email.value!
        klockWirkerDetail.phoneNumber = phone.value!
        
        return klockWirkerDetail
    }
    
    func deleteKlockWirker(){
        
        activityIndicator.startAnimating()
        ApplicationInformation.removeKlockWirker(self.self.klockWirkerDetail, index: 0)
        
        klockWirkerService.deleteKlockWirker(klockWirkerDetail.klockWirkerId) { (response:NSDictionary) in
            
            self.merchantService.getMerchant(ApplicationInformation.getMerchantId()) {(response: Merchant) in
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func deleteButtonTapped(){
        
        let optionMenu = UIAlertController(title: nil, message: "Confirm", preferredStyle: .ActionSheet)
        
        
        let deleteAction = UIAlertAction(title: "Delete KlockWirker", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
            self.deleteKlockWirker()
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    
    //MARK: TableView Delegates
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.klockWirkerFields.count
     }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let klockWirkerField = klockWirkerFields.objectAtIndex(indexPath.row) as! AccountSetupField
        let cell:InputTableViewCell = tableView.dequeueReusableCellWithIdentifier("InputTableViewCell", forIndexPath: indexPath) as! InputTableViewCell
        
        
        cell.bindCellDetail(klockWirkerField)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        switch(indexPath.row){
//            
//        case 0:
//            cancelTableViewEditing(true)
//            
//        case 1:
//            cancelTableViewEditing(true)
//            
//        case 2:
//            cancelTableViewEditing(false)
//            self.navigationController?.pushViewController(DatePickerViewController(), animated: true)
//            
//        case 3:
//            cancelTableViewEditing(false)
//            self.navigationController?.pushViewController(DatePickerViewController(), animated: true)
//            
//        case 4:
//            cancelTableViewEditing(false)
//            self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(merchant: merchant), animated: true)
//            
//        default:
//            return
//            
//        }
        
    }
}
