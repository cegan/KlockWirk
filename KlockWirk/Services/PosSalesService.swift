//
//  PosSalesService.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/6/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class PosSalesService: BaseKlockWirkService{
    
    
    func getTotalSalesForSchedule(schedule: Schedule, onCompletion: (response: NSDictionary) -> ()) {
        
        
        let parameters = ["merchantId":schedule.merchantId]
        let session = NSURLSession.sharedSession()
        let request = getUrlRequestForEndpoint(ServiceEndpoints.TotalSalesForShift, httpMethod: HTTPConstants.HTTPMethodGet, parameters: parameters)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            dispatch_async(dispatch_get_main_queue(), {
                
                onCompletion(response: jsonResult)
            })
        })
        
        task.resume()
    }
}