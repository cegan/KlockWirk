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
        
        
        let y = DateUtilities.stringValueOfShiftDate(date)
        let dateString = y.stringByReplacingOccurrencesOfString(",", withString: "")
        
        
        let final = NSMutableAttributedString()
        let attributedDateString = NSMutableAttributedString(string:dateString)
        

        attributedDateString.addAttribute(NSFontAttributeName, value: UIFont(name: "Gotham-Light",size: 15.0)!, range: NSRange(
            location:0,
            length:dateString.characters.count))
        
        
        attributedDateString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0), range: NSRange(
            location:0,
            length:dateString.characters.count))
        

        final.appendAttributedString(attributedDateString)
        
        
        return final
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}