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
    
    func deleteKlockWirker(klockWirkerId: NSNumber, onCompletion: (response: NSDictionary) -> ()) {
        
        let parameters = ["id":klockWirkerId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkerEndpoint, httpMethod: HTTPConstants.HTTPMethodDelete, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: jsonResult)
            })
        })
        
        task.resume()
    }
    
    
    
    func updateKlockWirker(klockWirker: KlockWirker, onCompletion: (response: NSDictionary) -> ()) {
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkerEndpoint, httpMethod: HTTPConstants.HTTPMethodPut)
        
        
        let params = ["FirstName":klockWirker.firstName,
            "LastName":klockWirker.lastName,
            "Email":klockWirker.emailAddress,
            "Phone":klockWirker.phoneNumber,
            "Password":klockWirker.password,
            "KlockWirkerId":String(klockWirker.klockWirkerId),
            "MerchantId":String(ApplicationInformation.getMerchantId())] as Dictionary<String, String>

        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            
        } catch {
            
            print(error)
        }
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: jsonResult)
            })
        })
        
        task.resume()
    }
    
    
    func getKlockWirker(klockWirkerId: Int, onCompletion: (response: KlockWirker) -> ()) {
        
        let parameters = ["klockWirkerId":klockWirkerId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkerEndpoint, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let scheduleService     = SchedulService()
            let jsonResult          = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let klockWirker         = JSONUtilities.parseKlockWirker(jsonResult)
            let schedules           = (jsonResult.objectForKey("KlockWirkerSchedules") as? NSArray)!
            
            var array:Array<String> = []
           
            
            for element: AnyObject in schedules {
                
                let merchantScheduleId = (element.objectForKey("MerchantSchedluleId") as? Int)!
                
                array.append(String(merchantScheduleId))
            }
            
            let scheduleIds = ",".join(array)
            
            
            if(!scheduleIds.isEmpty){
                
                scheduleService.getMerchantScheduleByIds(scheduleIds) {(response: NSArray) in
                    
                    for obj: AnyObject in response {
                        
                        klockWirker.schedules.append(JSONUtilities.parseMerchantSchedule(obj as! NSDictionary))
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: klockWirker)
                    })
                }
            }
            else{
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    onCompletion(response: klockWirker)
                })
            }
            
            
            
            ApplicationInformation.setKlockWirker(klockWirker)
            

        })
        
        task.resume()
    }
    
    func getKlockWirkerSchedules(klockWirkerId: Int, onCompletion: (response: NSArray) -> ()) {
        
        let parameters = ["klockWirkerId":klockWirkerId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkerSchedules, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: jsonResult)
            })
        })
        
        task.resume()
    }
    
    func addNewKlockWirker(klockWirkerToAdd:KlockWirker, onCompletion: (response: KlockWirker) -> ()){
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkersEndpoint, httpMethod: HTTPConstants.HTTPMethodPost)
        
        let params = ["FirstName":klockWirkerToAdd.firstName,
            "LastName":klockWirkerToAdd.lastName,
            "Email":klockWirkerToAdd.emailAddress,
            "Phone":klockWirkerToAdd.phoneNumber,
            "Password":klockWirkerToAdd.password,
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
                    let klockWirker = JSONUtilities.parseKlockWirker(result)
                    
                    
                    ApplicationInformation.appendKlockWirkerToMerchant(klockWirker)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: klockWirker)
                    })
                }
                else{
                    
                    //let result:NSDictionary = ["statusCode":httpResponse.statusCode] as Dictionary<String, Int>
                    
                    onCompletion(response: KlockWirker())
                }
            }
        })
        
        task.resume()
    }
    
    func registerKlockWirker(klockWirker: KlockWirker,onCompletion: (response: NSDictionary) -> ()){
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkerRegistration, httpMethod: HTTPConstants.HTTPMethodPost)
        
        let params = [
            "Email":klockWirker.emailAddress,
            "Phone":klockWirker.phoneNumber,
            "Password":klockWirker.password] as Dictionary<String, String>
        
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
                        
                        NotificationUtilities.postNotification(NotificationConstants.RegisterKlockWirkerCompeleted)
                    })
                }
                else{
                    
                    let statusCode:NSDictionary = ["statusCode":httpResponse.statusCode] as Dictionary<String, Int>
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: statusCode)
                    }) 
                }
            }
        })
        
        task.resume()
    }
}




