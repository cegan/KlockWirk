//
//  TestTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/20/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    var schedule = Schedule();
    
    @IBOutlet weak var scheduleEndValue: UILabel!
    @IBOutlet weak var scheduleStartValue: UILabel!
    @IBOutlet weak var scheduleTimeLeftLabel: UILabel!
    @IBOutlet weak var usersButton: UIButton!
    @IBOutlet weak var usersImageView: UIImageView!
   

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        usersButton.titleLabel?.textColor = KlockWirkColors.Orange
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    
    func bindCellDetails(schedule: Schedule){
        
        self.schedule = schedule
        
        if(schedule.klockWirkers.count > 1){
        
            usersButton.setTitle(String(schedule.klockWirkers.count) + " KlockWirkers", forState: .Normal)
        }
        else{
            
            usersButton.setTitle(String(schedule.klockWirkers.count) + " KlockWirker", forState: .Normal)
        }
        
        scheduleStartValue.text = DateUtilities.stringValueOfShiftDate(schedule.startDateTime)
        scheduleEndValue.text   = DateUtilities.stringValueOfShiftDate(schedule.endDateTime)
    }
    
    
    
    @IBAction func klockWirkersButtonTouched(sender: AnyObject) {
        
        NotificationUtilities.postNotifiaction(NotificationConstants.UserDidSelectKlockWirkers, dataToPost: self.schedule, keyForData: "ScheduleData")
    }
}
