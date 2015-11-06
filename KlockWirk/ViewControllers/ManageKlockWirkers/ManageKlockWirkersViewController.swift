//
//  ManageKlockWirkersViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class ManageKlockWirkersViewController: UITableViewController {
    
    var readOnly: Bool = false
    let merchantService = MerchantServices()
    var klockWirkers:[KlockWirker] = []
    
    
    
    //MARK: View Initialization
    
    init(klockWirkersToDisplay: [KlockWirker], asReadonly: Bool){
        
        super.init(nibName: "ManageKlockWirkersViewController", bundle: nil);
        
        klockWirkers = klockWirkersToDisplay
        readOnly     = asReadonly
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK: Utility Methods
    
    func refreshKlockWirkers(){
        
        if(klockWirkers.count <= 0){
            
            self.tableView.tableHeaderView = getNoKlockWirkersHeader()
        }
        else{
            
            self.tableView.tableHeaderView = nil
        }
        
        self.tableView.reloadData()
    }
    
    func getNoKlockWirkersHeader() -> UILabel{
        
        let label = UILabel(frame: CGRectMake(0, 60, 300, 90))
        
        label.text = "You Currently Have No KlockWirkers Created"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont (name: "HelveticaNeue", size: 15)
        label.numberOfLines = 2
        
        return label
    }
    

    
    
    
    //MARK: Setup
    
    func setupNavigationBar(){
        
        if(readOnly){
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonTapped")
        }
        else{
            
            let addKlockWirker = UIBarButtonItem(image: UIImage(named: "adduser_selected.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addNewKlockWirkerTapped"))
            
            self.navigationItem.rightBarButtonItem = addKlockWirker
        }
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
    }
    
    
    
    
    //MARK: Events
    
    func addNewKlockWirkerTapped(){
        
        self.presentViewController(UINavigationController(rootViewController: NewKlockWirkerViewController(nibName: "NewKlockWirkerViewController", bundle: nil)), animated: true, completion: nil)
    }
    
    func doneButtonTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
        let kw = self.klockWirkers[indexPath.row] 
        
        
        if(readOnly){
            
            cell.accessoryType = .None
        }
        else{
            
            cell.accessoryType = .DisclosureIndicator
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.text = kw.firstName + " " + kw.lastName
        cell.textLabel?.textColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        cell.textLabel?.font = UIFont (name: "Gotham-Medium", size: 14)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(!readOnly){
            
            self.navigationController?.pushViewController(KlockWirkerDetailViewController(klockWirker: self.klockWirkers[indexPath.row] , index: indexPath.row), animated: true)
        }
    }
}
