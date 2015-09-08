//
//  KlockWirkerSelectionViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/7/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class KlockWirkerSelectionViewController: UIViewController {

    
    @IBOutlet weak var klockWirkerSelectionTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewProperties()
        setupNavigationButtons()
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Select"
    }
    
    func setupNavigationButtons(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonTapped")
    }
}
