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
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        
        switch(accountSetupField.fieldType){
            
            case .Currency, .Percent:
                textField.keyboardType = UIKeyboardType.DecimalPad
            
            case .String:
                textField.keyboardType = UIKeyboardType.Alphabet
            
            case .Email:
                textField.keyboardType = UIKeyboardType.EmailAddress
            
            case .Phone:
                textField.keyboardType = UIKeyboardType.PhonePad
            
            default:
                textField.keyboardType = UIKeyboardType.Alphabet
        }
    }
    
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        accountSetupField.value = textField.text
        
        if(textField.text != ""){
            
            if(accountSetupField.fieldType == .Currency){
            
                textField.text = NumberFormatter.formatDoubleToCurrency(textField.text!)
            }
            else if(accountSetupField.fieldType == .Percent){
                
                textField.text = NumberFormatter.formatDoubleToPercent(textField.text!)
            }
        }
    }
    
    func setupCellProperties(tag: Int){
        
        if(accountSetupField.fieldType == .Password){
            
            cellInput.secureTextEntry = true
        }
        
        cellInput.font              = UIFont (name: "Gotham-Light", size: 14)!
        selectionStyle              = .None
        cellInput.textAlignment     = .Right
        cellInput.borderStyle       = .None
        cellInput.delegate          = self
    }
    
    func bindCellDetail(detail: AccountSetupField){
        
        accountSetupField = detail
        
        cellLabel.text = detail.defaluValue
        cellInput.text = detail.value
        
        setupCellProperties(detail.tag!)
    }
}

