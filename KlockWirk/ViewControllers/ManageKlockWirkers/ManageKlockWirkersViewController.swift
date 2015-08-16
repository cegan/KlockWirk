//
//  ManageKlockWirkersViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class ManageKlockWirkersViewController: UITableViewController {
    
    let klockWirkers = ApplicationInformation.getKlockWirkers()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupTableViewDelegates()
        setupNavigationBar()
    }

    
    
    
    func addNewKlockWirker(){
        
        self.presentViewController(UINavigationController(rootViewController: NewKlockWirkerViewController(nibName: "NewKlockWirkerViewController", bundle: nil)), animated: true, completion: nil)
        
    }
    
    
    
    //MARK: Setup
    
    func setupNavigationBar(){
        
        var addKlockWirker = UIBarButtonItem(image: UIImage(named: "addUser.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addNewKlockWirker"))
        self.tabBarController?.navigationItem.rightBarButtonItem = addKlockWirker
    }
    
    func setupTableViewDelegates(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "klockWirkerCell");
    }
   
    func setupViewProperties(){
        
        self.tabBarController?.navigationItem.title = "Manage KlockWirkers"
    }
   
    
    
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.klockWirkers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("klockWirkerCell", forIndexPath: indexPath) as! UITableViewCell
        
        let office = self.klockWirkers[indexPath.row] as! KlockWirker
        
        cell.textLabel?.text = office.firstName! + " " + office.lastName!
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        NotificationUtilities.postNotifiaction(Notifications.UserDidSlectOffice, dataToPost: self.offices[indexPath.row] as Office, keyForData: Keys.SelectedOfficeKey)
//        
//        self.closeOfficeSelection()
    }
    
}
