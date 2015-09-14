//
//  Schedule.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/9/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation


class Schedule: NSObject, NSCoding{
    
    var merchantId: Int       = 0
    var KlockWirkerPercentage: Int       = 0
    var line: Int                       = 0
    var isCurrentSchedule: Bool            = false
    var dateCreated: NSDate             = NSDate()
    var startDateTime: NSDate           = NSDate()
    var endDateTime: NSDate             = NSDate()
    var klockWirkers: NSMutableArray    = NSMutableArray()
   
    
    override init() {}
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.merchantId = (aDecoder.decodeObjectForKey("merchantId") as? Int)!
        self.KlockWirkerPercentage = (aDecoder.decodeObjectForKey("percent") as? Int)!
        self.line = (aDecoder.decodeObjectForKey("line") as? Int)!
        self.isCurrentSchedule = (aDecoder.decodeObjectForKey("isCurrentSchedule") as? Bool)!
        self.dateCreated = (aDecoder.decodeObjectForKey("dateCreated") as? NSDate)!
        self.startDateTime = (aDecoder.decodeObjectForKey("startDateTime") as? NSDate)!
        self.endDateTime = (aDecoder.decodeObjectForKey("endDateTime") as? NSDate)!
        self.klockWirkers = (aDecoder.decodeObjectForKey("klockWirkers") as? NSMutableArray)!
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(merchantId, forKey: "merchantId")
        aCoder.encodeObject(KlockWirkerPercentage, forKey: "percent")
        aCoder.encodeObject(line, forKey: "line")
        aCoder.encodeObject(isCurrentSchedule, forKey: "isCurrentSchedule")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(startDateTime, forKey: "startDateTime")
        aCoder.encodeObject(endDateTime, forKey: "endDateTime")
        aCoder.encodeObject(klockWirkers, forKey: "klockWirkers")
    }
}