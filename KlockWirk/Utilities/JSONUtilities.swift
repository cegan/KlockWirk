//
//  JSONparser.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/15/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



class JSONUtilities{
    
    class func parseKlockWirkers(kws: NSArray) -> [KlockWirker]{
        
        var klockWirkers = [KlockWirker]()
        
        for element in kws {
            
            let klockWirker = KlockWirker()
            
            klockWirker.klockWirkerId = element.objectForKey("KlockWirkerId") as? Int
            klockWirker.firstName = element.objectForKey("FirstName") as? String
            klockWirker.lastName = element.objectForKey("LastName") as? String
            klockWirker.emailAddress = element.objectForKey("Email") as? String
            klockWirker.phoneNumber = element.objectForKey("Phone") as? String
    
            klockWirkers.append(klockWirker)
        
        }
        
        return klockWirkers
    }
    
    
    class func parseKlockWirker(kw: NSDictionary) -> KlockWirker{
        
        
        let klockWirker = KlockWirker()
            
        klockWirker.klockWirkerId = kw.objectForKey("KlockWirkerId") as? Int
        klockWirker.firstName = kw.objectForKey("FirstName") as? String
        klockWirker.lastName = kw.objectForKey("LastName") as? String
        klockWirker.emailAddress = kw.objectForKey("Email") as? String
        klockWirker.phoneNumber = kw.objectForKey("Phone") as? String
            
        
        return klockWirker
        
    }
    
    
}
