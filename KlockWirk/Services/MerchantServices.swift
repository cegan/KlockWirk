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
            
            ApplicationInformation.setMerchant(merchant)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: merchant)
            })
        })
        
        task.resume()
    }
    
    func registerMerchant(merchant: Merchant, onCompletion: (response: NSDictionary) -> ()){
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.MerchantsEndpoint, httpMethod: HTTPConstants.HTTPMethodPost)
        
        let params = [
            "Name":merchant.firstName + " " + merchant.lastName,
            "Address":merchant.address,
            "City":merchant.city,
            "State":merchant.state,
            "ZipCode":merchant.zipCode,
            "Phone":merchant.phone,
            "Email":merchant.email,
            "Manager":merchant.manager,
            "PosSystem":merchant.posSystem,
            "PosSystemBaseApiUrl":merchant.posSystemBaseApiUrl,
            "PosSystemApiKey":merchant.posSystemApiKey,
            "POS":merchant.posSystem,
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
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: result)
                    })
                }
            }
        })
        
        task.resume()
    }
}
