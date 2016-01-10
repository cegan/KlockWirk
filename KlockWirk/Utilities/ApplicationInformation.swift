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
    
    class func setDeviceToken(deviceToken: String){
        
        NSUserDefaults.standardUserDefaults().setObject(deviceToken, forKey: "DeviceToken")
    }
    
    class func setMerchantId(merchantId: Int){
        
        NSUserDefaults.standardUserDefaults().setObject(merchantId, forKey: "MerchantId")
    }
    
    class func setKlockWirkerId(klockWirkerId: Int){
        
        NSUserDefaults.standardUserDefaults().setObject(klockWirkerId, forKey: "klockWirkerId")
    }
    
    class func setIsUserLoggedIn(isUserLoggedIn: Bool){
        
        NSUserDefaults.standardUserDefaults().setObject(isUserLoggedIn, forKey: "isUserLoggedIn")
    }
    
    class func setIsMerchant(isMerchant: Bool){
        
        NSUserDefaults.standardUserDefaults().setObject(isMerchant, forKey: "isMerchant")
    }
    
    class func setIsKlockWirker(isKlockWirker: Bool){
        
        NSUserDefaults.standardUserDefaults().setObject(isKlockWirker, forKey: "isKlockWirker")
    }
    
    class func setShouldAutoLogin(shouldAutoLogin: Bool){
        
        NSUserDefaults.standardUserDefaults().setObject(shouldAutoLogin, forKey: "shouldAutoLogin")
    }
    
    class func setUserName(userName: String){
        
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
    }
    
    class func setPassword(password: String){
        
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: "password")
    }
    
    class func getDeviceToken() -> String{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("DeviceToken") as? String {
            
            return value
            
        } else {
            
            return ""
        }
    }
    
    class func getKlockWirkBaseUrl() -> NSString{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("RevelBaseAPI") as? String {
            
            return value
            
        } else {
            
            return ""
        }
    }
    
    class func getKlockWirkerId() -> Int{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("klockWirkerId") as? Int {
            
            return value
            
        } else {
            
            return 0
        }
    }
    
    class func getMerchantId() -> Int{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("MerchantId") as? Int {
            
            return value
            
        } else {
            
            return 0
        }
    }
    
    class func getUserName() -> NSString{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String {
            
            return value
            
        } else {
            
            return ""
        }
    }
    
    class func getPassword() -> NSString{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("password") as? String {
            
            return value
            
        } else {
            
            return ""
        }
    }
    
    class func clearSharedData(){
        
        setIsKlockWirker(false)
        setIsMerchant(false)
        
        MerchantManager.sharedInstance.merchant = Merchant()
        KlockWirkerManager.sharedInstance.klockWirker = KlockWirker()
    }
    
    class func clearUserLogin(){
        
        setUserName("")
        setPassword("")
        setIsUserLoggedIn(false)
        setShouldAutoLogin(false)
    }
   
    class func storeUserLogin(userName:String, password:String, shouldAutoLogin:Bool, isKlockWirker:Bool, isMerchant:Bool) {
        
        setUserName(userName)
        setPassword(password)
        setShouldAutoLogin(shouldAutoLogin)
        setIsKlockWirker(isKlockWirker)
        setIsMerchant(isMerchant)
    }
    
    class func shouldAutoLogin() -> Bool{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("shouldAutoLogin") as? Bool {
            
            return value
            
        } else {
            
            return false
        }
    }
    
    class func replaceKlockWirker(kw: KlockWirker, index: Int){
        
        MerchantManager.sharedInstance.merchant.klockWirkers[index] = kw
    }
    
    class func removeKlockWirker(kw: KlockWirker, index: Int){
        
        MerchantManager.sharedInstance.merchant.klockWirkers.removeAtIndex(index)
    }
    
    
    
    
    class func isUserLoggedIn() -> Bool{
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("isUserLoggedIn") as? Bool {
            
            return value
            
        }
        
        return false
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