//
//  Merchant.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/14/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



class Merchant: NSObject, NSCoding{
    
    
    var merchantId: Int = 0
    var posSystemId: Int = 0
    var posSystemBaseApiUrl: String = ""
    var posSystemApiKey: String = ""
    var posSystem: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    var manager: String = ""
    var phone: String = ""
    var email: String = ""
    var password: String = ""
    var schedules: NSMutableArray = NSMutableArray()
    var klockWirkers: NSMutableArray = NSMutableArray()
    
    
    override init() {}
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.merchantId = (aDecoder.decodeObjectForKey("merchantId") as? Int)!
        self.posSystemId = (aDecoder.decodeObjectForKey("posSystemId") as? Int!)!
        self.posSystemBaseApiUrl = (aDecoder.decodeObjectForKey("posSystemBaseApiUrl") as? String!)!
        self.posSystemApiKey = (aDecoder.decodeObjectForKey("posSystemApiKey") as? String)!
        self.posSystem = (aDecoder.decodeObjectForKey("posSystem") as? String)!
        self.firstName = (aDecoder.decodeObjectForKey("firstName") as? String)!
        self.lastName = (aDecoder.decodeObjectForKey("lastName") as? String)!
        self.address = (aDecoder.decodeObjectForKey("address") as? String)!
        self.city = (aDecoder.decodeObjectForKey("city") as? String)!
        self.state = (aDecoder.decodeObjectForKey("state") as? String)!
        self.zipCode = (aDecoder.decodeObjectForKey("zipCode") as? String)!
        self.manager = (aDecoder.decodeObjectForKey("manager") as? String)!
        self.phone = (aDecoder.decodeObjectForKey("phone") as? String)!
        self.email = (aDecoder.decodeObjectForKey("email") as? String)!
        self.password = (aDecoder.decodeObjectForKey("password") as? String)!
        self.schedules = (aDecoder.decodeObjectForKey("schedules") as? NSMutableArray)!
        self.klockWirkers = (aDecoder.decodeObjectForKey("klockWirkers") as? NSMutableArray)!
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(merchantId, forKey: "merchantId")
        aCoder.encodeObject(posSystemId, forKey: "posSystemId")
        aCoder.encodeObject(posSystemBaseApiUrl, forKey: "posSystemBaseApiUrl")
        aCoder.encodeObject(posSystemApiKey, forKey: "posSystemApiKey")
        aCoder.encodeObject(posSystem, forKey: "posSystem")
        aCoder.encodeObject(firstName, forKey: "firstName")
        aCoder.encodeObject(lastName, forKey: "lastName")
        aCoder.encodeObject(address, forKey: "address")
        aCoder.encodeObject(city, forKey: "city")
        aCoder.encodeObject(state, forKey: "state")
        aCoder.encodeObject(zipCode, forKey: "zipCode")
        aCoder.encodeObject(manager, forKey: "manager")
        aCoder.encodeObject(phone, forKey: "phone")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(schedules, forKey: "schedules")
        aCoder.encodeObject(klockWirkers, forKey: "klockWirkers")
    }
}
