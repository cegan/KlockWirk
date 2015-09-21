//
//  KlockWirkerSelectionTableViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/14/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerSelectionTableViewController: UITableViewController {
    
    var klockWirkers:[KlockWirker] = []
    var isReadOnly = false
    
    init(kws: [KlockWirker], readOnly: Bool){
        
        super.init(nibName: "KlockWirkerSelectionTableViewController", bundle: nil);
        
        klockWirkers = kws
        isReadOnly = readOnly
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViewProperties()
        setupTableViewProperties()
        setupNavigationButtons()
    }
    

    
    //MARK: Setup Methods
    
    func setupTableViewProperties(){
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerNib(UINib(nibName: "KlockWirkerSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "KlockWirkerCell")
    }
    
    func setupViewProperties(){
        
        if(!isReadOnly){
            
            self.navigationItem.title = "Select KlockWirkers"
        }
        else{
            
            self.navigationItem.title = "KlockWirkers"
        }
    }
    
    func setupNavigationButtons(){
        
        if(!isReadOnly){
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonTapped")
        }
    }
   
    
    
    
    
    //MARK: Events
    
    func doneButtonTapped(){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return klockWirkers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("KlockWirkerCell", forIndexPath: indexPath) as! KlockWirkerSelectionTableViewCell
        let kw = klockWirkers[indexPath.row] 
        
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
        
        if(!isReadOnly){
            
            let kw = klockWirkers[indexPath.row] 
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
}
