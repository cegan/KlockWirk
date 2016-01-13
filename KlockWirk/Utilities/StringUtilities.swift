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
    
    class func getPrettyTimeRemainingOnSchedule(hours: Int, minutes: Int) -> NSAttributedString?{
        
        
        let timeRemainingOnSchedule = "\(hours) Hours and \(minutes) Minutes Remaining"
        let findHourString = String(hours)
        let findMinutesString = String(minutes)
        
        let range = (timeRemainingOnSchedule as NSString).rangeOfString(findHourString)
    
        
        let attributedString = NSMutableAttributedString(string:timeRemainingOnSchedule)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor() , range: range)
        
        
        return attributedString
        
        
//        let text = "We tried to make this app as most intuitive as possible for you. If you have any questions don't hesitate to ask us. For a detailed manual just click here."
//        let linkTextWithColor = "click here"
//        
//        let range = (text as NSString).rangeOfString(linkTextWithColor)
//        
//        let attributedString = NSMutableAttributedString(string:text)
//        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor() , range: range)
//        
//        self.helpText.attributedText = attributedString
        
        
        
        return nil
        
    }
    
    class func formatPhoneNumber(phoneNumber:String) -> String{
        
        if(isPhoneNumberValid(phoneNumber)){
            
            let phone = NSMutableString()
            phone.setString(phoneNumber as String)
            
            
            phone.insertString("(", atIndex: 0)
            phone.insertString(")", atIndex: 4)
            phone.insertString("-", atIndex: 5)
            phone.insertString("-", atIndex: 9)
            
            return phone as String;
  
        }
        
        return phoneNumber;
    }
    
    class func isPhoneNumberValid(phoneNumber:String) -> Bool{
        
        if(phoneNumber.characters.count == 13){
            
            return true
        }
        
        return false
        
    }
    
    class func isValidEmail(emailAddress:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(emailAddress)
    }
    
}