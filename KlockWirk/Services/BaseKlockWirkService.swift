//
//  BaseKlockWirkService.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/2/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class BaseKlockWirkService{
    
    
    func getUrlRequestForEndpoint(endPoint: String, httpMethod: String, parameters: [String: AnyObject]) -> NSMutableURLRequest{
        
        let request = getHttpClient().requestWithMethod(httpMethod, path:endPoint, parameters: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    
    func getUrlRequestForEndpoint(endPoint: String, httpMethod: String) -> NSMutableURLRequest{
        
        let request = getHttpClient().requestWithMethod(httpMethod, path:endPoint, parameters: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
               
        return request
    }
    
    
    func getHttpClient() -> AFHTTPClient{
        
        let httpClient = AFHTTPClient(baseURL: NSURL(string: ApplicationInformation.getKlockWirkBaseUrl() as String))
        
        httpClient.parameterEncoding = AFFormURLParameterEncoding
        
        return httpClient
    }
    
    
    
    
//    
//    func getOrders(){
//        
//        
//        let baseUrl = "https://gate25.revelup.com"
//        let session = NSURLSession.sharedSession()
//        
//        let request = getUrlRequestForEndpoint(ServiceEndpoints.OrderEndpoint, httpMethod: HTTPConstants.HTTPMethodGet)
//        
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            
//            var result = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//            
//        })
//        
//        task.resume()
//    }
//    
//    
//    func getOrdersOperation() -> AFHTTPRequestOperation{
//        
//        let request = getUrlRequestForEndpoint(ServiceEndpoints.OrderEndpoint, httpMethod: HTTPConstants.HTTPMethodGet)
//        
//        let operation = AFHTTPRequestOperation(request: request)
//        
//        
//        return operation
//    }
    
    
}