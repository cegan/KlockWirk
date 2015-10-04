//
//  NoCurrentSchedulesViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/3/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class NoCurrentSchedulesViewController: UIViewController {

    
    @IBOutlet weak var klockWirkerMessageLabel: UILabel!
    @IBOutlet weak var nextShitStartLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        tst()
    }
    
    
    
    func tst(){
        
        if(ApplicationInformation.isKlockWirker()){
            
            let klockWirker = KlockWirkerManager.sharedInstance.klockWirker
            
            if(klockWirker.schedules.count > 0){
                
                let s = DateUtilities.getNextSchedule(klockWirker.schedules)
                
                klockWirkerMessageLabel.text = "You currently have no active schedules. Your next schedule will begin on"
                nextShitStartLabel.text = DateUtilities.stringValueOfShiftDate(s!.startDateTime)
                nextShitStartLabel.hidden = false
            }
            else{
                
                klockWirkerMessageLabel.text = "You currently have no active schedules"
                nextShitStartLabel.hidden = true
            }
        }
        else{
            
            let merchant = MerchantManager.sharedInstance.merchant
            
            if(merchant.schedules.count > 0){
                
                let m = DateUtilities.getNextSchedule(merchant.schedules)
                
                klockWirkerMessageLabel.text = "You currently have no active schedules. Your next schedule will begin on"
                nextShitStartLabel.text = DateUtilities.stringValueOfShiftDate(m!.startDateTime)
                nextShitStartLabel.hidden = false
            }
            else{
                
                klockWirkerMessageLabel.text = "You currently have no active schedules"
                nextShitStartLabel.hidden = true
            }
        }
    }
}
