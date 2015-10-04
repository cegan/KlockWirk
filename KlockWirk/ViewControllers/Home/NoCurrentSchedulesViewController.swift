//
//  NoCurrentSchedulesViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/3/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class NoCurrentSchedulesViewController: UIViewController {

    
    @IBOutlet weak var addScheduleButton: UIButton!
    @IBOutlet weak var klockWirkerMessageLabel: UILabel!
    @IBOutlet weak var nextShitStartLabel: UILabel!
    
    var nextSchedule = Schedule()
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"
    }
    
    
    
    
    func setupShiftStartGestureRecognizer(){
        
        nextShitStartLabel.userInteractionEnabled = true
        nextShitStartLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("displayScheduleDetail:")))
    }
    
    
    func displayScheduleDetail(gestureRecognizer: UITapGestureRecognizer){
        
        self.presentViewController(UINavigationController(rootViewController:ScheduleDetailViewController(schedule: nextSchedule, initAsModal: true)), animated: true, completion: nil)
    }
    
    
    @IBAction func addScheduleTouched(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController:AddScheduleTableViewController(nibName: "AddScheduleTableViewController", bundle: nil)), animated: true, completion: nil)
 
    }
    
    override func viewWillAppear(animated: Bool) {

        refreshHomeView()
        setupShiftStartGestureRecognizer()
    }
    
    
  
    
    
    func refreshHomeView(){
        
        addScheduleButton.hidden = true
        
        if(ApplicationInformation.isKlockWirker()){
            
            let klockWirker = KlockWirkerManager.sharedInstance.klockWirker
            
            if(klockWirker.schedules.count > 0){
                
                nextSchedule = DateUtilities.getNextSchedule(klockWirker.schedules)!
                
                klockWirkerMessageLabel.text = "You currently have no active schedules. Your next schedule will begin on"
                nextShitStartLabel.attributedText = StringUtilities.getPrettyShiftStartDate(nextSchedule.startDateTime)
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
                
                nextSchedule = DateUtilities.getNextSchedule(merchant.schedules)!
                
                klockWirkerMessageLabel.text = "You currently have no active schedules. Your next schedule will begin on"
                nextShitStartLabel.attributedText = StringUtilities.getPrettyShiftStartDate(nextSchedule.startDateTime)
                
                nextShitStartLabel.hidden = false
            }
            else{
                
                klockWirkerMessageLabel.text = "You currently have no active schedules"
                addScheduleButton.hidden = false
                nextShitStartLabel.hidden = true
            }
        }
    }
}
