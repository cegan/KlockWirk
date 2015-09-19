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
        
        if(accountSetupField.fieldType == .Currency){
            
            textField.keyboardType = UIKeyboardType.DecimalPad
        }
        if(accountSetupField.fieldType == .Percent){
            
            textField.keyboardType = UIKeyboardType.DecimalPad
        }
        if(accountSetupField.fieldType == .String){
            
            textField.keyboardType = UIKeyboardType.Alphabet
        }
        if(accountSetupField.fieldType == .Email){
            
            textField.keyboardType = UIKeyboardType.EmailAddress
        }
        if(accountSetupField.fieldType == .Phone){
            
            textField.keyboardType = UIKeyboardType.PhonePad
        }
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        accountSetupField.value = textField.text
        
        if(accountSetupField.fieldType == .Currency){
            
            textField.text = NumberFormatter.formatDoubleToCurrency(Double(textField.text!)!)
        }
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
        
        
       // NumberFormatter.formatDoubleToCurrency(Double(detail.value!)!)
        
        setupCellProperties(detail.tag!)
    }
}

