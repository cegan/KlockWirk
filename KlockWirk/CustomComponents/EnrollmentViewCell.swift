//
//  TableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/31/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class EnrollmentViewCell: UITableViewCell, UITextFieldDelegate {
    
    var accountSetupField = AccountSetupField()

    @IBOutlet weak var enrollmentTextField: UITextField!
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupCellProperties()
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
//        if(enrollmentTextField.text == ""){
//            
//            enrollmentTextField.text = accountSetupField.defaluValue
//        }
    }
    
    
    func setupCellProperties(){
        
        //enrollmentTextField.borderStyle = UITextBorderStyle.None
        
        enrollmentTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        enrollmentTextField.delegate = self
        selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    func bindCellDetail(detail: AccountSetupField){
        
        accountSetupField = detail
        
        enrollmentTextField.placeholder = accountSetupField.defaluValue
     //   enrollmentTextField.text = accountSetupField.defaluValue
    }
}
