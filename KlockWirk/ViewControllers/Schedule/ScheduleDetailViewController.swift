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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scheduleSummaryFields = getScheduleSummaryFields()
        
        loadSheeduledKlockWirkers()
        setupViewProperties()
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
    
    func loadSheeduledKlockWirkers(){
        
        scheduleService.getKlockWirkersOnSchedule(selectedSchedule.scheduleId) { (response:NSArray) in
            
            self.selectedSchedule.klockWirkers = JSONUtilities.parseKlockWirkers(response)
        }
        
        tv.reloadData()
    }
    
    
    
    
    //MARK: Setup Methods
    
    func setupChart(){
        
        pieChart = Chart()
        pieChart.view.frame = CGRectMake(0, 20, view.frame.width, 300)
        
        view.addSubview(pieChart.view)
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedule Detail"
    }
    
    func setupTableViewDelegates(){
        
        tv.delegate = self
        tv.dataSource = self
        tv.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
    }
    
    
    
    
    
    
    
    
    //MARK: Utility Methods
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: NumberFormatter.formatDoubleToCurrency(selectedSchedule.line), tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Achieved", val: "0.00", tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: NumberFormatter.formatDoubleToPercent(selectedSchedule.KlockWirkerPercentage), tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift", val: "12:00-5:00", tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 5))
        
        return scheduleSummarFieldsFields
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
        
        if(indexPath.row == 4){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        switch(indexPath.row){
            
            case 4:
                
                self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: getSelectedKlockWirkers(),readOnly: ApplicationInformation.isReadOnly()), animated: true)

            default:
                return
        }
    }
    
    
    func getSelectedKlockWirkers() -> NSMutableArray{
        
        var merchant = Merchant()
        let isMerhant = ApplicationInformation.isMerchant()
        
        if(isMerhant){
            
            merchant = ApplicationInformation.getMerchant()!
            
            for kws in merchant.klockWirkers {
                
                let klockWirker = kws as! KlockWirker
                
                for k in selectedSchedule.klockWirkers {
                    
                    let kk = k as! KlockWirker
                    
                    if(klockWirker.klockWirkerId == kk.klockWirkerId){
                        
                        klockWirker.isSelected = true
                    }
                }
            }
        }
        
        return merchant.klockWirkers
    }
    


    
    

}
