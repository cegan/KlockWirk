//
//  InputTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/14/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell, UITextFieldDelegate {

    
    var accountSetupField = AccountSetupField()
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellInput: UITextField!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        accountSetupField.value = textField.text
    }
    
    
    func setupCellProperties(tag: Int){
        
        cellInput.textAlignment = .Right
        cellInput.keyboardType = UIKeyboardType.NumberPad
        cellInput.borderStyle = .None
        cellInput.delegate = self
    }
    
    
    func bindCellDetail(detail: AccountSetupField){
        
        accountSetupField = detail
        
        cellLabel.text = detail.defaluValue
        cellInput.text = detail.value
        
        setupCellProperties(detail.tag!)
    }
}

