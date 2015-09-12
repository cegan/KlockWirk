//
//  HomeViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/7/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var pieChart:Chart!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupChart()
    }
    
    
    func setupChart(){
        
        pieChart = Chart()
        pieChart.view.frame = CGRectMake(0, 20, view.frame.width, view.frame.width)
        
        view.addSubview(pieChart.view)
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Home"
    }
    

}


