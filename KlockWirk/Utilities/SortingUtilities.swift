//
//  SortingUtilities.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/20/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation


class SortingUtilities{
    
    
    class func sortSchedulesByStartDate(compare:Schedule, to:Schedule) -> Bool {
        
        return compare.startDateTime.compare(to.startDateTime) == NSComparisonResult.OrderedAscending
    }
    
    class func sortSchedulesByEndDate(compare:Schedule, to:Schedule) -> Bool {
        
        return compare.endDateTime.compare(to.endDateTime) == NSComparisonResult.OrderedDescending
    }
    
    class func sortKlockWirkersAscending(compare:KlockWirker, to:KlockWirker) -> Bool {
        
        return compare.firstName.compare(to.firstName) == NSComparisonResult.OrderedAscending
    }
}