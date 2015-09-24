//
//  MerchantManager.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/21/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation




class MerchantManager {
    
    class var sharedInstance : MerchantManager {
        struct Singleton {
            static let instance = MerchantManager()
        }
        return Singleton.instance
    }
    
    var merchant = Merchant()
}