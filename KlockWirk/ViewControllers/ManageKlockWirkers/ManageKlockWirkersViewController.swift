//
//  ManageKlockWirkersViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class ManageKlockWirkersViewController: UITableViewController {
    
    
    let merchantService = MerchantServices()
    var klockWirkers:[KlockWirker] = []
    
    
    func refreshKlockWirkers(){
        
        klockWirkers = MerchantManager.sharedInstance.merchant.klockWirkers
        
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
    
    func setupTableViewProperties(){
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "klockWirkerCell");

    }
   
    func setupViewProperties(){
        
        self.navigationItem.title = "KlockWirkers"
    }
    
    func setupTableViewHeader(){
        
    
        let merchantNameLabel = UILabel(frame: CGRectMake(15, 5, 200, 20))
        merchantNameLabel.text = "Gate 25"
        merchantNameLabel.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        merchantNameLabel.font = UIFont (name: "HelveticaNeue", size: 15)
        
        
        let numberOfSchedules = UILabel(frame: CGRectMake(15, 22, 200, 20))
        numberOfSchedules.text = String(klockWirkers.count) + " KlockWirkers"
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
   
    

    
    //MARK: Native View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupTableViewHeader()
        setupTableViewProperties()
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
        setupTableViewHeader()
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
        let kw = self.klockWirkers[indexPath.row] as! KlockWirker
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.text = kw.firstName + " " + kw.lastName
        cell.textLabel?.textColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        cell.textLabel?.font = UIFont (name: "HelveticaNeue", size: 16)


        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.navigationController?.pushViewController(KlockWirkerDetailViewController(klockWirker: self.klockWirkers[indexPath.row] as! KlockWirker, index: indexPath.row), animated: true)
    }
    
}
