//
//  ScheduleDetailViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/13/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var schedulDetailTableView: UITableView!
    
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
        
        setupViewProperties()
        setupTableViewDelegates()
        setupChart()
    }
    
    
    
    
    //MARK: Setup Methods
    
    func setupChart(){
        
        pieChart = Chart()
        pieChart.view.frame = CGRectMake(0, 20, view.frame.width, view.frame.width)
        
        view.addSubview(pieChart.view)
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedule Detail"
    }
    
    func setupTableViewDelegates(){
        
        schedulDetailTableView.delegate = self
        schedulDetailTableView.dataSource = self
        schedulDetailTableView.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
    }
    
    
    
    
    
    
    
    
    //MARK: Utility Methods
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: String(selectedSchedule.line), tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: String(selectedSchedule.KlockWirkerPercentage), tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift", val: "12:00-5:00", tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 4))
        
        return scheduleSummarFieldsFields
    }
    
    
    
    
    
    //MARK: TableView Delegates
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scheduleSummaryFields.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0) {
            
            let view = UIView()
            let label = UILabel()
            
            label.text = "Schedule Summary"
            label.textColor = UIColor.lightGrayColor()
            
            label.font = UIFont (name: "HelveticaNeue-LightItalic", size: 14)
            
            
            label.numberOfLines = 1
            label.frame = CGRectMake(15, 10, 330, 75)
            
            view.addSubview(label)
            
            return view
        }
        
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 55
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let scheduleSummaryField = scheduleSummaryFields.objectAtIndex(indexPath.row) as! ScheduleSummaryField
        let cell:ScheduleSummaryTableViewCell = schedulDetailTableView.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell") as! ScheduleSummaryTableViewCell
        
        cell.bindCellDetails(scheduleSummaryField)
        
      //  cell.layoutSubviews()
        
        
        if(indexPath.row == 3){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
}
