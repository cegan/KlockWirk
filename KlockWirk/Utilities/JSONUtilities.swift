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
            
            klockWirker.klockWirkerId = (element.objectForKey("KlockWirkerId") as? Int)!
            klockWirker.firstName = (element.objectForKey("FirstName") as? String)!
            klockWirker.lastName = (element.objectForKey("LastName") as? String)!
            klockWirker.emailAddress = (element.objectForKey("Email") as? String)!
            klockWirker.phoneNumber = (element.objectForKey("Phone") as? String)!
    
            klockWirkers.append(klockWirker)
        
        }
        
        return klockWirkers
    }
    
    class func parseKlockWirker(kw: NSDictionary) -> KlockWirker{
        
        let klockWirker = KlockWirker()
            
        klockWirker.klockWirkerId = (kw.objectForKey("KlockWirkerId") as? Int)!
        klockWirker.firstName = (kw.objectForKey("FirstName") as? String)!
        klockWirker.lastName = (kw.objectForKey("LastName") as? String)!
        klockWirker.emailAddress = (kw.objectForKey("Email") as? String)!
        klockWirker.phoneNumber = (kw.objectForKey("Phone") as? String)!
        
        return klockWirker
    }
    
    class func parseMerchant(m: NSDictionary) -> Merchant{
        
        let merchant = Merchant()
        
        merchant.merchantId = (m.objectForKey("MerchantId") as? Int)!
        merchant.posSystemId = (m.objectForKey("PosSystemId") as? Int)!
        merchant.posSystemBaseApiUrl = (m.objectForKey("PosSystemBaseApiUrl") as? String)!
        merchant.posSystemApiKey = (m.objectForKey("PosSystemApiKey") as? String)!
        merchant.posSystem = (m.objectForKey("PosSystem") as? String)!
        merchant.firstName = (m.objectForKey("Name") as? String)!
        merchant.address = (m.objectForKey("Address") as? String)!
        merchant.city = (m.objectForKey("City") as? String)!
        merchant.state = (m.objectForKey("State") as? String)!
        merchant.zipCode = (m.objectForKey("ZipCode") as? String)!
        merchant.manager = (m.objectForKey("Manager") as? String)!
        merchant.phone = (m.objectForKey("Phone") as? String)!
        merchant.email = (m.objectForKey("Email") as? String)!
        
        
        let merchantSchedules = (m.objectForKey("MerchantSchedules") as? NSArray)!
        
        for obj: AnyObject in merchantSchedules {
            
            let schedule = Schedule()
            
            schedule.merchantId = (obj.objectForKey("MerchantId") as? Int)!
            
            merchant.schedules.addObject(schedule)
        }
        

        let klockWirkers = (m.objectForKey("KlockWirkers") as? NSArray)!
        
        for element: AnyObject in klockWirkers {
            
            let klockWirker = KlockWirker()
            
            klockWirker.klockWirkerId = (element.objectForKey("KlockWirkerId") as? Int)!
            klockWirker.firstName = (element.objectForKey("FirstName") as? String)!
            klockWirker.lastName = (element.objectForKey("LastName") as? String)!
            klockWirker.emailAddress = (element.objectForKey("Email") as? String)!
            klockWirker.phoneNumber = (element.objectForKey("Phone") as? String)!
            
            merchant.klockWirkers.addObject(klockWirker)
        }
       
        return merchant
    }
}
