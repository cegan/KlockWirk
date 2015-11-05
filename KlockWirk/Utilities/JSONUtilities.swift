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
        
        var klockWirkers:[KlockWirker] = []
        
        for element in kws {
            
            let klockWirker = KlockWirker()
            
            klockWirker.klockWirkerId = (element.objectForKey("KlockWirkerId") as? Int)!
            klockWirker.firstName = (element.objectForKey("FirstName") as? String)!
            klockWirker.lastName = (element.objectForKey("LastName") as? String)!
            klockWirker.emailAddress = (element.objectForKey("Email") as? String)!
            klockWirker.phoneNumber = (element.objectForKey("Phone") as? String)!
            klockWirker.password = (element.objectForKey("Password") as? String)!
            
            klockWirkers.append(klockWirker)
        }
        
        return klockWirkers
    }
    
    class func parseKlockWirker(kw: NSDictionary) -> KlockWirker{
        
        let klockWirker         = KlockWirker()
        let merchant            = (kw.objectForKey("Merchant") as? NSDictionary)!
        let merchantSchedules   = (merchant.objectForKey("MerchantSchedules") as? NSArray)!
       
        klockWirker.merchantId = (kw.objectForKey("MerchantId") as? Int)!
        klockWirker.klockWirkerId = (kw.objectForKey("KlockWirkerId") as? Int)!
        klockWirker.firstName = (kw.objectForKey("FirstName") as? String)!
        klockWirker.lastName = (kw.objectForKey("LastName") as? String)!
        klockWirker.emailAddress = (kw.objectForKey("Email") as? String)!
        klockWirker.phoneNumber = (kw.objectForKey("Phone") as? String)!
        klockWirker.password = (kw.objectForKey("Password") as? String)!
        

        for ms: AnyObject in merchantSchedules{
            
            if let klockWirkerSchedules = (ms.objectForKey("KlockWirkerSchedules") as? NSArray){
                
                for x: AnyObject in klockWirkerSchedules{
                    
                    let kwId = (x.objectForKey("KlockWirkerId") as? Int)!
                    
                    if(kwId == klockWirker.klockWirkerId){
                        
                        klockWirker.schedules.append(parseMerchantSchedule(ms as! NSDictionary))
                    }
                }
            }
        }
        
        return klockWirker
    }
    
    class func parseMerchant(m: NSDictionary) -> Merchant{
        
        let merchant = Merchant()
        
        let klockWirkers = (m.objectForKey("KlockWirkers") as? NSArray)!
        let merchantSchedules = (m.objectForKey("MerchantSchedules") as? NSArray)!
       
        merchant.merchantId = (m.objectForKey("MerchantId") as? Int)!
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
        

        for element: AnyObject in klockWirkers {
            
            let klockWirker = KlockWirker()
            
            klockWirker.klockWirkerId = (element.objectForKey("KlockWirkerId") as? Int)!
            klockWirker.firstName = (element.objectForKey("FirstName") as? String)!
            klockWirker.lastName = (element.objectForKey("LastName") as? String)!
            klockWirker.emailAddress = (element.objectForKey("Email") as? String)!
            klockWirker.phoneNumber = (element.objectForKey("Phone") as? String)!
            
            merchant.klockWirkers.append(klockWirker)
        }
        
        
        
        
        for obj: AnyObject in merchantSchedules {
            
            let schedule = Schedule()
            
            schedule.scheduleId             = (obj.objectForKey("ScheduleId") as? Int)!
            schedule.merchantId             = (obj.objectForKey("MerchantId") as? Int)!
            schedule.goal                   = (obj.objectForKey("Line") as? Double)!
            schedule.achieved               = (obj.objectForKey("Achieved") as? Double)!
            schedule.KlockWirkerPercentage  = (obj.objectForKey("KlockWirkerPercentage") as? Double)!
            schedule.startDateTime          = DateUtilities.dateValueOfString((obj.objectForKey("ShiftStartDateTime") as? String)!)
            schedule.endDateTime            = DateUtilities.dateValueOfString((obj.objectForKey("ShiftEndDateTime") as? String)!)
            
            
            if let kwSchedules = (obj.objectForKey("KlockWirkerSchedules") as? NSArray){
                
                for kws: AnyObject in kwSchedules {
                    
                    let klockWirkerId   = (kws.objectForKey("KlockWirkerId") as? Int)!
                    let scheduleId      = (kws.objectForKey("ScheduleId") as? Int)!
                    
                    if(scheduleId == schedule.scheduleId){
                        
                        for t: KlockWirker in merchant.klockWirkers{
                            
                            if(t.klockWirkerId == klockWirkerId){
                                
                                schedule.klockWirkers.append(t)
                            }
                        }
                    }
                }
            }
        
            merchant.schedules.append(schedule)
        }
        
        merchant.schedules      = merchant.schedules.sort(SortingUtilities.sortSchedulesByEndDate)
        merchant.klockWirkers   = merchant.klockWirkers.sort(SortingUtilities.sortKlockWirkersAscending)
        
       
        return merchant
    }
    
    class func parseMerchantSchedule(s: NSDictionary) -> Schedule{
        
        let schedule = Schedule()
        
        schedule.scheduleId = (s.objectForKey("ScheduleId") as? Int)!
        schedule.merchantId = (s.objectForKey("MerchantId") as? Int)!
        schedule.startDateTime =  DateUtilities.dateValueOfString((s.objectForKey("ShiftStartDateTime") as? String)!)
        schedule.endDateTime = DateUtilities.dateValueOfString((s.objectForKey("ShiftEndDateTime") as? String)!)
        schedule.goal = (s.objectForKey("Line") as? Double)!
        schedule.achieved = (s.objectForKey("Achieved") as? Double)!
        schedule.KlockWirkerPercentage = (s.objectForKey("KlockWirkerPercentage") as? Double)!
      
        
        return schedule
    }
    
    class func parseMerchantSchedules(schedulesToParse: NSArray) -> [Schedule]{
        
        var schedules:[Schedule] = []
        
        for s: AnyObject in schedulesToParse {
            
            let newSchedule = Schedule()
            
            newSchedule.scheduleId = (s.objectForKey("ScheduleId") as? Int)!
            newSchedule.merchantId = (s.objectForKey("MerchantId") as? Int)!
            newSchedule.startDateTime =  DateUtilities.dateValueOfString((s.objectForKey("ShiftStartDateTime") as? String)!)
            newSchedule.endDateTime = DateUtilities.dateValueOfString((s.objectForKey("ShiftEndDateTime") as? String)!)
            newSchedule.goal = (s.objectForKey("Line") as? Double)!
            newSchedule.achieved = (s.objectForKey("Achieved") as? Double)!
            newSchedule.KlockWirkerPercentage = (s.objectForKey("KlockWirkerPercentage") as? Double)!
            
            schedules.append(newSchedule)

        }
        
        return schedules
    }
}
