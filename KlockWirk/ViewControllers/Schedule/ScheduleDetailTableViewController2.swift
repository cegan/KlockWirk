//
//  ScheduleDetailTableViewController2.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/3/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleDetailTableViewController2: UITableViewController {
    
    
    var scheduleSummaryFields = NSMutableArray()
    var scheduleToDisplay = Schedule()
    
    
    //MARK: View Initialization
    
    init(schedule: Schedule){
        
        super.init(nibName: "ScheduleDetailTableViewController2", bundle: nil);
        
        scheduleToDisplay       = schedule
        scheduleSummaryFields   = getScheduleSummaryFields()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        setupViewProperties()
        setupNavigationButtons()
        setupTableViewProperties()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Schedule Detail"
    }
    
    
    
    
    
    //MARK: Setup Methods
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedule Detail"
    }
    
    func setupTableViewProperties(){
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
    }
    
    func setupNavigationButtons(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonTapped")
    }
    
    
    
    
    //MARK: Events
    
    func doneButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: Utility Methods
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: NumberFormatter.formatDoubleToCurrency(scheduleToDisplay.goal), tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Achieved", val: NumberFormatter.formatDoubleToCurrency(scheduleToDisplay.achieved), tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: NumberFormatter.formatDoubleToPercent(scheduleToDisplay.KlockWirkerPercentage), tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift Start", val: DateUtilities.stringValueOfShiftDate(scheduleToDisplay.startDateTime), tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift End", val: DateUtilities.stringValueOfShiftDate(scheduleToDisplay.endDateTime), tag: 5))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 6))
        
        return scheduleSummarFieldsFields
    }

  
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scheduleSummaryFields.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let scheduleSummaryField = scheduleSummaryFields.objectAtIndex(indexPath.row) as! ScheduleSummaryField
        let cell:ScheduleSummaryTableViewCell = tableView.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell") as! ScheduleSummaryTableViewCell
        
        cell.bindCellDetails(scheduleSummaryField)
        
        if(scheduleSummaryField.tag == 6){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row){
            
            
        case 5:
            
            self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: scheduleToDisplay.klockWirkers,readOnly: true), animated: true)
            
        default:
            return
        }
    }
 

   
    
}
