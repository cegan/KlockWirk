//
//  StringUtilities.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/4/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class StringUtilities{
    
    
    
    class func getPrettyShiftStartDate(date: NSDate) -> NSMutableAttributedString?{

        
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([.Day, .Month, .Year, .Hour, .Minute],fromDate: date)
        
        
        let month   = dateComponents.month
        let day     = dateComponents.day
        let year    = dateComponents.year
        let hour    = dateComponents.hour
        let minute  = dateComponents.minute
        var timeOfDay  = ""
        
        if(dateComponents.hour > 11){
            
            timeOfDay = " PM"
        }
        else{
            
            timeOfDay = " AM"
        }
        

        let stringDate = String(month) + "/" + String(day) + "/" + String(year)
        let stringTime = String(hour) + ":" + String(minute) + timeOfDay
        let seperator = " at "
        
        let final = NSMutableAttributedString()
        let attributedDateString = NSMutableAttributedString(string:stringDate)
        let attributedSeperatorString = NSMutableAttributedString(string:seperator)
        let attributedTimeString = NSMutableAttributedString(string:stringTime)
        
        
        //Date
        attributedDateString.addAttribute(NSFontAttributeName, value: UIFont(name: "Gotham-Light",size: 15.0)!, range: NSRange(
            location:0,
            length:stringDate.characters.count))
        
        
        attributedDateString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0), range: NSRange(
            location:0,
            length:stringDate.characters.count))
        
        
        //Sep
        attributedSeperatorString.addAttribute(NSFontAttributeName, value: UIFont(name: "Gotham-Medium",size: 14.0)!, range: NSRange(
            location:0,
            length:seperator.characters.count))
        
        attributedSeperatorString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSRange(
            location:0,
            length:seperator.characters.count))
        
        
        
        
        //Time
        attributedTimeString.addAttribute(NSFontAttributeName, value: UIFont(name: "Gotham-Light",size: 15.0)!, range: NSRange(
            location:0,
            length:stringTime.characters.count))
        
        attributedTimeString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0), range: NSRange(
            location:0,
            length:stringTime.characters.count))
        
        
        
        final.appendAttributedString(attributedDateString)
        final.appendAttributedString(attributedSeperatorString)
        final.appendAttributedString(attributedTimeString)

        
        return final
    
    
    }
    
    
    
}