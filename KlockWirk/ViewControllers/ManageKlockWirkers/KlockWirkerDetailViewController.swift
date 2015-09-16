//
//  KlockWirkerDetailViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/21/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerDetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var klockWirkerDetailTableView: UITableView!
    
    var klockWirkerDetail = KlockWirker()
    var klockWirkerFields = NSMutableArray()
    
    
    init(klockWirker: KlockWirker){
        
        super.init(nibName: "KlockWirkerDetailViewController", bundle: nil);
        
        klockWirkerDetail = klockWirker
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        klockWirkerFields = getKlockWirkerFields()
        
        setupTableViewProperties()
        setupTableViewDelegates()
    }
    
    
    
    //MARK: Setup Methods
    
    func setupTableViewDelegates(){
        
        klockWirkerDetailTableView.delegate = self
        klockWirkerDetailTableView.dataSource = self
    }
    
    func setupTableViewProperties(){
        
        klockWirkerDetailTableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
    }
    
    
    //MARK: Utility Methods
    
    func getKlockWirkerFields() -> NSMutableArray{
        
        let klockWirkerFields = NSMutableArray()
        
        klockWirkerFields.addObject(AccountSetupField(lbl: "First Name", val: klockWirkerDetail.firstName, tag: 1))
        klockWirkerFields.addObject(AccountSetupField(lbl: "Last Name", val: klockWirkerDetail.lastName, tag: 2))
        klockWirkerFields.addObject(AccountSetupField(lbl: "Email", val: klockWirkerDetail.emailAddress, tag: 3))
        klockWirkerFields.addObject(AccountSetupField(lbl: "Phone", val: klockWirkerDetail.phoneNumber, tag: 4))
       
        return klockWirkerFields
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
