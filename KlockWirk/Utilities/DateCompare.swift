//
//  DateCompare.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/21/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class DateCompare{
    

    class func isBetweenMyTwoDates(shiftStartDate: NSDate, shiftEndDate:NSDate, date: NSDate) -> Bool {
        
        let dateMaker = NSDateFormatter()
        dateMaker.dateFormat = "yyyy/MM/dd HH:mm:ss"

        if shiftStartDate.compare(date) == .OrderedAscending && shiftEndDate.compare(date) == .OrderedDescending {
            
            return true
        }
        
        return false
    }
}
