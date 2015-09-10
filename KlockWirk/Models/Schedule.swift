//
//  Schedule.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/9/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation


class Schedule: NSObject, NSCoding{
    
    var percent: Int                    = 0
    var line: Int                       = 0
    var startDateTime: NSDate           = NSDate()
    var endDateTime: NSDate             = NSDate()
    var klockWirkers: NSMutableArray    = NSMutableArray()
    
    
    override init() {}
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.percent = (aDecoder.decodeObjectForKey("percent") as? Int)!
        self.line = (aDecoder.decodeObjectForKey("line") as? Int)!
        self.startDateTime = (aDecoder.decodeObjectForKey("startDateTime") as? NSDate)!
        self.endDateTime = (aDecoder.decodeObjectForKey("endDateTime") as? NSDate)!
        self.klockWirkers = (aDecoder.decodeObjectForKey("klockWirkers") as? NSMutableArray)!
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(percent, forKey: "percent")
        aCoder.encodeObject(line, forKey: "line")
        aCoder.encodeObject(startDateTime, forKey: "startDateTime")
        aCoder.encodeObject(endDateTime, forKey: "endDateTime")
        aCoder.encodeObject(klockWirkers, forKey: "klockWirkers")
    }
}