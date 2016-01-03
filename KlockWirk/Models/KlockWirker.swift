//
//  KlockWirker.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/14/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirker: NSObject, NSCoding{

    var merchantId: NSNumber = 0
    var klockWirkerId: NSNumber = 0
    var firstName: String = ""
    var lastName: String = ""
    var emailAddress: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    var deviceUUID: String = ""
    var confirmPassword: String = ""
    var isSelected: Bool = false
    var schedules = [Schedule]()
    
    
    override init() {}
    
    
    init(firstName : String, lastName : String, emailAddress: String, phoneNumber: String, password: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.password = password
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.klockWirkerId = (aDecoder.decodeObjectForKey("klockWirkerId") as? Int)!
        self.firstName = (aDecoder.decodeObjectForKey("firstName") as? String)!
        self.lastName = (aDecoder.decodeObjectForKey("lastName") as? String)!
        self.emailAddress = (aDecoder.decodeObjectForKey("emailAddress") as? String)!
        self.phoneNumber = (aDecoder.decodeObjectForKey("phoneNumber") as? String)!
        self.password = (aDecoder.decodeObjectForKey("password") as? String)!
        self.confirmPassword = (aDecoder.decodeObjectForKey("confirmPassword") as? String)!
        self.deviceUUID = (aDecoder.decodeObjectForKey("deviceUUID") as? String)!
        self.isSelected = (aDecoder.decodeObjectForKey("isSelected") as? Bool)!
        self.schedules = (aDecoder.decodeObjectForKey("schedules") as? NSArray)! as! [Schedule]
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
       
        aCoder.encodeObject(klockWirkerId, forKey: "klockWirkerId")
        aCoder.encodeObject(firstName, forKey: "firstName")
        aCoder.encodeObject(lastName, forKey: "lastName")
        aCoder.encodeObject(emailAddress, forKey: "emailAddress")
        aCoder.encodeObject(phoneNumber, forKey: "phoneNumber")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(deviceUUID, forKey: "deviceUUID")
        aCoder.encodeObject(confirmPassword, forKey: "confirmPassword")
        aCoder.encodeObject(isSelected, forKey: "isSelected")
        aCoder.encodeObject(schedules, forKey: "schedules")
        
    }
}