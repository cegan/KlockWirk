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
}