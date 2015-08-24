//
//  ScheduleViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/2/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
    var x: String  = ""
    
    init(value: String){
        
        super.init(nibName: "ScheduleViewController", bundle: nil);
        
       
        
        x = value
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        setupViewProperties()
    }

   
    
    func setupViewProperties(){
        
        self.tabBarController?.navigationItem.title = "Schedule"
        
       label.text = x
    }
}
