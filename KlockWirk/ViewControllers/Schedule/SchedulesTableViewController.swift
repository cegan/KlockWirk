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
        
        loadData()
        
        setupNavigationBar()
        setupTableViewProperties()
        setupTableViewHeader()
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
    
        tableView.tableFooterView = UIView(frame: CGRectZero)
       // tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "scheduleCell");
        
        tableView.registerNib(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "TestTableViewCell")
        
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
    
    
    func setupTableViewHeader(){
        
        let merchantNameLabel = UILabel(frame: CGRectMake(15, 5, 200, 20))
        merchantNameLabel.text = "Gate 25"
        merchantNameLabel.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        merchantNameLabel.font = UIFont (name: "HelveticaNeue", size: 15)
        
        
        let numberOfSchedules = UILabel(frame: CGRectMake(15, 22, 200, 20))
        numberOfSchedules.text = String(schedules.count) + " Schedules"
        numberOfSchedules.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        numberOfSchedules.font = UIFont (name: "HelveticaNeue-LightItalic", size: 10)
        
        
        
        let dummyViewHeight = 45.0
        let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: dummyViewHeight))
        
        dummyView.addSubview(merchantNameLabel)
        dummyView.addSubview(numberOfSchedules)
        
        dummyView.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        
        self.tableView.tableHeaderView = dummyView
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        
    }

    

    //MARK: TableView Delegates
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 152
        
     //   return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.schedules.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
    
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TestTableViewCell", forIndexPath: indexPath) as! TestTableViewCell
        
        
        let schedule = self.schedules[indexPath.row] as! Schedule
        
        
        cell.bindCellDetails(schedule)
        
        
        
        return cell
        
        
        
        
        
        
        
        
        
        
        
        
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
//        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        cell.selectionStyle = UITableViewCellSelectionStyle.None
//        
//        let schedule = self.schedules[indexPath.row] as! Schedule
//        
//        cell.textLabel?.text = NumberFormatter.formatDoubleToCurrency(schedule.line)
//        
//        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let schedule = schedules.objectAtIndex(indexPath.row) as! Schedule
        
        self.navigationController?.pushViewController(ScheduleDetailViewController(schedule: schedule), animated: true)
    }
    
}
