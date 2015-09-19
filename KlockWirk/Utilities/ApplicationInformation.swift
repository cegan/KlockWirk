////
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
    
    class func setKlockWirkers(klockWirkers:NSMutableArray){
        
        let myData = NSKeyedArchiver.archivedDataWithRootObject(klockWirkers)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "KlockWirkersKey")
    }
    
    class func setMerchantId(merchantId: Int){
        
        NSUserDefaults.standardUserDefaults().setObject(merchantId, forKey: "MerchantId")
    }
    
    class func setMerchant(merchant: Merchant){
        
        self.setIsMerchant(true)
        
        let myData = NSKeyedArchiver.archivedDataWithRootObject(merchant)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "MerchantKey")
    }
    
    class func setKlockWirker(klockWirker: KlockWirker){
        
        self.setIsKlockWirker(true)
        
        let myData = NSKeyedArchiver.archivedDataWithRootObject(klockWirker)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "KlockWirkerKey")
    }
    
    class func setIsMerchant(isMerchant: Bool){
        
        NSUserDefaults.standardUserDefaults().setObject(isMerchant, forKey: "isMerchant")
    }
    
    class func setIsKlockWirker(isKlockWirker: Bool){
        
        NSUserDefaults.standardUserDefaults().setObject(isKlockWirker, forKey: "isKlockWirker")
    }
    
    
    class func replaceKlockWirker(kw: KlockWirker, index: Int){
        
        let merchant = getMerchant()
        merchant!.klockWirkers.replaceObjectAtIndex(index, withObject: kw)
    
        setMerchant(merchant!)
    }
    
    
    class func removeKlockWirker(kw: KlockWirker, index: Int){
        
        let merchant = getMerchant()
        merchant!.klockWirkers.removeObject(kw)
        
        setMerchant(merchant!)
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
    
    

    
    
    
    class func isReadOnly() -> Bool{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("isMerchant") as? Bool {
            
            return !value
            
        }
        
        return false

    }
    
    class func isMerchant() -> Bool{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("isMerchant") as? Bool {
            
            return value
            
        } else {
            
            return false
        }
    }
    
    class func isKlockWirker() -> Bool{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("isKlockWirker") as? Bool {
            
            return value
            
        } else {
            
            return false
        }
    }
}