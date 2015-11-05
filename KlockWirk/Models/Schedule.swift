//
//  Schedule.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/9/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation


class Schedule: NSObject, NSCoding{
    
    var scheduleId: Int                     = 0
    var merchantId: Int                     = 0
    var klockWirkerId                       = 0
    var KlockWirkerPercentage: Double       = 0
    var goal: Double                        = 0
    var achieved: Double                    = 0
    var isCurrentSchedule: Bool             = false
    var dateCreated: NSDate                 = NSDate()
    var startDateTime: NSDate               = NSDate()
    var endDateTime: NSDate                 = NSDate()
    var klockWirkers                        = [KlockWirker]()
   
    
    override init() {}
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.klockWirkerId = (aDecoder.decodeObjectForKey("klockWirkerId") as? Int)!
        
        self.scheduleId = (aDecoder.decodeObjectForKey("scheduleId") as? Int)!
        self.merchantId = (aDecoder.decodeObjectForKey("merchantId") as? Int)!
        self.KlockWirkerPercentage = (aDecoder.decodeObjectForKey("percent") as? Double)!
        self.goal = (aDecoder.decodeObjectForKey("line") as? Double)!
        self.achieved = (aDecoder.decodeObjectForKey("achieved") as? Double)!
        self.isCurrentSchedule = (aDecoder.decodeObjectForKey("isCurrentSchedule") as? Bool)!
        self.dateCreated = (aDecoder.decodeObjectForKey("dateCreated") as? NSDate)!
        self.startDateTime = (aDecoder.decodeObjectForKey("startDateTime") as? NSDate)!
        self.endDateTime = (aDecoder.decodeObjectForKey("endDateTime") as? NSDate)!
        self.klockWirkers = (aDecoder.decodeObjectForKey("klockWirkers") as? NSArray)! as! [KlockWirker]
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(klockWirkerId, forKey: "klockWirkerId")
        aCoder.encodeObject(scheduleId, forKey: "scheduleId")
        aCoder.encodeObject(merchantId, forKey: "merchantId")
        aCoder.encodeObject(KlockWirkerPercentage, forKey: "percent")
        aCoder.encodeObject(goal, forKey: "line")
        aCoder.encodeObject(achieved, forKey: "achieved")
        aCoder.encodeObject(isCurrentSchedule, forKey: "isCurrentSchedule")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(startDateTime, forKey: "startDateTime")
        aCoder.encodeObject(endDateTime, forKey: "endDateTime")
        aCoder.encodeObject(klockWirkers, forKey: "klockWirkers")
    }
    
    
    func hasGoalBeenReached() -> Bool{
        
        if(achieved >= goal){
            
            return true
        }
        
        return false
    }
    
    func profitsShared() -> Double{
        
        var profitsShared = 0.0
        
        if(hasGoalBeenReached()){
            
            profitsShared = (achieved - goal) * KlockWirkerPercentage/100
        }
        else{
            
            profitsShared = 0
        }

        return profitsShared
    }
}