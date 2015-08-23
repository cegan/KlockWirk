//
//  Constants.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



struct NotificationConstants {
    
    static let AddNewKlockWirkerCompeleted  = "AddNewKlockWirkerCompeleted"
    static let RetrieveKlockWirkersCompeleted  = "RetrieveKlockWirkersCompeleted"
    static let RegisterKlockWirkerCompeleted  = "RegisterKlockWirkerCompeleted"
    static let LoginFailed  = "LoginFailed"
    static let LoginSuccessful  = "LoginSuccessful"
}


struct Keys{
    
    static let KlockWirkersKey                = "KlockWirkersKey"
    static let KlockWirkerKey                = "KlockWirkerKey"
    static let LoginDataKey                = "LoginDataKey"
}


struct ServiceEndpoints {
    
    static let OrderEndpoint                = "/resources/OrderHistory/?format=json"
    static let KlockWirkersEndpoint         = "klockwirkers/"
    static let MerchantsEndpoint            = "merchants/"
    static let LoginEndpoint                = "Login/"
}


struct HTTPConstants {
    
    static let HTTPMethodPost    = "POST"
    static let HTTPMethodGet     = "GET"
    static let Authorization     = "API-AUTHENTICATION"
}
