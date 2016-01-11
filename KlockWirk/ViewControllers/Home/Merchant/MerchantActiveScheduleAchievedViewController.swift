//
//  MerchantActiveScheduleAchievedViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 1/10/16.
//  Copyright © 2016 KlockWirk. All rights reserved.
//

import UIKit

class MerchantActiveScheduleAchievedViewController: UIViewController {

    
    @IBOutlet weak var achievedLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var timeRemainingOnSchedule: UILabel!
    @IBOutlet weak var viewScheduleDetails: UIButton!

    var merchant          = Merchant()
    var klockWirker       = KlockWirker()
    var currentSchedule   = Schedule()
    
    
    
    init(schedule: Schedule){
        
        super.init(nibName: "MerchantActiveScheduleAchievedViewController", bundle: nil);
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Home"
        
        displayCurrentSchedule()
    }


    
    
    
    //MARK: Events
    
    @IBAction func viewScheduleDetailsTouched(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController:ScheduleDetailQuickLook(schedule: currentSchedule)), animated: true, completion: nil)
    }
  
    
    
    
    //MARK: PieChart Setup
    
    func setupNavigationBar(){
        
        let refresh = UIBarButtonItem(image: UIImage(named: "refresh_normal.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("refreshCurrentSchedule"))
        
        self.navigationItem.rightBarButtonItem = refresh
    }
    
    
    
    
    
    
    func refreshCurrentSchedule(){
        
        userInteractionEnabled(false)
        
        if(ApplicationInformation.isMerchant()){
            
            merchant = MerchantManager.sharedInstance.merchant
            
            if(merchant.schedules.count > 0){
                
                if let schedule = DateUtilities.getCurrentSchedule(merchant.schedules){
                    
                    let posSalesService = PosSalesService()
                    
                    currentSchedule = schedule
                    
                    posSalesService.getTotalSalesForSchedule(currentSchedule) { (response:Schedule) in
                        
                        self.currentSchedule = response
                        
                        self.achievedLabel.text             = "Achieved " + NumberFormatter.formatDoubleToCurrency(self.currentSchedule.achieved)
                        self.goalLabel.text                 = "Goal " + NumberFormatter.formatDoubleToCurrency(self.currentSchedule.goal)
                        self.timeRemainingOnSchedule.text   = String(self.currentSchedule.getTimeReminingOnSchedule())
                      
                        
                        self.userInteractionEnabled(true)
                    }
                }
            }
        }
    }
    
    func displayCurrentSchedule(){
        
        if(ApplicationInformation.isMerchant()){
            
            merchant = MerchantManager.sharedInstance.merchant
            
            if(merchant.schedules.count > 0){
                
                if let schedule = DateUtilities.getCurrentSchedule(merchant.schedules){
                    
                   
                    currentSchedule = schedule
                    
                    goalLabel.text = "Goal " + NumberFormatter.formatDoubleToCurrency(currentSchedule.goal)
                    achievedLabel.text = "Achieved " + NumberFormatter.formatDoubleToCurrency(currentSchedule.achieved)
                    timeRemainingOnSchedule.text = String(currentSchedule.getTimeReminingOnSchedule())
                }
                else{
                    
                    
                    
                }
            }
        }
    }
    
    func userInteractionEnabled(shouldDisable: Bool){
        
        self.navigationController?.navigationBar.userInteractionEnabled = shouldDisable
        self.navigationController?.view.userInteractionEnabled = shouldDisable;
    }
    
}
