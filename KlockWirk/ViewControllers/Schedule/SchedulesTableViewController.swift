//
//  SchedulesTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/13/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class SchedulesTableViewController: UITableViewController {
    
    var merchant                = Merchant()
    var klockWirker             = KlockWirker()
    var schedules:[Schedule]    = []
    
    
    
    
    //MARK: Notifications
    
    func registerNotification(){
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(
            self,
            selector: "userDidSelectKlockWirkers:",
            name:NotificationConstants.UserDidSelectKlockWirkers,
            object: nil
        )
    }
    
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableViewProperties()
        registerNotification()
    }
    
    
    func userDidSelectKlockWirkers(notification: NSNotification){
        
        let userInfo:Dictionary<String,Schedule> = notification.userInfo as! Dictionary<String,Schedule>
        let schedule = userInfo["ScheduleData"]

        self.presentViewController(UINavigationController(rootViewController:ManageKlockWirkersViewController(klockWirkersToDisplay: (schedule?.klockWirkers)!, asReadonly: true)), animated: true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }

    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Schedules"
        refreshSchedules()
    }
    
    
    
    

    //MARK: Setup Methods
    
    func setupTableViewProperties(){
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerNib(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "TestTableViewCell")
    }
    
    func setupNavigationBar(){
        
        if(!ApplicationInformation.isReadOnly()){
            
            let addNewSchedule = UIBarButtonItem(image: UIImage(named: "addschedule.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addNewSchedule"))
            
            self.navigationItem.rightBarButtonItem = addNewSchedule
        }
    }
    
    func addNewSchedule(){
        
        self.presentViewController(UINavigationController(rootViewController:AddScheduleTableViewController(nibName: "AddScheduleTableViewController", bundle: nil)), animated: true, completion: nil)
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedules"
    }
    
    
    
    
    
    //MARK: Utility Methods
    
    func refreshSchedules(){
        
        if(ApplicationInformation.isKlockWirker()){
            
            klockWirker = KlockWirkerManager.sharedInstance.klockWirker
            schedules = klockWirker.schedules.sort(SortingUtilities.sortSchedulesByEndDate)
        }
        else if(ApplicationInformation.isMerchant()){
        
            merchant    = MerchantManager.sharedInstance.merchant
            schedules   = merchant.schedules.sort(SortingUtilities.sortSchedulesByEndDate)
        }
        
        tableView.reloadData()
        
        if(schedules.count <= 0){
            
            tableView.tableHeaderView = getNoSchedulesHeader()
        }
        else{
            
            tableView.tableHeaderView = nil
        }
    }
    
    func refreshTableViewHeader(){
        
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
    
    func getNoSchedulesHeader() -> UILabel{
        
        let label = UILabel(frame: CGRectMake(0, 60, 300, 90))
        
        label.text = "You Currently Have No Schedules Created"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor(red: 109.0/255.0, green: 110.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        label.font = UIFont (name: "Gotham-Light", size: 15)
        label.numberOfLines = 2
        //  label.sizeToFit()
        
        
        return label
    }


    

    //MARK: TableView Delegates
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.schedules.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TestTableViewCell", forIndexPath: indexPath) as! TestTableViewCell

        cell.bindCellDetails(self.schedules[indexPath.row])
        
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    
        let schedule = schedules[indexPath.row] 
        
        self.navigationController?.pushViewController(ScheduleDetailViewController(schedule: schedule), animated: true)
    }
    
}
