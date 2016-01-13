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
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        if(accountSetupField.fieldType == .Phone){

            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            let decimalString = components.joinWithSeparator("") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
            
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
            {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if hasLeadingOne
            {
                formattedString.appendString("1 ")
                index += 1
            }
            if (length - index) > 3
            {
                let areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3
            {
                let prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            let remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.text = formattedString as String
            return false
        }
        else
        {
            return true
        }
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
            
            case .ZipCode:
                textField.keyboardType = UIKeyboardType.DecimalPad
            
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
            
            accountSetupField.value = textField.text
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

