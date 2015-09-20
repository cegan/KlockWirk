//
//  DateUtilities.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/19/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class DateUtilities{
    
    class func stringValueOfShiftDate(date: NSDate) -> String{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: NSTimeZone.localTimeZone().name)
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        return dateFormatter.stringFromDate(date)
    }
    
    class func dateValueOfString(date: String) -> NSDate{
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        
        let d = dateFormatter.dateFromString(date);
        
        
        let test = stringValueOfShiftDate(d!)
        
        
        return d!
        
    }
}