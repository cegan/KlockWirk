//
//  KlockWirkerActiveScheduleAchievedViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 1/10/16.
//  Copyright © 2016 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerActiveScheduleAchievedViewController: UIViewController {

    
    @IBOutlet weak var klockWirkerEarnedAmountLlb: UILabel!
    @IBOutlet weak var timeRemainingOnSchedule: UILabel!
    
    
    
    
    var merchant          = Merchant()
    var klockWirker       = KlockWirker()
    var currentSchedule   = Schedule()
    
    
    init(schedule: Schedule){
        
        super.init(nibName: "KlockWirkerActiveScheduleAchievedViewController", bundle: nil);
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
        
        refreshHomeView()
     
        self.navigationItem.title = "Home"
    }
    
    

       
    func setupNavigationBar(){
        
        let refresh = UIBarButtonItem(image: UIImage(named: "refresh_normal.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("refreshCurrentScheduleData"))
        
        self.navigationItem.rightBarButtonItem = refresh
    }
    
    func refreshHomeView(){
        
        if(ApplicationInformation.isKlockWirker()){
            
            klockWirker = KlockWirkerManager.sharedInstance.klockWirker
            
            if(klockWirker.schedules.count > 0){
                
                if let schedule = DateUtilities.getCurrentSchedule(klockWirker.schedules){
                    
                    currentSchedule = schedule
                    
                    klockWirkerEarnedAmountLlb.text = "You've earned " + NumberFormatter.formatDoubleToCurrency(schedule.klockWirkerProfitsShared())
                    timeRemainingOnSchedule.text = String(currentSchedule.getTimeReminingOnSchedule())
                }
            }
        }
    }
    
    func refreshCurrentScheduleData(){
        
        userInteractionEnabled(false)
        
        if(ApplicationInformation.isKlockWirker()){
            
            klockWirker = KlockWirkerManager.sharedInstance.klockWirker
            
            if(klockWirker.schedules.count > 0){
                
                if let schedule = DateUtilities.getCurrentSchedule(klockWirker.schedules){
                    
                    let posSalesService = PosSalesService()
                    
                    currentSchedule = schedule
                    
                    posSalesService.getTotalSalesForSchedule(currentSchedule) { (response:Schedule) in
                        
                        self.currentSchedule = response
     
                        self.klockWirkerEarnedAmountLlb.text = "You've earned " + NumberFormatter.formatDoubleToCurrency(schedule.klockWirkerProfitsShared())
                        self.timeRemainingOnSchedule.text = String(self.currentSchedule.getTimeReminingOnSchedule())
                    
                        self.userInteractionEnabled(true)
                    }
                }
            }
        }
    }
    
    
    func userInteractionEnabled(shouldDisable: Bool){
        
        self.navigationController?.navigationBar.userInteractionEnabled = shouldDisable
        self.navigationController?.view.userInteractionEnabled = shouldDisable;
    }
}
