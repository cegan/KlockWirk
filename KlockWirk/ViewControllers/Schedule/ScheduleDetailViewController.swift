//
//  ScheduleDetailViewController2.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/6/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleDetailViewController: UITableViewController {
    
    let activityIndicator   = UserinterfaceUtilities.ActivityIndicator()
    let posSalesService     = PosSalesService()
    let scheduleService     = SchedulService()
    let merchantService     = MerchantServices()
    var isModal             = false
    
    var selectedSchedule        = Schedule()
    var scheduleSummaryFields   = NSMutableArray()
    
 
    
    
    //MARK: View Initializers
    
    init(schedule: Schedule){
        
        super.init(nibName: "ScheduleDetailViewController", bundle: nil);
        
        selectedSchedule = schedule
        isModal          = false
    }
    
    init(schedule: Schedule, initAsModal: Bool){
        
        super.init(nibName: "ScheduleDetailViewController", bundle: nil);
        
        selectedSchedule    = schedule
        isModal             = initAsModal
    }

    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    


    
    
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scheduleSummaryFields = getScheduleSummaryFields()
        
        loadKlockWirkersOnSchedule()
        setupViewProperties()
        setupTableViewRefresh()
        setupTableViewProperties()
        setupNavigationBar()
        setupActivityIndicator()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Schedule Detail"
        
    }

 
    
    
    //MARK: Setup Methods
    
    func setupNavigationBar(){
        
        if(isModal){
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissScheduleDetail")
        }
        else{
            
            if(!ApplicationInformation.isReadOnly()){
                
                let deleteSchedule = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action: "deleteScheduleConfirmation")
                self.navigationItem.rightBarButtonItem = deleteSchedule
            }
        }
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedule Detail"
    }
    
    func setupTableViewProperties(){
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
        tableView.registerNib(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "TestTableViewCell")
        tableView.registerNib(UINib(nibName: "ChartTableViewCell", bundle: nil), forCellReuseIdentifier: "ChartTableViewCell")
        tableView.registerNib(UINib(nibName: "GoalReachedTableViewCell", bundle: nil), forCellReuseIdentifier: "GoalReachedTableViewCell")
    }
    
    func setupTableViewRefresh(){
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
    }
    
    func setupActivityIndicator () {
        
        self.activityIndicator.center = view.center;
        self.view.addSubview(activityIndicator)
    }
    
    
    
    
    
    
    
    //MARK: Utility Methods
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        if(ApplicationInformation.isMerchant()){
            
            return getMerchantSummaryFields()
        }
        else{
            
            return getKlockWirkerSummaryFields()
        }
    }
    
    func getMerchantSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        if(selectedSchedule.hasGoalBeenReached()){
            
            scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Chart", val: "", tag: 1))
        }
        else{
            
            scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "GoalReached", val: "", tag: 1))
        }
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: NumberFormatter.formatDoubleToCurrency(selectedSchedule.goal), tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Achieved", val: NumberFormatter.formatDoubleToCurrency(selectedSchedule.achieved), tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Profits Shared", val: NumberFormatter.formatDoubleToCurrency(selectedSchedule.merchantProfitsShared()), tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: NumberFormatter.formatDoubleToPercent(selectedSchedule.KlockWirkerPercentage), tag: 5))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift Start", val: DateUtilities.stringValueOfShiftDate(selectedSchedule.startDateTime), tag: 6))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift End", val: DateUtilities.stringValueOfShiftDate(selectedSchedule.endDateTime), tag: 7))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 8))
        
        return scheduleSummarFieldsFields
    }

    func getKlockWirkerSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        if(selectedSchedule.hasGoalBeenReached()){
            
            scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Chart", val: "", tag: 1))
        }
        else{
            
            scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "GoalReached", val: "", tag: 1))
        }
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Profits Earned", val: NumberFormatter.formatDoubleToCurrency(selectedSchedule.klockWirkerProfitsShared()), tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift Start", val: DateUtilities.stringValueOfShiftDate(selectedSchedule.startDateTime), tag: 6))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift End", val: DateUtilities.stringValueOfShiftDate(selectedSchedule.endDateTime), tag: 7))
        
        return scheduleSummarFieldsFields
    }
    
    func getSelectedKlockWirkers() -> [KlockWirker]{
        
        var merchant = Merchant()
        let isMerhant = ApplicationInformation.isMerchant()
        
        if(isMerhant){
            
            merchant = MerchantManager.sharedInstance.merchant
            
            for kws in merchant.klockWirkers {
                
                let klockWirker = kws
                
                for k in selectedSchedule.klockWirkers {
                    
                    let kk = k
                    
                    if(klockWirker.klockWirkerId == kk.klockWirkerId){
                        
                        klockWirker.isSelected = true
                    }
                }
            }
        }
        
        return merchant.klockWirkers
    }
    
    func deleteScheduleConfirmation(){
        
        let optionMenu = UIAlertController(title: nil, message: "Confirmation", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete Schedule", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
            self.deleteSchedule()
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func deleteSchedule(){
        
        activityIndicator.startAnimating()
        
        scheduleService.deleteSchedule(selectedSchedule.scheduleId) { (response:NSDictionary) in
            
            self.merchantService.getMerchant(ApplicationInformation.getMerchantId()) {(response: Merchant) in
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func loadKlockWirkersOnSchedule(){
        
        scheduleService.getKlockWirkersOnSchedule(selectedSchedule) { (response:[KlockWirker]) in
            
            self.selectedSchedule.klockWirkers = response
        }
        
        tableView.reloadData()
    }
    
    func dismissScheduleDetail(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func refresh(sender:AnyObject){
        
        self.refreshControl?.beginRefreshing()
        
        posSalesService.getTotalSalesForSchedule(selectedSchedule) { (response:NSDictionary) in
            
            self.selectedSchedule.achieved  = JSONUtilities.parsePosOrders(response)
            self.scheduleSummaryFields      = self.getScheduleSummaryFields()
            
            self.tableView.reloadData()
            
            self.refreshControl?.endRefreshing()
        }
    }
    
    
    
    
    
    //MARK: TableView Delegates
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(indexPath.row == 0){
            
            if(selectedSchedule.hasGoalBeenReached()){
                
                return 130
            }
            else{
                
                return 240
            }
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scheduleSummaryFields.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let scheduleSummaryField = scheduleSummaryFields.objectAtIndex(indexPath.row) as! ScheduleSummaryField
        var cell :UITableViewCell!
        
        switch(scheduleSummaryField.tag){
            
            case 1:
                
                if(selectedSchedule.hasGoalBeenReached()){
                    
                    cell = tableView.dequeueReusableCellWithIdentifier("GoalReachedTableViewCell", forIndexPath: indexPath) as! GoalReachedTableViewCell
                    (cell as! GoalReachedTableViewCell).bindCellDetails(selectedSchedule)
                }
                else{
                    
                    cell = tableView.dequeueReusableCellWithIdentifier("ChartTableViewCell", forIndexPath: indexPath) as! ChartTableViewCell
                    (cell as! ChartTableViewCell).bindScheduleData(selectedSchedule)
                }
                

            case 2,3,4,5,6,7,8:
                cell = tableView.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell") as! ScheduleSummaryTableViewCell
                (cell as! ScheduleSummaryTableViewCell).bindCellDetails(scheduleSummaryField)
            
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell", forIndexPath: indexPath)
        }
        
        
        if(scheduleSummaryField.tag == 8){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        
        return cell
    }
        
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row){
            
        case 7:
            
            self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: selectedSchedule.klockWirkers,readOnly: true), animated: true)
            
        default:
            return
        }
    }
}
