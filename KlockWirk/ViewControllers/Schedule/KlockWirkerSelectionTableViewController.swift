//
//  KlockWirkerSelectionTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/14/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerSelectionTableViewController: UITableViewController {
    
    var selectedMerchant = Merchant()
    
    
    init(merchant: Merchant){
        
        super.init(nibName: "KlockWirkerSelectionTableViewController", bundle: nil);
        
        selectedMerchant = merchant
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViewProperties()
        setupTableViewProperties()
        setupNavigationButtons()
    }
    
    
    
    
    //MARK: Setup Methods
    
    func setupTableViewProperties(){
        
        tableView.registerNib(UINib(nibName: "KlockWirkerSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "KlockWirkerCell")
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Select KlockWirkers"
    }
    
    
    func setupNavigationButtons(){
        
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonTapped")
        
        self.navigationItem.rightBarButtonItem = done
    }
   
    
    
    func doneButtonTapped(){
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedMerchant.klockWirkers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("KlockWirkerCell", forIndexPath: indexPath) as! KlockWirkerSelectionTableViewCell
        let kw = self.selectedMerchant.klockWirkers[indexPath.row] as! KlockWirker
        
        if(kw.isSelected == true){
            
            cell.setIsImageViewHidden(false)
        }
        else{
            
            cell.setIsImageViewHidden(true)
        }
        
        cell.bindCellDetails(kw.firstName + " " + kw.lastName)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let kw = self.selectedMerchant.klockWirkers[indexPath.row] as! KlockWirker
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! KlockWirkerSelectionTableViewCell
        
    
        if(kw.isSelected == true){
            
            kw.isSelected = false
            cell.setIsImageViewHidden(true)
        }
        else{
            
            kw.isSelected = true
            cell.setIsImageViewHidden(false)
        }
    }
   
  
}
