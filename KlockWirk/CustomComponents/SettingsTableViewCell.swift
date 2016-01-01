//
//  SettingsTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 12/15/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var settingButton: UIButton!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

   
    func bindSettingButtonLabel(label:String){
        
        settingButton.titleLabel?.text = label
    }
}
