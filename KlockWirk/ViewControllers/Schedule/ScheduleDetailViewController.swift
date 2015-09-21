//
//  ScheduleDetailViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/13/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tv: UITableView!
    
    let scheduleService = SchedulService()
    let merchantService = MerchantServices()
 
    var selectedSchedule = Schedule()
    var scheduleSummaryFields = NSMutableArray()
    var pieChart:Chart!
    
    
    
    init(schedule: Schedule){
        
        super.init(nibName: "ScheduleDetailViewController", bundle: nil);
        
        selectedSchedule = schedule
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scheduleSummaryFields = getScheduleSummaryFields()
        
        loadSheeduledKlockWirkers()
        setupViewProperties()
        setupTableViewProperties()
        setupNavigationBar()
        setupTableViewDelegates()
        setupChart()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Schedule Detail"
        loadSheeduledKlockWirkers()
    }
    
    
    
    
    
    
    //MARK: Setup Methods
    
    func setupChart(){
        
        pieChart = Chart()
        pieChart.view.frame = CGRectMake(0, 20, view.frame.width, 300)
        
        view.addSubview(pieChart.view)
    }
    
    func setupNavigationBar(){
        
        if(!ApplicationInformation.isReadOnly()){
            
            let deleteSchedule = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action: "deleteScheduleConfirmation")
            self.navigationItem.rightBarButtonItem = deleteSchedule
        }
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedule Detail"
    }
    
    func setupTableViewDelegates(){
        
        tv.delegate = self
        tv.dataSource = self
        tv.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
    }
    
    func setupTableViewProperties(){
        
        tv.tableFooterView = UIView(frame: CGRectZero)
    }
    
    
    
    
    
    
    
    //MARK: Utility Methods
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: NumberFormatter.formatDoubleToCurrency(selectedSchedule.line), tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Achieved", val: "0.00", tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: NumberFormatter.formatDoubleToPercent(selectedSchedule.KlockWirkerPercentage), tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift Start", val: DateUtilities.stringValueOfShiftDate(selectedSchedule.startDateTime), tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift End", val: DateUtilities.stringValueOfShiftDate(selectedSchedule.endDateTime), tag: 5))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 6))
        
        return scheduleSummarFieldsFields
    }
    
    func getSelectedKlockWirkers() -> [KlockWirker]{
        
        var merchant = Merchant()
        let isMerhant = ApplicationInformation.isMerchant()
        
        if(isMerhant){
            
            merchant = ApplicationInformation.getMerchant()!
            
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
        
        let optionMenu = UIAlertController(title: nil, message: "Delete Schedule Confirmation", preferredStyle: .ActionSheet)
        
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
        
        scheduleService.deleteSchedule(selectedSchedule.scheduleId) { (response:NSDictionary) in
            
            self.merchantService.getMerchant(ApplicationInformation.getMerchantId()) {(response: Merchant) in
                
                ApplicationInformation.setMerchant(response)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func loadSheeduledKlockWirkers(){
        
        scheduleService.getKlockWirkersOnSchedule(selectedSchedule.scheduleId) { (response:NSArray) in
            
            self.selectedSchedule.klockWirkers = JSONUtilities.parseKlockWirkers(response) as! [KlockWirker]
        }
        
        tv.reloadData()
    }
    
      
    
    
    //MARK: TableView Delegates
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scheduleSummaryFields.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let scheduleSummaryField = scheduleSummaryFields.objectAtIndex(indexPath.row) as! ScheduleSummaryField
        let cell:ScheduleSummaryTableViewCell = tv.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell") as! ScheduleSummaryTableViewCell
        
        cell.bindCellDetails(scheduleSummaryField)
        
        if(indexPath.row == 5){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        switch(indexPath.row){
            
            case 5:
                
                self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: getSelectedKlockWirkers(),readOnly: ApplicationInformation.isReadOnly()), animated: true)

            default:
                return
        }
    }
    
    
    


    
    

}
