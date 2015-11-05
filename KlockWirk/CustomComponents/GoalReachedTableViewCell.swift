//
//  GoalReachedTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 11/4/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class GoalReachedTableViewCell: UITableViewCell {

    @IBOutlet weak var amountEarned: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    
    func bindCellDetails(schedule: Schedule){
        
        amountEarned.text = NumberFormatter.formatDoubleToCurrency(schedule.profitsShared())
    }
    
}
