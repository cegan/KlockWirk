//
//  HomeSummaryTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/13/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellValue: UILabel!
   
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    
    func bindCellDetails(scheduleSummaryField: ScheduleSummaryField){
        
        cellLabel.text = scheduleSummaryField.label
        cellValue.text = scheduleSummaryField.value
        
        
        selectionStyle = UITableViewCellSelectionStyle.None
    }
}
