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
    
    class func setKlockWirkers(klockWirkers:[KlockWirker]){
        
        let myData = NSKeyedArchiver.archivedDataWithRootObject(klockWirkers)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "KlockWirkersKey")
    }
    
    class func setMerchantId(merchantId: Int){
        
        NSUserDefaults.standardUserDefaults().setObject(merchantId, forKey: "MerchantId")
    }
    
    class func setMerchant(merchant: Merchant){
        
        let myData = NSKeyedArchiver.archivedDataWithRootObject(merchant)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "MerchantKey")
    }
    
    
    class func setKlockWirker(klockWirker: KlockWirker){
        
        let myData = NSKeyedArchiver.archivedDataWithRootObject(klockWirker)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "KlockWirkerKey")
    }
    
    
    class func getKlockWirkBaseUrl() -> NSString{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("RevelBaseAPI") as? String {
            
            return value
            
        } else {
            
            return ""
        }
    }
    
    class func getMerchant() -> Merchant?{
        
        if let klockWirkersData = NSUserDefaults.standardUserDefaults().objectForKey("MerchantKey") as? NSData {
            
            let merchant = NSKeyedUnarchiver.unarchiveObjectWithData(klockWirkersData) as? Merchant
            
            return merchant!
        }
        
        return Merchant()
    }
    
    
    class func getKlockWirker() -> KlockWirker?{
        
        if let klockWirkersData = NSUserDefaults.standardUserDefaults().objectForKey("KlockWirkerKey") as? NSData {
            
            let klockWirker = NSKeyedUnarchiver.unarchiveObjectWithData(klockWirkersData) as? KlockWirker
            
            return klockWirker!
        }
        
        return KlockWirker()
    }
    
    class func getKlockWirkers() -> NSMutableArray{
        
        if let klockWirkersData = NSUserDefaults.standardUserDefaults().objectForKey("KlockWirkersKey") as? NSData {
            
            let klockWirkersArray   = NSKeyedUnarchiver.unarchiveObjectWithData(klockWirkersData) as? [KlockWirker]
            
            let objects = NSMutableArray(array: klockWirkersArray!)
            
            return objects
        }
        
        return NSMutableArray()
    }
    
    class func getMerchantId() -> Int{
        
        if let merchant = getMerchant() {
            
            return merchant.merchantId
            
        } else {
            
            return 0
        }
    }
}