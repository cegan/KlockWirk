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
    @IBOutlet weak var klockWirkerMessageLabel: UILabel!
    
    var nextSchedule = Schedule()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"
        
        addScheduleButton.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        
        refreshHomeView()
    }


    func displayScheduleDetail(){
        
        self.presentViewController(UINavigationController(rootViewController:ScheduleDetailViewController2(schedule: nextSchedule, initAsModal: true)), animated: true, completion: nil)
    }

    func refreshHomeView(){
        
        nextShiftStartButton.hidden = true
        
        if(ApplicationInformation.isKlockWirker()){
            
            let klockWirker = KlockWirkerManager.sharedInstance.klockWirker
            
            if(klockWirker.schedules.count > 0){
                
                nextSchedule = DateUtilities.getNextSchedule(klockWirker.schedules)!
                
                klockWirkerMessageLabel.text = "You currently have no active schedules. Your next schedule will begin on"
                nextShiftStartButton.setAttributedTitle(StringUtilities.getPrettyShiftStartDate(nextSchedule.startDateTime), forState: .Normal)
                nextShiftStartButton.hidden = false
            }
            else{
                
                klockWirkerMessageLabel.text = "You currently have no active schedules"
                nextShiftStartButton.hidden = true
            }
        }
        else{
            
            let merchant = MerchantManager.sharedInstance.merchant
            
            if(merchant.schedules.count > 0){
                
                nextSchedule = DateUtilities.getNextSchedule(merchant.schedules)!
                
                klockWirkerMessageLabel.text = "You currently have no active schedules. Your next schedule will begin on"
                nextShiftStartButton.setAttributedTitle(StringUtilities.getPrettyShiftStartDate(nextSchedule.startDateTime), forState: .Normal)
                nextShiftStartButton.hidden = false
            }
            else{
                
                klockWirkerMessageLabel.text = "You currently have no active schedules"
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
