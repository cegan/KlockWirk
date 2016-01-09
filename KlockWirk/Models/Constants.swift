//
//  Constants.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation




struct NotificationConstants {
    
    static let RegisterKlockWirkerCompeleted    = "RegisterKlockWirkerCompeleted"
    static let UserDidAddNewSchedule            = "UserDidAddNewSchedule"
    static let UserDidRefreshSchedule           = "UserDidRefreshSchedule"
    static let UserDidSelectKlockWirkers        = "UserDidSelectKlockWirkers"
    static let LoginFailed                      = "LoginFailed"
}


struct ServiceEndpoints {
    
    static let KlockWirkersEndpoint         = "klockwirkers/"
    static let KlockWirkerEndpoint          = "klockwirker/"
    static let MerchantsEndpoint            = "merchant/"
    static let LoginEndpoint                = "Login/"
    static let KlockWirkerRegistration      = "Registration/"
    static let KlockWirkerPushNotification  = "SendKlockWirkerNotification/"
    static let PasswordReset                = "PasswordReset/"
    static let ScheduleEndpoint             = "Schedules/"
    static let KlockWirkerSchedules         = "KlockWirkerSchedules/"
    static let KlockWirkersByScheduleId     = "klockwirkers/GetKlockWirkersForScheduleId/"
    static let TotalSalesForShift           = "PosSales/"
}


struct HTTPStatusCodes {
    
    static let HTTPOK       = 200
    static let HTTPNotFound = 404
    static let HTTPUnauthorized = 401
}


struct HTTPConstants {
    
    static let HTTPMethodPost    = "POST"
    static let HTTPMethodGet     = "GET"
    static let HTTPMethodDelete  = "DELETE"
    static let HTTPMethodPut     = "PUT"
}
