////
//  ApplicationInformation.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



class ApplicationInformation{
    
    
    class func appendKlockWirkerToMerchant(klockWirker: KlockWirker){
        
        MerchantManager.sharedInstance.merchant.klockWirkers.append(klockWirker)
    }
    
    class func setKlockWirkBaseUrl(baseUrl: String){
        
        NSUserDefaults.standardUserDefaults().setObject(baseUrl, forKey: "RevelBaseAPI")
    }
    
    class func setMerchantId(merchantId: Int){
        
        NSUserDefaults.standardUserDefaults().setObject(merchantId, forKey: "MerchantId")
    }
    
    class func setIsMerchant(isMerchant: Bool){
        
        NSUserDefaults.standardUserDefaults().setObject(isMerchant, forKey: "isMerchant")
    }
    
    class func setIsKlockWirker(isKlockWirker: Bool){
        
        NSUserDefaults.standardUserDefaults().setObject(isKlockWirker, forKey: "isKlockWirker")
    }
    
    
    
    class func getKlockWirkBaseUrl() -> NSString{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("RevelBaseAPI") as? String {
            
            return value
            
        } else {
            
            return ""
        }
    }
    
    class func getMerchantId() -> Int{
        
        return MerchantManager.sharedInstance.merchant.merchantId
    }
    
    

    
    class func clearSharedData(){
        
        setIsKlockWirker(false)
        setIsMerchant(false)
        
        MerchantManager.sharedInstance.merchant = Merchant()
        KlockWirkerManager.sharedInstance.klockWirker = KlockWirker()
    }
    
    
    
    class func replaceKlockWirker(kw: KlockWirker, index: Int){
        
        MerchantManager.sharedInstance.merchant.klockWirkers[index] = kw
    }
    
    class func removeKlockWirker(kw: KlockWirker, index: Int){
        
        MerchantManager.sharedInstance.merchant.klockWirkers.removeAtIndex(index)
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