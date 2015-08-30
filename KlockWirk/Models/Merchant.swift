//
//  Merchant.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/14/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



class Merchant: NSObject, NSCoding{
    
    
    var merchantId: Int?
    var posSystemId: Int?
    var posSystemBaseApiUrl: String?
    var posSystemApiKey: String?
    var posSystem: String?
    var name: String?
    var address: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var manager: String?
    var phone: String?
    var email: String?
    
    
    override init() {}
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.merchantId = aDecoder.decodeObjectForKey("merchantId") as? Int
        self.posSystemId = aDecoder.decodeObjectForKey("posSystemId") as? Int
        self.posSystemBaseApiUrl = aDecoder.decodeObjectForKey("posSystemBaseApiUrl") as? String
        self.posSystemApiKey = aDecoder.decodeObjectForKey("posSystemApiKey") as? String
        self.posSystem = aDecoder.decodeObjectForKey("posSystem") as? String
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.address = aDecoder.decodeObjectForKey("address") as? String
        self.city = aDecoder.decodeObjectForKey("city") as? String
        self.state = aDecoder.decodeObjectForKey("state") as? String
        self.zipCode = aDecoder.decodeObjectForKey("zipCode") as? String
        self.manager = aDecoder.decodeObjectForKey("manager") as? String
        self.phone = aDecoder.decodeObjectForKey("phone") as? String
        self.email = aDecoder.decodeObjectForKey("email") as? String
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(merchantId, forKey: "merchantId")
        aCoder.encodeObject(posSystemId, forKey: "posSystemId")
        aCoder.encodeObject(posSystemBaseApiUrl, forKey: "posSystemBaseApiUrl")
        aCoder.encodeObject(posSystemApiKey, forKey: "posSystemApiKey")
        aCoder.encodeObject(posSystem, forKey: "posSystem")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(address, forKey: "address")
        aCoder.encodeObject(city, forKey: "city")
        aCoder.encodeObject(state, forKey: "state")
        aCoder.encodeObject(zipCode, forKey: "zipCode")
        aCoder.encodeObject(manager, forKey: "manager")
        aCoder.encodeObject(phone, forKey: "phone")
        aCoder.encodeObject(email, forKey: "email")
    }
}
