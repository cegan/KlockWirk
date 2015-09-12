//
//  LoginViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/9/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate  {
    
    var btn: TKTransitionSubmitButton!
    
    let loginService        = LoginService()
    let klockWirkService    = KlockWirkerServices()
    let merchantService     = MerchantServices()
    
    let activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var registerButton: TKTransitionSubmitButton!
    @IBOutlet weak var loginButton: TKTransitionSubmitButton!
    @IBOutlet weak var emaiAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    
    
    func onTapButton(button: TKTransitionSubmitButton) {
        
        button.animate(100000, completion: { () -> () in

        })
    }


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
        
        
        loginButton.returnToOriginalState()
        
        let alertController = UIAlertController(title: "Login", message:
            "Login Failed", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        stopActivityIndicator()
    }

    func installSplashImage(){
        
        let u = ImageUtilities()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       
      
        let imageView = UIImageView(frame: appDelegate.window!.frame)
        
     
        imageView.image = UIImage(named: "bartenders")
       // self.window!.addSubview(imageView)
        
        
       
        
        self.view.addSubview(imageView)
        
        self.view.bringSubviewToFront(emaiAddress)
        self.view.bringSubviewToFront(password)
        self.view.bringSubviewToFront(loginButton)
        self.view.bringSubviewToFront(registerButton)
        
        
        
        
    }
    
    
    
    //MARK: Setup Methods
    
    func setupLoginButton(){
        
        
        loginButton.setTitle("Sign in", forState: .Normal)
        loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        
        
//        activityIndicator.hidden = true
//        activityIndicator.color = UIColor.whiteColor()
//        activityIndicator.frame = CGRectMake(125, 12, 15, 15)
        
       // loginButton.backgroundColor = UIColor(red: 30.0/255, green: 171.0/255, blue: 242.0/255, alpha: 1.0)
       // loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
      //  loginButton.layer.cornerRadius = 5
        
       // loginButton.addSubview(activityIndicator)
    }
    
    func setupViewProperties(){
        
        self.title = "KlockWirk"
    }
    
    func setupNavigationButtons(){
        
        let register = UIBarButtonItem(title: "Register", style: UIBarButtonItemStyle.Plain, target: self, action: "registerButtonTapped")
        
        self.navigationItem.rightBarButtonItem = register
    }
    
    func setupDelegates(){
        
        emaiAddress.delegate = self
        password.delegate = self
    }
    
    
    
    //MARK: Utility Methods
    
    func storeKlockWirkers(klockWirkers: NSArray){
        
        ApplicationInformation.setKlockWirkers(JSONUtilities.parseKlockWirkers(klockWirkers))
    }
    
    func loadMerchantTabBarController(){
        
        let tbc = MerchantTabBarController()
        tbc.transitioningDelegate = self
        self.presentViewController(tbc, animated: true, completion: nil)
    }
    
    func loadKlockWirkerTabBarController(){
        
        let tbc = KlockWirkTabBarController()
        tbc.transitioningDelegate = self
        self.presentViewController(tbc, animated: true, completion: nil)
    }
    
    func startActivityIndicator(){
        
        activityIndicator.hidden = false;
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator(){
        
        activityIndicator.hidden = true;
        activityIndicator.stopAnimating()
    }
    

    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        registerNotification()
        setupViewProperties()
        setupLoginButton()
        setupNavigationButtons()
        setupDelegates()
        installSplashImage()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
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
    
    
    
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TKFadeInAnimator(transitionDuration: 1.0, startingAlpha: 0.6)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    
    //MARK: Actions
    
    @IBAction func register(sender: AnyObject) {
        
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        
        let klockWirkerAction = UIAlertAction(title: "KlockWirker", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
            self.presentViewController(UINavigationController(rootViewController: KlockWirkerSetupViewController(nibName: "KlockWirkerSetupViewController", bundle: nil)), animated: true, completion: nil)
            
        })
        let merchantAction = UIAlertAction(title: "Merchant", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
            self.presentViewController(UINavigationController(rootViewController: MerchantSetupViewController(nibName: "MerchantSetupViewController", bundle: nil)), animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        
        
        optionMenu.addAction(klockWirkerAction)
        optionMenu.addAction(merchantAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func login(sender: AnyObject) {
        
        
        loginButton.animate(100000, completion: { () -> () in
            
        })
        
        
        self.view.endEditing(true)
        startActivityIndicator()
        
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
    
    func registerButtonTapped(){
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        
        let klockWirkerAction = UIAlertAction(title: "KlockWirker", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
            self.presentViewController(UINavigationController(rootViewController: KlockWirkerSetupViewController(nibName: "KlockWirkerSetupViewController2", bundle: nil)), animated: true, completion: nil)
            
        })
        let merchantAction = UIAlertAction(title: "Merchant", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
            self.presentViewController(UINavigationController(rootViewController: MerchantSetupViewController(nibName: "MerchantSetupViewController", bundle: nil)), animated: true, completion: nil)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        
        
        optionMenu.addAction(klockWirkerAction)
        optionMenu.addAction(merchantAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }


}
