//
//  MerchantServices.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/2/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class MerchantServices: BaseKlockWirkService{
    
    func getMerchant(merchantId: Int, onCompletion: (response: Merchant) -> ()) {
        
        let parameters = ["merchantId":merchantId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.MerchantsEndpoint, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        
            let jsonResult  = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let merchant    = JSONUtilities.parseMerchant(jsonResult)
            
            MerchantManager.sharedInstance.merchant = merchant
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: merchant)
            })
        })
        
        task.resume()
    }
    
    

    func registerMerchant(merchant: Merchant, onCompletion: (response: Merchant) -> ()){
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.MerchantsEndpoint, httpMethod: HTTPConstants.HTTPMethodPost)
        
        let params = [
            "Name":merchant.firstName + " " + merchant.lastName,
            "Company":merchant.company,
            "Address":merchant.address,
            "City":merchant.city,
            "State":merchant.state,
            "ZipCode":merchant.zipCode,
            "Phone":merchant.phone,
            "Email":merchant.email,
            "Manager":merchant.manager,
            "PosSystem":merchant.posSystem,
            "PosSystemId":String(merchant.posSystemId.rawValue),
            "PosSystemBaseApiUrl":merchant.posSystemBaseApiUrl,
            "PosSystemApiKey":merchant.posSystemApiKey,
            "POS":merchant.posSystem,
            "DeviceUUID":UIDevice.currentDevice().identifierForVendor!.UUIDString,
            "DeviceToken":ApplicationInformation.getDeviceToken(),
            "Password":merchant.password] as Dictionary<String, String>
        
        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            
        } catch {
            
            print(error)
        }
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                if(httpResponse.statusCode == 200){
                    
                    let result = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let merchant = JSONUtilities.parseMerchant(result)
                    
                    MerchantManager.sharedInstance.merchant = merchant
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: merchant)
                    })
                }
            }
        })
        
        task.resume()
    }
}
