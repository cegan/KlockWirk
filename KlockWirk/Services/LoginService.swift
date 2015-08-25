//
//  LoginService.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/23/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class LoginService{

    
     func login(emailAddress: String, password:String, onCompletion: (response: NSDictionary) -> ()) {
       
        let params = ["userName":emailAddress,"password":password]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.LoginEndpoint, httpMethod: HTTPConstants.HTTPMethodGet, parameters: params)
        
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                if(httpResponse.statusCode == 200){
                 
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: jsonResult)
                    })
                }
                
                if(httpResponse.statusCode == 401){
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        NotificationUtilities.postNotification(NotificationConstants.LoginFailed)
                    })
                }
            }
        })
        
        task.resume()
    }
    
    
    
    func login(emailAddress: String, password: String){
        
        let parameters = ["userName":emailAddress,"password":password]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.LoginEndpoint, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        

        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                if(httpResponse.statusCode == 200){
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                         NotificationUtilities.postNotifiaction(NotificationConstants.LoginSuccessful, dataToPost: jsonResult, keyForData: Keys.LoginDataKey)
                    })
                }
                
                if(httpResponse.statusCode == 401){
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        NotificationUtilities.postNotification(NotificationConstants.LoginFailed)
                    })
                }
            }
        })
        
        task.resume()
    }
    
    
    
    func getUrlRequestForEndpoint(endPoint: String, httpMethod: String) -> NSMutableURLRequest{
        
        let request = getHttpClient().requestWithMethod(httpMethod, path:endPoint, parameters: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    
    
    func getUrlRequestForEndpoint(endPoint: String, httpMethod: String, parameters: [String: AnyObject]) -> NSMutableURLRequest{
        
        let request = getHttpClient().requestWithMethod(httpMethod, path:endPoint, parameters: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    
    func getHttpClient() -> AFHTTPClient{
        
        let httpClient = AFHTTPClient(baseURL: NSURL(string: ApplicationInformation.getKlockWirkBaseUrl() as String))
        
        httpClient.parameterEncoding = AFFormURLParameterEncoding
        
        return httpClient
    }

    
}
