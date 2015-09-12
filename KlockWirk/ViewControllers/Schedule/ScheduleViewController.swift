//
//  ScheduleViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {


    
    
    init(value: String){
        
        super.init(nibName: "ScheduleViewController", bundle: nil);
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupNavigationBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        setupViewProperties()
    }
    
    func setupNavigationBar(){
        
        let addNewSchedule = UIBarButtonItem(image: UIImage(named: "addUser.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addNewSchedule"))
        
        self.navigationItem.rightBarButtonItem = addNewSchedule
    }
    
    
    func addNewSchedule(){
        
        self.presentViewController(UINavigationController(rootViewController: AddScheduleTableViewController(nibName: "AddScheduleTableViewController", bundle: nil)), animated: true, completion: nil)
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedules"
    }
}
