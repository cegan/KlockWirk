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
    @IBOutlet weak var sharedLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    
    func bindCellDetails(schedule: Schedule){
        
        if(ApplicationInformation.isMerchant()){
            
            amountEarned.text = NumberFormatter.formatDoubleToCurrency(schedule.merchantProfitsShared())
            sharedLabel.text = "Profits Shared"
        }
        else{
            
            amountEarned.text = NumberFormatter.formatDoubleToCurrency(schedule.klockWirkerProfitsShared())
            sharedLabel.text = "You've Earned"
        }
    }
}
