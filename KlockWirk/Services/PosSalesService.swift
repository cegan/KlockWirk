//
//  PosSalesService.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/6/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class PosSalesService: BaseKlockWirkService{
    
    func getTotalSalesForSchedule(schedule: Schedule, onCompletion: (response: Schedule) -> ()) {

        let parameters = [
            "merchantId":schedule.merchantId,
            "scheduleId":schedule.scheduleId] as Dictionary<String, AnyObject>
        
        
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.TotalSalesForShift, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            schedule.achieved = JSONUtilities.parsePosOrders(jsonResult)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: schedule)
            })
        })
        
        task.resume()
    }
}