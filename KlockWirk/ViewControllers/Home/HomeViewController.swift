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
    
    
    let scheduleService         = SchedulService()
    var scheduleSummaryFields   = NSMutableArray()
    var currentSchedule         = Schedule()
    var merchant                = Merchant()
    var pieChart:Chart          = Chart()
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupChart()
        setupViewProperties()
        setupTableViewProperties()
        setupTableViewDelegates()
        setupNavigationBar()
    
    }

    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        setupNavigationTitle("")
        
      
    }
    
    override func viewWillAppear(animated: Bool) {
        
        setupNavigationTitle("Home")
        refreshHomeSchedule()
    }
    
    
    func setupNavigationTitle(title: String){
        
        self.navigationItem.title = title
    }
    
    
    
    
    
    
    
    func displayNoSchedulesHeader(){
        
        let merchantNameLabel = UILabel(frame: CGRectMake(15, 5, 200, 20))
        merchantNameLabel.text = "No Current Schedules"
        merchantNameLabel.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        merchantNameLabel.font = UIFont (name: "HelveticaNeue", size: 15)
        
        let dummyViewHeight = 45.0
        let dummyView = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: dummyViewHeight))
        dummyView.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        
        dummyView.addSubview(merchantNameLabel)
        
        
        self.view.addSubview(dummyView)
        
    }
    
    func refreshHomeSchedule(){
        
        merchant = MerchantManager.sharedInstance.merchant
        
        if(merchant.schedules.count > 0){
            
            if let schedule = DateUtilities.getCurrentSchedule(merchant.schedules){
                
                currentSchedule         = schedule
                scheduleSummaryFields   = getScheduleSummaryFields()
                scheduleSummayTableView.reloadData()
                scheduleSummayTableView.hidden = false
                setPieChartHidden(false)
                
            }
            else{
                
                clearUI()
                //displayNoSchedulesHeader()
            }
            
        }
    }
    


    
    //MARK: Setup Methods
    
    func clearUI(){
        
        setPieChartHidden(true)
        setSummaryTableHidden(true)
    }
    
    
    
    
    func setPieChartHidden(hidden: Bool){
        
        pieChart.view.hidden = hidden
    }
    
    func setSummaryTableHidden(hidden: Bool){
        
        scheduleSummayTableView.hidden = hidden
    }
    
    
    
    func setupChart(){
    
        pieChart.view.frame = CGRectMake(0, 10, view.frame.width, 300)
        view.addSubview(pieChart.view)
        
        pieChart.view.hidden = true
    }
    
    func setupNavigationBar(){
        
        let refresh = UIBarButtonItem(image: UIImage(named: "refresh.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("refresh"))
        
        self.navigationItem.rightBarButtonItem = refresh
    }
    
    func setupTableViewDelegates(){
        
        scheduleSummayTableView.delegate = self
        scheduleSummayTableView.dataSource = self
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Home"
    }
    
    func setupTableViewProperties(){
        
        scheduleSummayTableView.tableFooterView = UIView(frame: CGRectZero)
        scheduleSummayTableView.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
    }
    
    
    
    //MARK: Utility Methods
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: NumberFormatter.formatDoubleToCurrency(currentSchedule.line), tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Achieved", val: NumberFormatter.formatDoubleToCurrency(0), tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: NumberFormatter.formatDoubleToPercent(currentSchedule.KlockWirkerPercentage), tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift Start", val: DateUtilities.stringValueOfShiftDate(currentSchedule.startDateTime), tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift End", val: DateUtilities.stringValueOfShiftDate(currentSchedule.endDateTime), tag: 5))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 6))
        
        return scheduleSummarFieldsFields
    }
    
    func refresh(){
        
        refreshHomeSchedule()
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
        
        
        if(indexPath.row == 5){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
       
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row){
            
        case 5:
            self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: currentSchedule.klockWirkers,readOnly: ApplicationInformation.isReadOnly()), animated: true)
            
            
        default:
            return
            
        }
    }
}


