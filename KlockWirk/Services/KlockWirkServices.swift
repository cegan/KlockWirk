//
//  KlockWirkServices.swift
//  KlockWirk
//
//  Created by Casey Egan on 7/11/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import Foundation



class KlockWirkServices{
    
    
    func getAllKlockWirkers(merchantId: Int){
    
        let parameters = ["merchantId":merchantId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkersEndpoint, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            dispatch_async(dispatch_get_main_queue(), {
                
                NotificationUtilities.postNotifiaction(NotificationConstants.RetrieveKlockWirkersCompeleted, dataToPost: jsonResult, keyForData: Keys.KlockWirkersKey)
            })
            
            
        })
        
        task.resume()
    }
    
    func addNewKlockWirker(klockWirkerToAdd:KlockWirker){
        
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
                    
                    NotificationUtilities.postNotifiaction(NotificationConstants.AddNewKlockWirkerCompeleted, dataToPost: result, keyForData: Keys.KlockWirkerKey)
                }
            }
        })
        
        task.resume()
    }
    
    func updateKlockWirker(klockWirker: KlockWirker){
        
        
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
    
    
    
    
    
    
    
    
    
    
    

    func getOrders(){
        
        
        let baseUrl = ApplicationInformation.getKlockWirkBaseUrl() as String
        let session = NSURLSession.sharedSession()
        
        let request = getUrlRequestForEndpoint(ServiceEndpoints.OrderEndpoint, httpMethod: HTTPConstants.HTTPMethodGet)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var result = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
        })
        
        task.resume()
    }
    

    func getOrdersOperation() -> AFHTTPRequestOperation{
        
        let request = getUrlRequestForEndpoint(ServiceEndpoints.OrderEndpoint, httpMethod: HTTPConstants.HTTPMethodGet)
        
        let operation = AFHTTPRequestOperation(request: request)
        
        
        return operation
    }


    func getUrlRequestForEndpoint(endPoint: String, httpMethod: String, parameters: [String: AnyObject]) -> NSMutableURLRequest{
        
        let request = getHttpClient().requestWithMethod(httpMethod, path:endPoint, parameters: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }


    func getUrlRequestForEndpoint(endPoint: String, httpMethod: String) -> NSMutableURLRequest{
        
        let request = getHttpClient().requestWithMethod(httpMethod, path:endPoint, parameters: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        request.addValue("application/json", forHTTPHeaderField:"Content-Type")
//        request.addValue("6089f802008f4a27b254bbab455622a7:d3d65e48c168412899fe4c4cb339fa1e107d1ffa44fe438fb96732a9ec0a1aaf", forHTTPHeaderField: HTTPConstants.Authorization)
//        
        
        return request
    }
    
    
    func getHttpClient() -> AFHTTPClient{
        
        let httpClient = AFHTTPClient(baseURL: NSURL(string: ApplicationInformation.getKlockWirkBaseUrl() as String))
        
        httpClient.parameterEncoding = AFFormURLParameterEncoding
        
        return httpClient
    }
    
    

}




