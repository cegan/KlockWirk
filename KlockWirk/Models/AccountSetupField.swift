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
    
    
    init(){
        
    }
    
    init(lbl: String, val: String, type:InputFieldTypes, tag: Int){
        
        self.defaluValue = lbl
        self.value = val
        self.fieldType = type
        self.tag = tag
    }
}