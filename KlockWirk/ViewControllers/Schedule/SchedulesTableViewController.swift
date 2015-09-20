//
//  SchedulesTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/13/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class SchedulesTableViewController: UITableViewController {
    
    var addSchedule = AddScheduleTableViewController(nibName: "AddScheduleTableViewController", bundle: nil)
    var merchant    = Merchant()
    var klockWirker = KlockWirker()
    var schedules   = NSMutableArray()
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableViewProperties()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }

    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Schedules"
        loadData()
        
    }
    
    
    
    //MARK: Setup Methods
    
    func setupTableViewProperties(){
    
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "scheduleCell");
    }
    
    func setupNavigationBar(){
        
        if(!ApplicationInformation.isReadOnly()){
            
            let addNewSchedule = UIBarButtonItem(image: UIImage(named: "addUser.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addNewSchedule"))
            
            self.navigationItem.rightBarButtonItem = addNewSchedule
        }
    }
    
    func addNewSchedule(){
        
        self.presentViewController(UINavigationController(rootViewController:addSchedule), animated: true, completion: nil)
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedules"
    }
    
    
    
    //MARK: Utility Methods
    
    func loadData(){
        
        if(ApplicationInformation.isKlockWirker()){
            
            klockWirker = ApplicationInformation.getKlockWirker()!
            schedules = klockWirker.schedules
        }
        else if(ApplicationInformation.isMerchant()){
            
            merchant = ApplicationInformation.getMerchant()!
            schedules = merchant.schedules
        }
        
        tableView.reloadData()
    }
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.schedules.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let schedule = self.schedules[indexPath.row] as! Schedule
        
        cell.textLabel?.text = NumberFormatter.formatDoubleToCurrency(schedule.line)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let schedule = schedules.objectAtIndex(indexPath.row) as! Schedule
        
        self.navigationController?.pushViewController(ScheduleDetailViewController(schedule: schedule), animated: true)
    }
    
}
