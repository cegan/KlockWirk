//
//  AddScheduleTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/11/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit




class AddScheduleTableViewController: UITableViewController, ShiftStartDateWasSelectedDelegate, ShiftEndDateWasSelectedDelegate{
    

    var dateWasSelected     = false
    var shiftStartDate      = NSDate()
    var shiftEndDate        = NSDate()
    
    let datePicker          = DatePicker(style: UITableViewStyle.Grouped)
    let completedSchedule   = Schedule()
    var merchant            = Merchant()
    let scheduleService     = SchedulService()
    var scheduleFields      = NSMutableArray()
    
    
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        merchant = MerchantManager.sharedInstance.merchant
        merchant.resetSelectedKlockWirkers()
        scheduleFields = getScheduleFields()
        
        setupTableViewProperties()
        setupNavigationButtons()
        
        datePicker.shiftStartDateSelectedDelegate = self
        datePicker.shiftEndDateSelectedDelegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "New Schedule"
        self.tableView.reloadData()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.tableView.endEditing(true)
    }
    
   
    
    
    
    
    //MARK: Date Picker Delegates
    
    func didSelectShiftStartDate(date: NSDate){
        
        dateWasSelected = true
        shiftStartDate = DateUtilities.getFormatedDateWithoutSeconds(date)
    }
    
    func didSelectShiftEndDate(date: NSDate){
        
        dateWasSelected = true
        shiftEndDate = DateUtilities.getFormatedDateWithoutSeconds(date)
    }
    
    
    
    
    
    //MARK: Setup Methods
    
    func setupTableViewProperties(){
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerNib(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        tableView.registerNib(UINib(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTableViewCell")
        tableView.registerNib(UINib(nibName: "SelectedShiftTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectedShiftTableViewCell")
    }
    
    func setupNavigationButtons(){
        
        let add = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = add
    }
    
    func addButtonTapped(){
        
        scheduleService.addSchedule(getCompletedSchedule(), merchantId: ApplicationInformation.getMerchantId()) { (response: Schedule) in
            
            MerchantManager.sharedInstance.merchant.schedules.append(response)

            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    //MARK: Utility Methods
    
    func getScheduleFields() -> NSMutableArray{
        
        let scheduleFields = NSMutableArray()
        
        scheduleFields.addObject(AccountSetupField(lbl: "Percent", val: "", type:.Percent, required:true, tag: 1))
        scheduleFields.addObject(AccountSetupField(lbl: "Goal", val: "",type:.Currency, required:true, tag: 2))
        scheduleFields.addObject(AccountSetupField(lbl: "Shift", val: "",type:.String, required:true, tag: 3))
        scheduleFields.addObject(AccountSetupField(lbl: "KlockWirkers", val: "", type:.String, required:true, tag: 4))
        
        return scheduleFields
    }
    
    func getCompletedSchedule() -> Schedule{
        
        let schedule = Schedule()
        
        let percent     = scheduleFields.objectAtIndex(0) as! AccountSetupField
        let line        = scheduleFields.objectAtIndex(1) as! AccountSetupField
        let startDate   = shiftStartDate
        let endDate     = shiftEndDate
        
        schedule.KlockWirkerPercentage  = Double(percent.value!)!
        schedule.line                   = Double(line.value!)!
        schedule.startDateTime          = startDate
        schedule.endDateTime            = endDate
        
        for kw in merchant.klockWirkers {
            
            if(kw.isSelected == true){
                
                schedule.klockWirkers.append(kw)
            }
            
            //kw.isSelected = false
        }
        
        return schedule
    }
    
    func cancelTableViewEditing(shouldCancel: Bool){
        
        self.tableView.endEditing(shouldCancel)
    }
    
    
    
    
    //MARK: TableView Delegates
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(dateWasSelected){
            
            if(indexPath.row == 2){
                
                return 125
            }
            
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
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
                
                if(dateWasSelected){
                    
                    cell = tableView.dequeueReusableCellWithIdentifier("SelectedShiftTableViewCell", forIndexPath: indexPath) as! SelectedShiftTableViewCell
                    (cell as! SelectedShiftTableViewCell).bindCellDetil(DateUtilities.stringValueOfShiftDate(shiftStartDate), shiftEnd: DateUtilities.stringValueOfShiftDate(shiftEndDate))
                }
                else{
                    
                    cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
                    (cell as! ScheduleTableViewCell).bindCellDetail(accountField)
                }
            
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
            self.navigationController?.pushViewController(datePicker, animated: true)
            
        case 3:
            cancelTableViewEditing(false)
            self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: merchant.klockWirkers, readOnly: ApplicationInformation.isReadOnly()), animated: true)
            
        default:
            return
            
    }
}

    
}
