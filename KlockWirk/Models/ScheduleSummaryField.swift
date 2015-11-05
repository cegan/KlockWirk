//
//  ScheduleSummaryField.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/13/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation


public class ScheduleSummaryField{
    
    var label: String?
    var value: String?
    var tag: Int = 0
    
    
    init(){
        
    }
    
    init(lbl: String, val: String, tag: Int){
        
        self.label = lbl
        self.value = val
        self.tag = tag
    }
}