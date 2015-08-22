//
//  NotificationUtilities.swift
//  SecureSnap_Swift
//
//  Created by Casey Egan  on 5/2/15.
//  Copyright (c) 2015 FCSAmerica. All rights reserved.
//

import Foundation
import UIKit




class NotificationUtilities{
    
    class func postNotifiaction(noification:String, dataToPost:AnyObject?, keyForData:String){
        
        if((dataToPost) != nil){
            
            NSNotificationCenter.defaultCenter().postNotificationName(noification, object: nil, userInfo: [keyForData:dataToPost!])
       }
    }
    
    class func postNotification(notificationName:String){
        
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: nil)
    }
    
    class func presentLocalNotificationWithMessage(message:String, alertAction:String){
       
        let locationNotification = UILocalNotification()
        
        locationNotification.alertBody      = message
        locationNotification.alertAction    = alertAction
        locationNotification.soundName      = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().presentLocalNotificationNow(locationNotification) 
    }
}