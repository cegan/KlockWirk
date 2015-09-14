//
//  Constants.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



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
    static let KlockWirkerEndpoint         = "klockwirker/"
    static let MerchantsEndpoint            = "merchant/"
    static let LoginEndpoint                = "Login/"
    static let KlockWirkerRegistration      = "Registration/"
    static let ScheduleEndpoint             = "Schedules/"
    static let KlockWirkerSchedules         = "KlockWirkerSchedules/"
}


struct HTTPStatusCodes {
    
    static let HTTPNotFound = 404
}


struct HTTPConstants {
    
    static let HTTPMethodPost    = "POST"
    static let HTTPMethodGet     = "GET"
    static let Authorization     = "API-AUTHENTICATION"
}
