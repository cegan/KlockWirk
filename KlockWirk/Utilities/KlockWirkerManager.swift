//
//  KlockWirkerManager.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/22/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation



class KlockWirkerManager {
    
    class var sharedInstance : KlockWirkerManager {
        
        struct Singleton {
            
            static let instance = KlockWirkerManager()
        }
        
        return Singleton.instance
    }
    
    var klockWirker = KlockWirker()
}