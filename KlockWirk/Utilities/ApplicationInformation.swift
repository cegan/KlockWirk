//
//  ApplicationInformation.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



class ApplicationInformation{
    
    class func setKlockWirkBaseUrl(baseUrl: String){
        
        NSUserDefaults.standardUserDefaults().setObject(baseUrl, forKey: "RevelBaseAPI")
    }
    
    class func getKlockWirkBaseUrl() -> NSString{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("RevelBaseAPI") as? String {
            
            return value
            
        } else {
            
            return ""
        }
    }
    
    
    class func setKlockWirkers(klockWirkers:[KlockWirker]){
        
        
        let myData = NSKeyedArchiver.archivedDataWithRootObject(klockWirkers)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "KlockWirkersKey")
        
       
    }
    
    
    class func getKlockWirkers() -> NSMutableArray{
        
        if let klockWirkersData = NSUserDefaults.standardUserDefaults().objectForKey("KlockWirkersKey") as? NSData {
            
            let klockWirkersArray   = NSKeyedUnarchiver.unarchiveObjectWithData(klockWirkersData) as? [KlockWirker]
            
            let objects = NSMutableArray(array: klockWirkersArray!)
            
            
            return objects
        }
        
        return NSMutableArray()
        
        
    }
    
        
        
        
//        var defaults = NSUserDefaults.standardUserDefaults()
//        
//        var myarray : NSArray = defaults.objectForKey("KlockWirkersKey") as! NSArray
//        
//        return myarray as! [KlockWirker]
    
    
}