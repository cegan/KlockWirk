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
    
    
    
    
//    class func isBetweenMyTwoDates(strartDate: NSDate, date: NSDate) -> Bool {
//        
//        let dateMaker = NSDateFormatter()
//        dateMaker.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        //        let start = dateMaker.dateFromString("2015/04/15 08:00:00")!
//        //        let end = dateMaker.dateFromString("2015/04/15 16:30:00")!
//        //
//        
//        let start = dateMaker.dateFromString("2015/09/21 08:00:00")!
//        let end = dateMaker.dateFromString("2015/09/21 16:30:00")!
//        
//        if start.compare(date) == .OrderedAscending && end.compare(date) == .OrderedDescending {
//            
//            return true
//        }
//        return false
//    }
//
    
    
    
}
