//
//  DatePickerViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/11/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

   // RSDFDatePickerView *datePickerView = [[RSDFDatePickerView alloc] initWithFrame:self.view.bounds];
    
    let datePicker = RSDFDatePickerViewController()
    
    
    init(){
        
        super.init(nibName: "DatePickerViewController", bundle: nil);
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        installCalendarControl()
        setupNavigationButtons()
        
        datePicker.view.backgroundColor = UIColor.whiteColor()
        view.backgroundColor = UIColor.whiteColor()
    }

    func onTodayButtonTouch(){
        
        datePicker.onTodayButtonTouch(nil)
    }
    
    func onBackButtonTouched(){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setupNavigationButtons(){
        
        let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Bordered, target: nil, action: "onBackButtonTouched")
        navigationItem.backBarButtonItem = backItem
        
        
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "onBackButtonTouched")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.Plain, target: self, action: "onTodayButtonTouch")
    }
    
    func installCalendarControl(){
        
        datePicker.calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        datePicker.calendar.locale = NSLocale.currentLocale()
        
        
        self.view.addSubview(datePicker.view)
        
    }

}
