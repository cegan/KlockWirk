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
}