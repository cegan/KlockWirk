//
//  ViewController.swift
//  SegFault11
//
//  Created by Dylan Vann on 2014-10-25.
//  Copyright (c) 2014 Dylan Vann. All rights reserved.
//

import UIKit


protocol ShiftStartDateWasSelectedDelegate {
    
    func didSelectShiftStartDate(date: NSDate)
}


protocol ShiftEndDateWasSelectedDelegate {
    
    func didSelectShiftEndDate(date: NSDate)
}




class DatePicker: UITableViewController {

    
    var shiftStartDateSelectedDelegate:ShiftStartDateWasSelectedDelegate?
    var shiftEndDateSelectedDelegate:ShiftEndDateWasSelectedDelegate?
    var cells:NSArray = []
    
    override func viewDidLoad() {
        
        setupViewProperties()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        
        // Cells is a 2D array containing sections and rows.
        cells = [[DVDatePickerTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)],
                [DVDatePickerTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)]]
    }
    
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Select Shift"
    }
    
    
    
    
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        if (cell.isKindOfClass(DVDatePickerTableViewCell)) {
            
            return (cell as! DVDatePickerTableViewCell).datePickerHeight()
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return cells.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = cells[indexPath.section][indexPath.row] as! UITableViewCell
        
        switch(indexPath.section){
            
        case 0:
            
            if (cell.isKindOfClass(DVDatePickerTableViewCell)) {
                
                let t = cell as! DVDatePickerTableViewCell
                
                t.leftLabel.text = "Shift Start"
                t.leftLabel.font = UIFont(name: "Gotham-Medium", size: 14)
                t.leftLabel.textColor = UIColor(red: 109.0/255.0, green: 110.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                
                return t
            }
            
            
        case 1:
            
            if (cell.isKindOfClass(DVDatePickerTableViewCell)) {
                
                let t = cell as! DVDatePickerTableViewCell
                
                t.leftLabel.text = "Shift End"
                t.leftLabel.font = UIFont(name: "Gotham-Medium", size: 14)
                t.leftLabel.textColor = UIColor(red: 109.0/255.0, green: 110.0/255.0, blue: 113.0/255.0, alpha: 1.0)
                
                return t
            }
            
        default:
            
            return UITableViewCell()
        
        }

        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        if (cell.isKindOfClass(DVDatePickerTableViewCell)) {
            
            let datePickerTableViewCell = cell as! DVDatePickerTableViewCell
            
            if(indexPath.section == 0){
       
                shiftStartDateSelectedDelegate?.didSelectShiftStartDate(datePickerTableViewCell.date)
            }
            
            if(indexPath.section == 1){

                shiftEndDateSelectedDelegate?.didSelectShiftEndDate(datePickerTableViewCell.date)
            }
        
            
            datePickerTableViewCell.selectedInTableView(tableView)
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}


