//
//  UserinterfaceUtilities.swift
//  KlockWirk
//
//  Created by Casey Egan on 11/6/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import Foundation


class UserinterfaceUtilities {
    
    class func ActivityIndicator() -> CustomActivityIndicatorView{
        
        let activityIndicator:CustomActivityIndicatorView = CustomActivityIndicatorView(image: UIImage(named: "loading")!)
        activityIndicator.autoresizingMask  = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        
        return activityIndicator
    }
}