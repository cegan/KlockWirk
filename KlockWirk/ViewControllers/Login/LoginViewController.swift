//
//  LoginViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/9/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    let loginService        = LoginService()
    let klockWirkService    = KlockWirkServices()
    
    @IBOutlet weak var emaiAddress: UITextField!
    @IBOutlet weak var password: UITextField!

    
    
    

    //MARK: Notifications
    
    func registerNotification(){
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(
            self,
            selector: "loginFailed",
            name:NotificationConstants.LoginFailed,
            object: nil
        )
        
        
        notificationCenter.addObserver(
            self,
            selector: "loginWasSuccessful:",
            name:NotificationConstants.LoginSuccessful,
            object: nil
        )
        
        
        notificationCenter.addObserver(
            self,
            selector: "retrieveKlockWirkersCompeleted:",
            name:NotificationConstants.RetrieveKlockWirkersCompeleted,
            object: nil
        )
    }
    
    func retrieveKlockWirkersCompeleted(notification: NSNotification){
    
        storeKlockWirkers(notification.userInfo as! Dictionary<String, NSArray>)
        loadMerchantTabBarController()
    }
    
    func loginWasSuccessful(notification: NSNotification){
        
        var data = notification.userInfo as! Dictionary<String,NSDictionary>
        let loginInfo = data[Keys.LoginDataKey]
        
        
        let isKlockWirker   = loginInfo!.objectForKey("isKlockWirker") as? Bool
        let isMerchant      = loginInfo!.objectForKey("isMerchant") as? Bool
        
        
        if(isKlockWirker == true){
            
            let tabBarController:KlockWirkTabBarController = KlockWirkTabBarController()
            
            self.navigationController?.pushViewController(tabBarController, animated: false)
        }
        if(isMerchant == true){
            
            ApplicationInformation.setMerchantId((loginInfo!.objectForKey("MerchantId") as? Int!)!)
            
            klockWirkService.getAllKlockWirkers(ApplicationInformation.getMerchantId())
        }
    }
    
    func loginFailed(){
        
        
        let alertController = UIAlertController(title: "Login", message:
            "Login Failed", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: Utility Methods
    
    func storeKlockWirkers(klockWirkers: Dictionary<String, NSArray>){
        
        ApplicationInformation.setKlockWirkers(JSONUtilities.parseKlockWirkers(klockWirkers[Keys.KlockWirkersKey]!))
    }
    
    func loadMerchantTabBarController(){
        
        let tabBarController:MerchantTabBarController = MerchantTabBarController()
        
        self.navigationController?.pushViewController(tabBarController, animated: false)
        
    }
    

    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        registerNotification()
    }
    
    
    
    
    //MARK: Actions
    
    @IBAction func login(sender: AnyObject) {
        
        loginService.login(emaiAddress.text!, password: password.text!)
    }
    
    @IBAction func newMerchantAccount(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController: MerchantSetupViewController(nibName: "MerchantSetupViewController", bundle: nil)), animated: true, completion: nil)
    }

    @IBAction func newKlockWirkerAccount(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController: KlockWirkerSetupViewController(nibName: "KlockWirkerSetupViewController", bundle: nil)), animated: true, completion: nil)
    }
}
