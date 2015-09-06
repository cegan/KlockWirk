//
//  KlockWirkServices.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



class KlockWirkerServices : BaseKlockWirkService{
    
    
    
    func getAllKlockWirkers(merchantId: Int, onCompletion: (response: NSArray) -> ()) {
        
        let parameters = ["merchantId":merchantId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkersEndpoint, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: jsonResult)
            })
        })
        
        task.resume()
    }
    
    func addNewKlockWirker(klockWirkerToAdd:KlockWirker, onCompletion: (response: NSDictionary) -> ()){
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkersEndpoint, httpMethod: HTTPConstants.HTTPMethodPost)
        
        let params = ["FirstName":klockWirkerToAdd.firstName!,
            "LastName":klockWirkerToAdd.lastName!,
            "Email":klockWirkerToAdd.emailAddress!,
            "Phone":klockWirkerToAdd.phoneNumber!,
            "Password":klockWirkerToAdd.password!,
            "MerchantId":String(ApplicationInformation.getMerchantId())] as Dictionary<String, String>
        
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
    
    func registerKlockWirker(emailAddress: String, phoneNumber: String, password: String){
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkerRegistration, httpMethod: HTTPConstants.HTTPMethodPost)
        
        let params = [
            "Email":emailAddress,
            "Phone":phoneNumber,
            "Password":password] as Dictionary<String, String>
        
        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            
        } catch {
            
            print(error)
        }
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                if(httpResponse.statusCode == 200){
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        NotificationUtilities.postNotification(NotificationConstants.RegisterKlockWirkerCompeleted)
                    })
                }
            }
        })
        
        task.resume()
    }

    
    
    
    
    
    

    




}




