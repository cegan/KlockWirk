//
//  SelectedShiftTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/19/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class SelectedShiftTableViewCell: UITableViewCell {

    @IBOutlet weak var shiftEndValue: UILabel!
    @IBOutlet weak var shiftStartValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func bindCellDetil(shiftStart: String, shiftEnd: String){
        
        shiftStartValue.text = shiftStart
        shiftEndValue.text = shiftEnd
    }
    
}
