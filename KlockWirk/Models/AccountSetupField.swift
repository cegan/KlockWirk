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
    
    
    init(){
        
    }
    
    init(lbl: String, val: String, tag: Int){
        
        self.defaluValue = lbl
        self.value = val
        self.tag = tag
    }
    
    
    
}