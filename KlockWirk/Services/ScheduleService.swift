//
//  ScheduleService.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/11/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation


class SchedulService: BaseKlockWirkService{
    
    
    
    func addSchedule(schedule: Schedule, merchantId: Int, onCompletion: (response: Schedule) -> ()){
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.ScheduleEndpoint, httpMethod: HTTPConstants.HTTPMethodPost)
        
        var klockWirkerSchedules: Array<[String:AnyObject]> = []
        
        
        for kw in schedule.klockWirkers {
            
            klockWirkerSchedules.append(["merchantId":merchantId,"scheduleId":0,"klockWirkerId":kw.klockWirkerId, "isDeleted":false])
        }
        
        
        let params = [
            "MerchantId":String(merchantId),
            "DateCreated":DateUtilities.FormatDate(schedule.dateCreated),
            "ShiftStartDateTime":DateUtilities.FormatDate(schedule.startDateTime),
            "ShiftEndDateTime":DateUtilities.FormatDate(schedule.endDateTime),
            "Line":schedule.goal,
            "Achieved":schedule.achieved,
            "KlockWirkerPercentage":schedule.KlockWirkerPercentage,
            "KlockWirkerSchedules":klockWirkerSchedules] as Dictionary<String, AnyObject>
        
        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            
        } catch {
            
            print(error)
        }
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                if(httpResponse.statusCode == HTTPStatusCodes.HTTPOK){
                    
                    let result = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    let sched = JSONUtilities.parseMerchantSchedule(result)
                    
//                    let mId         = (result.objectForKey("MerchantId") as? Int)!
//                    let scheduleId  = (result.objectForKey("ScheduleId") as? Int)!
//                    let achieved    = (result.objectForKey("Achieved") as? Double)!
//                    
//                    schedule.scheduleId = scheduleId
//                    schedule.merchantId = mId
//                    schedule.achieved = achieved
                    
            
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: sched)
                    })
                }
                else{
                    
                    
                    
                }
            }
        })
        
        task.resume()
    }
    
    func getKlockWirkersOnSchedule(schedule: Schedule, onCompletion: (response: [KlockWirker]) -> ()) {
        
        let parameters = ["id":schedule.scheduleId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkersByScheduleId, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            
            let kws   = (jsonResult.objectForKey("KlockWirkers") as? NSArray)!
            
            JSONUtilities.parseKlockWirkers(kws)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: JSONUtilities.parseKlockWirkers(kws))
            })
        })
        
        task.resume()
    }
    
    func deleteSchedule(scheduleId: Int, onCompletion: (response: NSDictionary) -> ()) {
        
        let parameters = ["id":scheduleId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.ScheduleEndpoint, httpMethod: HTTPConstants.HTTPMethodDelete, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: jsonResult)
            })
        })
        
        task.resume()
    }

}