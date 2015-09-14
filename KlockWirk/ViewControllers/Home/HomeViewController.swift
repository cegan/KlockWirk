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
    
    var scheduleSummaryFields = NSMutableArray()
    var pieChart:Chart!
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scheduleSummaryFields = getScheduleSummaryFields()
        
        setupViewProperties()
        setupNavigationBar()
        setupChart()
        setupTableViewDelegates()
    }
    
    

    
    //MARK: Setup Methods
    
    func setupChart(){
        
        pieChart = Chart()
        pieChart.view.frame = CGRectMake(0, 10, view.frame.width, view.frame.width)
    
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
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: "$10,000", tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: "5.0", tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift", val: "12:00-5:00", tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 4))
        
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
        
        if(section == 0) {
            
            let view = UIView()
            let label = UILabel()
            
            label.text = "Schedule Summary - Last Update Today @ 3:19 pm"
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
        let cell:ScheduleSummaryTableViewCell = scheduleSummayTableView.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell") as! ScheduleSummaryTableViewCell
        
        cell.bindCellDetails(scheduleSummaryField)
        
        cell.layoutSubviews()
        
        
        if(indexPath.row == 3){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
       
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    

}


