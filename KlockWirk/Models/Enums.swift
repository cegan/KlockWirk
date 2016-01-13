//
//  Enums.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/28/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



enum InputFieldTypes {
    
    case Currency
    case Percent
    case String
    case Email
    case Phone
    case Password
    case ZipCode
}



enum POSSystem: Int {
    
    case None       = 0
    case Revel      = 1
    case Clover     = 2
    case Micros     = 3
    case Shopkeep   = 4
    case LightSpeed = 5
    case Square     = 6
    case Aloha      = 7
    case Squirrel   = 8
    case Breadcrumb = 9
}