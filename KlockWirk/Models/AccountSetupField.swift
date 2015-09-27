//
//  AccountSetupField.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/31/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



public class AccountSetupField{
    
    var defaluValue: String?
    var value: String?
    var tag: Int?
    var fieldType: InputFieldTypes = .String
    var isSelected: Bool = false
    var isRequired: Bool = false
    
    
    init(){
        
    }
    
    init(lbl: String, val: String, type:InputFieldTypes, required: Bool, tag: Int){
        
        self.defaluValue = lbl
        self.value = val
        self.fieldType = type
        self.isRequired = required
        self.tag = tag
    }
}