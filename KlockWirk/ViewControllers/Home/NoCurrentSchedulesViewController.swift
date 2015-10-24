//
//  NoCurrentSchedulesViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/3/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class NoCurrentSchedulesViewController: UIViewController {

    
    @IBOutlet weak var nextShiftStartButton: UIButton!
    @IBOutlet weak var addScheduleButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var nextSchedule = Schedule()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Home"
    }
    
    override func viewWillAppear(animated: Bool) {
        
        refreshHomeView()
    }


    
    
    
    
    func displayScheduleDetail(){
        
        let klockWirker = KlockWirkerManager.sharedInstance.klockWirker
        
        if let nextSchedule = DateUtilities.getNextSchedule(klockWirker.schedules){
            
            self.presentViewController(UINavigationController(rootViewController:ScheduleDetailViewController(schedule: nextSchedule, initAsModal: true)), animated: true, completion: nil)
        }
    }

    func refreshHomeView(){
        
        nextShiftStartButton.hidden = true
        addScheduleButton.hidden    = true
        
        if(ApplicationInformation.isKlockWirker()){
            
            let klockWirker = KlockWirkerManager.sharedInstance.klockWirker
            
            
            if let nextSchedule = DateUtilities.getNextSchedule(klockWirker.schedules){
                
                messageLabel.text = "You currently have no active schedules. Your next schedule will begin on"
                nextShiftStartButton.setAttributedTitle(StringUtilities.getPrettyShiftStartDate(nextSchedule.startDateTime), forState: .Normal)
                nextShiftStartButton.hidden = false
            }
            else{
                
                messageLabel.text = "You currently have no active schedules"
                nextShiftStartButton.hidden = true
            }
        }
        else{
            
            let merchant = MerchantManager.sharedInstance.merchant
            
            if let nextSchedule = DateUtilities.getNextSchedule(merchant.schedules){
                    
                messageLabel.text = "You currently have no active schedules. Your next schedule will begin on"
                nextShiftStartButton.setAttributedTitle(StringUtilities.getPrettyShiftStartDate(nextSchedule.startDateTime), forState: .Normal)
                nextShiftStartButton.hidden = false
            }
            else{
                    
                messageLabel.text = "You currently have no active schedules"
                addScheduleButton.hidden = false
                nextShiftStartButton.hidden = true
            }
        }
    }
    
    
    
    
    @IBAction func addScheduleTouched(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController:AddScheduleTableViewController(nibName: "AddScheduleTableViewController", bundle: nil)), animated: true, completion: nil)
    }
    
    @IBAction func onNextScheduleButtonTouched(sender: AnyObject) {
        
        displayScheduleDetail()
    }

}
