//
//  SettingsViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 12/15/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit


class SettingsItem: NSObject{
    
    var sections:[String]   = []
    var items:[[String]]    = []
    
    func addSection(section: String, item:[String]){
        
        sections    = sections + [section]
        items       = items + [item]
    }
}



class SettingsItems: SettingsItem {
    
    override init() {
        
        super.init()
    }
}




class SettingsViewController: UITableViewController {
    
    
    var settingsItems  = SettingsItems()
    
    
    
    //MARK: Setup Methods
    
    func setupTableViewProperties(){

        tableView.registerNib(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Settings"
    }
    
    
    
    
    //MARK: Utility Methods
    
    func getSettingsSections() -> SettingsItems{
        
        let settingsItems = SettingsItems()
        
        settingsItems.addSection("Settings", item: getSettings())
        
        
        return settingsItems
    }
    
    func getSettings() -> [String]{
        
        var fields:[String] = []
        
        fields.append("Logout")
        
        return fields
    }
    


    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        settingsItems = getSettingsSections()
        
        setupViewProperties()
        setupTableViewProperties()
    }
    
    
    
    func confirmLogout(){
        
      
        let optionMenu = UIAlertController(title: nil, message: "Confirm", preferredStyle: .ActionSheet)
        
        let logoutAction = UIAlertAction(title: "Log out", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
           
            ApplicationInformation.clearUserLogin()
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window!.rootViewController = LoginViewController()
            
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        
        
        optionMenu.addAction(logoutAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    
    
    
    //MARK: TableView Delegates
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return settingsItems.sections.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return settingsItems.sections[section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingsItems.items[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(indexPath.section){
            
        case 0:
          
            let cell:SettingsTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("SettingsTableViewCell") as! SettingsTableViewCell
            
            cell.selectionStyle = .None;
            cell.settingButton.addTarget(self, action: "logoutButtonPressed", forControlEvents: .TouchUpInside)

            return cell

        default:
            return UITableViewCell()
        }
    }
    
    
    
    
    //MARK: Events
    
    func logoutButtonPressed(){

        confirmLogout()

    }

}
