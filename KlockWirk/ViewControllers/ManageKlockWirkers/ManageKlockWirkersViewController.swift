//
//  ManageKlockWirkersViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class ManageKlockWirkersViewController: UITableViewController {
    
    var klockWirkers = NSMutableArray()
    
    
    func refreshKlockWirkers(){
        
        klockWirkers = (ApplicationInformation.getMerchant()?.klockWirkers)!
        
        self.tableView.reloadData()
    }

    func addNewKlockWirker(){
        
        self.presentViewController(UINavigationController(rootViewController: NewKlockWirkerViewController(nibName: "NewKlockWirkerViewController", bundle: nil)), animated: true, completion: nil)
    }
    

    
    //MARK: Setup
    
    func setupNavigationBar(){
        
        let addKlockWirker = UIBarButtonItem(image: UIImage(named: "addUser.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addNewKlockWirker"))
        
        self.navigationItem.rightBarButtonItem = addKlockWirker
    }
    
    func setupTableViewDelegates(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "klockWirkerCell");
    }
   
    func setupViewProperties(){
        
        self.navigationItem.title = "KlockWirkers"
    }
   
    

    
    //MARK: Native View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupTableViewDelegates()
        setupNavigationBar()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "KlockWirkers"
        refreshKlockWirkers()
    }
    
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.klockWirkers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("klockWirkerCell", forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let office = self.klockWirkers[indexPath.row] as! KlockWirker
        
        cell.textLabel?.text = office.firstName + " " + office.lastName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.navigationController?.pushViewController(KlockWirkerDetailViewController(klockWirker: self.klockWirkers[indexPath.row] as! KlockWirker), animated: true)
    }
    
}
