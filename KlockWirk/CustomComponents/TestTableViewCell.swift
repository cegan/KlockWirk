//
//  TestTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/20/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var scheduleTimeLeftLabel: UILabel!
    @IBOutlet weak var usersLabel: UILabel!
    @IBOutlet weak var usersImageView: UIImageView!
    @IBOutlet weak var goalLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    
    func bindCellDetails(schedule: Schedule){
        
        goalLabel.text  = NumberFormatter.formatDoubleToCurrency(schedule.line)
        usersLabel.text = getKlockWirkersList(schedule.klockWirkers)
    }
    
    
    func getKlockWirkersList(klockWirkers:[KlockWirker]) -> String{
        
        var klockWirkersString = ""
        
        for kw: KlockWirker in klockWirkers{
            
            klockWirkersString = klockWirkersString + kw.firstName + ", "
        }
        
        return klockWirkersString
    }
    
}
