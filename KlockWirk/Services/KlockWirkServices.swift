//
//  KlockWirkServices.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



class KlockWirkServices{
    

    func getOrders(){
        
        
        let baseUrl = ApplicationInformation.getKlockWirkBaseUrl() as String
        let session = NSURLSession.sharedSession()
        
        let request = getUrlRequestForEndpoint(ServiceEndpoints.OrderEndpoint, httpMethod: HTTPConstants.HTTPMethodGet)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            
        })
        
        task.resume()
    }
    

    func getOrdersOperation() -> AFHTTPRequestOperation{
        
        var request = getUrlRequestForEndpoint(ServiceEndpoints.OrderEndpoint, httpMethod: HTTPConstants.HTTPMethodGet)
        
        var operation = AFHTTPRequestOperation(request: request)
        
        
        return operation
        
    }




    func getUrlRequestForEndpoint(endPoint: String, httpMethod: String) -> NSMutableURLRequest{
        
        var request = getHttpClient().requestWithMethod(httpMethod, path:endPoint, parameters: nil)
        
        request.addValue("application/json", forHTTPHeaderField:"Content-Type")
        request.addValue("6089f802008f4a27b254bbab455622a7:d3d65e48c168412899fe4c4cb339fa1e107d1ffa44fe438fb96732a9ec0a1aaf", forHTTPHeaderField: HTTPConstants.Authorization)
        
        
        return request
    }
    
    
    func getHttpClient() -> AFHTTPClient{
        
        var httpClient = AFHTTPClient(baseURL: NSURL(string: ApplicationInformation.getKlockWirkBaseUrl() as String))
        
        httpClient.parameterEncoding = AFFormURLParameterEncoding
        
        return httpClient
    }
    
    

}




