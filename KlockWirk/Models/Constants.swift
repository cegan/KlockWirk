//
//  Constants.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



enum InputFieldTypes {
    
    case Currency
    case Percent
    case String
    case Email
    case Phone
    case Password
    
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



struct NotificationConstants {
    
    static let RegisterKlockWirkerCompeleted  = "RegisterKlockWirkerCompeleted"
    static let LoginFailed  = "LoginFailed"
}


struct Keys{
    
    static let KlockWirkersKey             = "KlockWirkersKey"
    static let KlockWirkerKey              = "KlockWirkerKey"
    static let LoginDataKey                = "LoginDataKey"
}


struct ServiceEndpoints {
    
    static let OrderEndpoint                = "/resources/OrderHistory/?format=json"
    static let KlockWirkersEndpoint         = "klockwirkers/"
    static let KlockWirkerEndpoint          = "klockwirker/"
    static let MerchantsEndpoint            = "merchant/"
    static let LoginEndpoint                = "Login/"
    static let KlockWirkerRegistration      = "Registration/"
    static let ScheduleEndpoint             = "Schedules/"
    static let KlockWirkerSchedules         = "KlockWirkerSchedules/"
    static let KlockWirkersByScheduleId     = "klockwirkers/GetKlockWirkersForScheduleId/"
}


struct HTTPStatusCodes {
    
    static let HTTPNotFound = 404
}


struct HTTPConstants {
    
    static let HTTPMethodPost    = "POST"
    static let HTTPMethodGet     = "GET"
    static let HTTPMethodDelete  = "DELETE"
    static let HTTPMethodPut     = "PUT"
    static let Authorization     = "API-AUTHENTICATION"
}
