//
//  AddScheduleTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/11/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class AddScheduleTableViewController: UITableViewController {
    

    let completedSchedule = Schedule()
    
    var merchant = Merchant()
    let scheduleService = SchedulService()
    var scheduleFields = NSMutableArray()
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        merchant = ApplicationInformation.getMerchant()!
        scheduleFields = getScheduleFields()
        
        setupViewProperties()
        setupTableViewProperties()
        setupNavigationButtons()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Add Schedule"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.tableView.endEditing(true)
    }
    
    
    
    func setupViewProperties(){
        
        
    }
 
    func setupTableViewProperties(){
        
        tableView.registerNib(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        tableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
    }
    
    func setupNavigationButtons(){
        
        let submit = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: "submitButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = submit
    }
    
    func submitButtonTapped(){
        
        let schedule = getCompletedSchedule()
        
        scheduleService.addSchedule(schedule, merchantId: ApplicationInformation.getMerchantId()) { (response: NSDictionary) in
            
            self.merchant.schedules.addObject(JSONUtilities.parseMerchantSchedule(response))
            
            ApplicationInformation.setMerchant(self.merchant)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: Utility Methods
    
    func getScheduleFields() -> NSMutableArray{
        
        let scheduleFields = NSMutableArray()
        
        scheduleFields.addObject(AccountSetupField(lbl: "Percent", val: "", tag: 1))
        scheduleFields.addObject(AccountSetupField(lbl: "Goal", val: "", tag: 2))
        scheduleFields.addObject(AccountSetupField(lbl: "Start Date", val: "", tag: 3))
        scheduleFields.addObject(AccountSetupField(lbl: "End Date", val: "", tag: 4))
        scheduleFields.addObject(AccountSetupField(lbl: "KlockWirkers", val: "", tag: 5))
        
        return scheduleFields
    }
    
    func getCompletedSchedule() -> Schedule{
        
        
        let schedule = Schedule()
        
        let percent = scheduleFields.objectAtIndex(0) as! AccountSetupField
        let line = scheduleFields.objectAtIndex(1) as! AccountSetupField
        //let startDate = scheduleFields.objectAtIndex(2) as! AccountSetupField
        //let endDate = scheduleFields.objectAtIndex(3) as! AccountSetupField
        let startDate = NSDate()
        let endDate = NSDate()
        
        schedule.KlockWirkerPercentage = Double(percent.value!)!
        schedule.line = Double(line.value!)!
        schedule.startDateTime = startDate
        schedule.endDateTime = endDate
        
        for kw in merchant.klockWirkers {
            
            if(kw.isSelected == true){
                
                schedule.klockWirkers.addObject(kw)
            }
        }
        
        return schedule
    }
    
    func cancelTableViewEditing(shouldCancel: Bool){
        
        self.tableView.endEditing(shouldCancel)
    
    }
    
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.scheduleFields.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell :UITableViewCell!
        
        let accountField = scheduleFields.objectAtIndex(indexPath.row) as! AccountSetupField
       
        switch(indexPath.row){
            
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier("InputTableViewCell", forIndexPath: indexPath) as! InputTableViewCell
                (cell as! InputTableViewCell).bindCellDetail(accountField)
            
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("InputTableViewCell", forIndexPath: indexPath) as! InputTableViewCell
                (cell as! InputTableViewCell).bindCellDetail(accountField)
                           
            case 2:
                cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
                (cell as! ScheduleTableViewCell).bindCellDetail(accountField)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            case 3:
                cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
                (cell as! ScheduleTableViewCell).bindCellDetail(accountField)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            case 4:
                cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
                (cell as! ScheduleTableViewCell).bindCellDetail(accountField)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell", forIndexPath: indexPath)
        }
    
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
    
        return cell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row){
            
        case 0:
            cancelTableViewEditing(true)
            
        case 1:
            cancelTableViewEditing(true)
            
        case 2:
            cancelTableViewEditing(false)
            self.navigationController?.pushViewController(DatePickerViewController(), animated: true)
            
        case 3:
            cancelTableViewEditing(false)
            self.navigationController?.pushViewController(DatePickerViewController(), animated: true)
            
        case 4:
            cancelTableViewEditing(false)
            self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(merchant: merchant), animated: true)
            
        default:
            return
            
    }
        
}

    
}
