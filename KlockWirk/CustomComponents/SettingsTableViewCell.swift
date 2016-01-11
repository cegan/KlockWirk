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
        
        settingButton.titleLabel?.textColor = UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0)
    }

   
    func bindSettingButtonLabel(label:String){
        
        settingButton.titleLabel?.textColor = UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0)
        settingButton.titleLabel?.text = label
    }
}
