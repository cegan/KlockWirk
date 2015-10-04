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
        
        return dateFormatter.dateFromString(date)!;
    }
    
    class func getFormatedDateWithoutSeconds(date: NSDate) -> NSDate{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        let stringDate = dateFormatter.stringFromDate(date)
        let finalDate = dateFormatter.dateFromString(stringDate)
        
        return finalDate!;
    }
    
    class func getCurrentSchedule(schedules: [Schedule]) -> Schedule?{
    
        for schedule: Schedule in schedules {
            
            let result = isBetweenMyTwoDates(schedule.startDateTime,shiftEndDate: schedule.endDateTime, today: NSDate())
            
            if(result){
                
                schedule.isCurrentSchedule = true;
                
                return schedule
            }
        }

        return nil
    }
    
    
    class func getNextSchedule(schedules: [Schedule]) -> Schedule?{
        
        let sortedSchedules = schedules.sort(SortingUtilities.sortSchedulesByStartDate)
        
        if(sortedSchedules.count > 0){
            
            return sortedSchedules.first
        }
            
        return nil
    }
    
    
    
    class func isBetweenMyTwoDates(shiftStartDate: NSDate, shiftEndDate:NSDate, today: NSDate) -> Bool {
    
        if shiftStartDate.compare(today) == .OrderedAscending && shiftEndDate.compare(today) == .OrderedDescending {
            
            return true
        }
        
        return false
    }
    
    
}