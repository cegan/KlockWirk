//
//  LoginViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/9/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate  {
    
    
    let loginService        = LoginService()
    let klockWirkService    = KlockWirkServices()
    let merchantService     = MerchantServices()
    
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
    }
    
    func loginFailed(){
        
        let alertController = UIAlertController(title: "Login", message:
            "Login Failed", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    func storeKlockWirkers(klockWirkers: NSArray){
        
        ApplicationInformation.setKlockWirkers(JSONUtilities.parseKlockWirkers(klockWirkers))
    }
    
    func loadMerchantTabBarController(){
        
        let tabBarController:MerchantTabBarController = MerchantTabBarController()
        
        self.navigationController?.pushViewController(tabBarController, animated: false)
    }
    
    func loadKlockWirkerTabBarController(){
        
        let tabBarController:KlockWirkTabBarController = KlockWirkTabBarController()
        
        self.navigationController?.pushViewController(tabBarController, animated: false)
        
    }
    

    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        registerNotification()
        setupDelegates()
    }
    
    
    func setupDelegates(){
        
        emaiAddress.delegate = self
        password.delegate = self
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if(textField.tag == 0){
            
        }
        else{
            
            textField.text = ""
            password.secureTextEntry = true
        }
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    
        
    }
    
    
    
    //MARK: Actions
    
    @IBAction func login(sender: AnyObject) {
        
        loginService.login(emaiAddress.text!, password: password.text!) { (response:NSDictionary) in
            
            let isKlockWirker   = response.objectForKey("isKlockWirker") as? Bool
            let isMerchant      = response.objectForKey("isMerchant") as? Bool
            let merchantId      = response.objectForKey("MerchantId") as? Int
            
            if(isKlockWirker == true){
                
                self.loadKlockWirkerTabBarController()
            }
            if(isMerchant == true){
                
                self.merchantService.getMerchant(merchantId!) {(response: NSDictionary) in
                    
                    ApplicationInformation.setMerchant(JSONUtilities.parseMerchant(response))
                }
                
                self.klockWirkService.getAllKlockWirkers(merchantId!) {(response: NSArray) in
                    
                    ApplicationInformation.setKlockWirkers(JSONUtilities.parseKlockWirkers(response))
                
                    self.loadMerchantTabBarController()
                }
            }
        }
    }
    
    @IBAction func newMerchantAccount(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController: MerchantSetupViewController(nibName: "MerchantSetupViewController", bundle: nil)), animated: true, completion: nil)
    }

    @IBAction func newKlockWirkerAccount(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController: KlockWirkerSetupViewController(nibName: "KlockWirkerSetupViewController", bundle: nil)), animated: true, completion: nil)
    }
}
