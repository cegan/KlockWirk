//
//  Constants.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation




struct ServiceEndpoints {
    
    static let OrderEndpoint        = "/resources/OrderHistory/?format=json"
    static let KlockWirkersEndpoint         = "klockwirkers/"
    static let MerchantsEndpoint            = "merchants/"
}


struct HTTPConstants {
    
    static let HTTPMethodPost    = "POST"
    static let HTTPMethodGet     = "GET"
    static let Authorization     = "API-AUTHENTICATION"
}
