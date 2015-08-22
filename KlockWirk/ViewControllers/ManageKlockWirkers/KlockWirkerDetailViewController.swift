//
//  KlockWirkerDetailViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/21/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerDetailViewController: UIViewController {

    
    var klockWirkerDetail = KlockWirker()
    
    
    init(klockWirker: KlockWirker){
        
        super.init(nibName: "KlockWirkerDetailViewController", bundle: nil);
        
        klockWirkerDetail = klockWirker
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
}
