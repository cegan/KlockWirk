//
//  NumberFormatter.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/15/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class NumberFormatter{
    
    
    private class func percentFormatter() -> NSNumberFormatter{
    
        let pFormatter                      = NSNumberFormatter()
        pFormatter.numberStyle              = NSNumberFormatterStyle.PercentStyle
        pFormatter.maximumFractionDigits    = 1
        pFormatter.multiplier               = 1
        pFormatter.percentSymbol            = " %"
        
        return pFormatter
    }
    
    private class func currencyFormatter() -> NSNumberFormatter{
        
        let formatter = NSNumberFormatter()
        
        formatter.numberStyle           = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale                = NSLocale(localeIdentifier: "en_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
  

    
    class func formatDoubleToCurrency(value: Double) -> String{
        
        let formatter = NSNumberFormatter()
        
        formatter.numberStyle           = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale                = NSLocale(localeIdentifier: "en_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.stringFromNumber(value)!
    }
    
    class func formatDoubleToCurrency(value: String) -> String{
        
        let formatter = NSNumberFormatter()
        
        formatter.numberStyle           = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale                = NSLocale(localeIdentifier: "en_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        var returnValue = ""
        
        
        if let result = formatter.numberFromString(value)?.doubleValue{
            
            returnValue = formatter.stringFromNumber(result)!
        }
        else{
            
            returnValue = formatter.stringFromNumber(Double(value)!)!
        }
        
        return returnValue
    }
    
    
   
    class func formatDoubleToPercent(value: Double) -> String{
        
        return percentFormatter().stringFromNumber(value)!
    }
    
    class func formatDoubleToPercent(value: String) -> String{
        
        let pFormatter = percentFormatter()

        if let result = pFormatter.numberFromString(value)?.doubleValue{
            
            return pFormatter.stringFromNumber(result)!
        }
        else{
            
            return pFormatter.stringFromNumber(Double(value)!)!
        }
    }
    
    class func formatCurrencyToDouble(value: String) -> Double{
        
        return NSNumberFormatter().numberFromString(value)!.doubleValue
    }
    
    
    
    class func getSafeDoubleFromCurrencyString(value: String) -> Double{
        
        let formatter = currencyFormatter()
        
        var returnValue = 0.00
        
        if let result = formatter.numberFromString(value)?.doubleValue{
            
            returnValue = result
        }
        else{
            
            if let result = Double(value){
                
                returnValue = result
            }
        }
        
        return returnValue
    }
    
    class func getSafeDoubleFromPercentString(value: String) -> Double{
        
        let pFormatter = percentFormatter()
        
        if let result = pFormatter.numberFromString(value)?.doubleValue{
            
            return result
        }
        else{
            
            if let result = Double(value){
                
                return result
            }
        }
        
        return 0.00
    }

    
}