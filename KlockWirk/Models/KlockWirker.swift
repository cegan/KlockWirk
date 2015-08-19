//
//  KlockWirker.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/14/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation


class KlockWirker: NSObject, NSCoding{

    var klockWirkerId: Int?
    var firstName: String?
    var lastName: String?
    var emailAddress: String?
    var phoneNumber: String?
    var password: String?
    
    
    override init() {}
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.klockWirkerId = aDecoder.decodeObjectForKey("klockWirkerId") as? Int
        self.firstName = aDecoder.decodeObjectForKey("firstName") as? String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as? String
        self.emailAddress = aDecoder.decodeObjectForKey("emailAddress") as? String
        self.phoneNumber = aDecoder.decodeObjectForKey("phoneNumber") as? String
        self.password = aDecoder.decodeObjectForKey("password") as? String
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
       
        aCoder.encodeObject(klockWirkerId, forKey: "klockWirkerId")
        aCoder.encodeObject(firstName, forKey: "firstName")
        aCoder.encodeObject(lastName, forKey: "lastName")
        aCoder.encodeObject(emailAddress, forKey: "emailAddress")
        aCoder.encodeObject(phoneNumber, forKey: "phoneNumber")
        aCoder.encodeObject(password, forKey: "password")
        
    }
}