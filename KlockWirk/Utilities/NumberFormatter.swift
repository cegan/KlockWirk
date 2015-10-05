//
//  NumberFormatter.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/15/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class NumberFormatter{
    
    
    class func formatDoubleToCurrency(value: Double) -> String{
        
        let formatter = NSNumberFormatter()
        
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.stringFromNumber(value)!
    }
    
    
    
    class func formatDoubleToPercent(value: Double) -> String{
        
        let pFormatter                      = NSNumberFormatter()
        pFormatter.numberStyle              = NSNumberFormatterStyle.PercentStyle
        pFormatter.maximumFractionDigits    = 1
        pFormatter.multiplier               = 1
        pFormatter.percentSymbol            = " %"
        
        return pFormatter.stringFromNumber(value)!
    }
    
    class func formatCurrencyToDouble(value: String) -> Double{
        
        return NSNumberFormatter().numberFromString(value)!.doubleValue
    }
    
}