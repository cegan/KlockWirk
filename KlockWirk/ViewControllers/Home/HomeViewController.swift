//
//  HomeViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/7/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var scheduleSummayTableView: UITableView!
    
    
    let scheduleService = SchedulService()
    var scheduleSummaryFields = NSMutableArray()
    var schedule = Schedule()
    var merchant = Merchant()
    var pieChart:Chart!
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        merchant = ApplicationInformation.getMerchant()!
        
        if(merchant.schedules.count > 0){
            
            schedule = merchant.schedules.objectAtIndex(0) as! Schedule
        }
        
        scheduleSummaryFields = getScheduleSummaryFields()
        
        loadData()  
        
        setupViewProperties()
        setupNavigationBar()
        setupChart()
        setupTableViewDelegates()
    }

    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Home"
    }
    
    
    
    func loadData(){
        
        scheduleService.getKlockWirkersOnSchedule(schedule.scheduleId) { (response:NSArray) in
            
            self.schedule.klockWirkers = JSONUtilities.parseKlockWirkers(response)
        }
    }
    

    
    //MARK: Setup Methods
    
    func setupChart(){
        
        pieChart = Chart()
        pieChart.view.frame = CGRectMake(0, 10, view.frame.width, 300)
    
        view.addSubview(pieChart.view)
    }
    
    func setupNavigationBar(){
        
        let refresh = UIBarButtonItem(image: UIImage(named: "refresh.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("refresh"))
        
        self.navigationItem.rightBarButtonItem = refresh
    }
    
    func setupTableViewDelegates(){
        
        scheduleSummayTableView.delegate = self
        scheduleSummayTableView.dataSource = self
        scheduleSummayTableView.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Home"
    }
    
    
    
    
    //MARK: Utility Methods
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: NumberFormatter.formatDoubleToCurrency(schedule.line), tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Achieved", val: NumberFormatter.formatDoubleToCurrency(0), tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: NumberFormatter.formatDoubleToPercent(schedule.KlockWirkerPercentage), tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift", val: "12:00-5:00", tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 5))
        
        return scheduleSummarFieldsFields
    }
    
    func refresh(){
        
        pieChart.refresh()
    }
    
    
    
    
    
    //MARK: TableView Delegates
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scheduleSummaryFields.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        if(section == 0) {
//            
//            let view = UIView()
//            let label = UILabel()
//            
//            label.text = "Schedule Summary"
//            label.textColor = UIColor.lightGrayColor()
//            
//            label.font = UIFont (name: "HelveticaNeue-LightItalic", size: 14)
//            
//            
//            label.numberOfLines = 1
//            label.frame = CGRectMake(15, 10, 330, 75)
//            
//            view.addSubview(label)
//            
//            return view
//        }
       
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       
        let scheduleSummaryField = scheduleSummaryFields.objectAtIndex(indexPath.row) as! ScheduleSummaryField
        let cell:ScheduleSummaryTableViewCell = scheduleSummayTableView.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell") as! ScheduleSummaryTableViewCell
        
        cell.bindCellDetails(scheduleSummaryField)
        
        cell.layoutSubviews()
        
        
        if(indexPath.row == 4){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
       
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row){
            
        case 4:
            self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: schedule.klockWirkers,readOnly: ApplicationInformation.isReadOnly()), animated: true)
            
            
        default:
            return
            
        }
    }
    

}


