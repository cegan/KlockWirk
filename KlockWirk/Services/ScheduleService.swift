//
//  ScheduleService.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/11/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation


class SchedulService: BaseKlockWirkService{
    
    
    func FormatDate(date:NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat = dateFormatter.stringFromDate(date)
        
        return DateInFormat
    }
    
    func addSchedule(schedule: Schedule, merchantId: Int, onCompletion: (response: Schedule) -> ()){
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.ScheduleEndpoint, httpMethod: HTTPConstants.HTTPMethodPost)

        
        let params = [
            "MerchantId":String(merchantId),
            "DateCreated":FormatDate(schedule.dateCreated),
            "ShiftStartDateTime":FormatDate(schedule.startDateTime),
            "ShiftEndDateTime":FormatDate(schedule.endDateTime),
            "Line":schedule.line,
            "Achieved":schedule.achieved,
            "KlockWirkerPercentage":schedule.KlockWirkerPercentage] as Dictionary<String, NSObject>
        
        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            
        } catch {
            
            print(error)
        }
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                if(httpResponse.statusCode == 200){
                    
                    let result = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                   
                    let mId         = (result.objectForKey("MerchantId") as? Int)!
                    let scheduleId = (result.objectForKey("ScheduleId") as? Int)!
                    
                    schedule.scheduleId = scheduleId
                    schedule.merchantId = mId
                    
                    for kw in schedule.klockWirkers {
                        
                        self.addKlockWirkersToSchedule(kw, merchantScheduleId: scheduleId, merchantId: mId)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        onCompletion(response: schedule)
                    })
                }
            }
        })
        
        task.resume()
    }

    func addKlockWirkersToSchedule(klockWirker: KlockWirker, merchantScheduleId: Int, merchantId: Int){
    
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.KlockWirkerSchedules, httpMethod: HTTPConstants.HTTPMethodPost)
        
        let params = [
            "KlockWirkerId":String(klockWirker.klockWirkerId),
            "ScheduleId":String(merchantScheduleId),
            "MerchantId":String(merchantId)] as Dictionary<String, String>
        
        
        do {
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            
        } catch {
            
            print(error)
        }
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                if(httpResponse.statusCode == 200){
                    
                    let result = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                }
            }
        })
        
        task.resume()
    }
    
    func getMerchantScheduleByIds(scheduleIds: String, onCompletion: (response: NSArray) -> ()) {
    
        let parameters = ["scheduleIds":scheduleIds]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.ScheduleEndpoint, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: jsonResult)
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