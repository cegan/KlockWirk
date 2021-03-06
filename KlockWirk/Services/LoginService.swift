//
//  LoginService.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/23/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class LoginService: BaseKlockWirkService{
    
     func login(emailAddress: String, password:String, onCompletion: (response: NSDictionary) -> ()) {
       
        let params = ["userName":emailAddress,
            "password":password,
            "deviceUuid":UIDevice.currentDevice().identifierForVendor!.UUIDString,
            "deviceToken":ApplicationInformation.getDeviceToken()]
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.LoginEndpoint, httpMethod: HTTPConstants.HTTPMethodGet, parameters: params)
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                if(httpResponse.statusCode == HTTPStatusCodes.HTTPOK){
                 
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: jsonResult)
                    })
                }
                
                if(httpResponse.statusCode == HTTPStatusCodes.HTTPUnauthorized){
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        NotificationUtilities.postNotification(NotificationConstants.LoginFailed)
                    })
                }
            }
        })
        
        task.resume()
    }
}
