//
//  AddScheduleTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/11/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class AddScheduleTableViewController: UITableViewController {
    
    let scheduleService = SchedulService()
    var scheduleFields = NSMutableArray()
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
    
    
    
    func setupViewProperties(){
        
        
    }
 
    func setupTableViewProperties(){
        
        //tableView.registerNib(UINib(nibName: "EnrollmentViewCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ScheduleCell");
    }
    
    func setupNavigationButtons(){
        
        let submit = UIBarButtonItem(title: "Submit", style: UIBarButtonItemStyle.Plain, target: self, action: "submitButtonTapped")
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = submit
    }
    
    func submitButtonTapped(){
        
        
        let schedule = Schedule()
        
        let kw = KlockWirker()
        
        kw.klockWirkerId = 31
        
        schedule.KlockWirkerPercentage = 20
        schedule.dateCreated = NSDate()
        schedule.startDateTime = NSDate()
        schedule.endDateTime = NSDate()
        
        
        schedule.klockWirkers.addObject(kw)
        
        scheduleService.addSchedule(schedule, merchantId: ApplicationInformation.getMerchantId()) { (response: NSDictionary) in
            
        }
        
    }
    
    func cancelButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: Utility Methods
    
    func getScheduleFields() -> NSMutableArray{
        
        let scheduleFields = NSMutableArray()
        
        scheduleFields.addObject(AccountSetupField(lbl: "Start Date", val: "", tag: 1))
        scheduleFields.addObject(AccountSetupField(lbl: "End Date", val: "", tag: 2))
        scheduleFields.addObject(AccountSetupField(lbl: "Percentage", val: "", tag: 3))
        scheduleFields.addObject(AccountSetupField(lbl: "KlockWirkers", val: "", tag: 4))
        
        return scheduleFields
    }
    
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.scheduleFields.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let accountField = scheduleFields.objectAtIndex(indexPath.row) as! AccountSetupField
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell", forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.None
    
        
        cell.textLabel?.text = accountField.defaluValue
        
        return cell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.navigationController?.pushViewController(DatePickerViewController(), animated: true)
    }

    
}
