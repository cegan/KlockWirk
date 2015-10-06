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
    let scheduleService     = SchedulService()
    
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
        
        shakeTextField(emaiAddress)
        shakeTextField(password)
        
        loginButton.setTitle("Sign In", forState: UIControlState.Normal)
        
        stopActivityIndicator()
    }

    func installSplashImage(){
        
       
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
    
    func setupInputFields(){
        
        emaiAddress.autocorrectionType = .No
        emaiAddress.layer.borderWidth = 1.0
        emaiAddress.layer.borderColor = UIColor.lightGrayColor().CGColor
        emaiAddress.layer.cornerRadius = 3.0;
        
        password.autocorrectionType = .No
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.lightGrayColor().CGColor
        password.layer.cornerRadius = 3.0;
    }
    
    func setupLoginButton(){
        
        loginButton.setTitle("Sign in", forState: .Normal)
        loginButton.titleLabel?.font = UIFont(name: "Gotham-Medium", size: 14)
        loginButton.layer.cornerRadius = 3
        
        activityIndicator.hidden = true
        activityIndicator.color = UIColor.whiteColor()
        activityIndicator.frame = loginButton.titleLabel!.frame
        loginButton.addSubview(activityIndicator)
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
    
    func endEditing(){
        
        self.view.endEditing(true)
    }
    
    func shakeTextField(textField: UITextField){
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - 10, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + 10, textField.center.y))
        textField.layer.addAnimation(animation, forKey: "position")
    }

    
    

    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        registerNotification()
        setupViewProperties()
        setupInputFields()
        setupLoginButton()
        setupNavigationButtons()
        setupDelegates()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    

    
    
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.6)
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
        
        ApplicationInformation.clearSharedData()
   
        loginButton.setTitle("", forState: UIControlState.Normal)
        
        endEditing()
        startActivityIndicator()
               
  
        loginService.login(emaiAddress.text!, password: password.text!) { (response:NSDictionary) in
            
            let isKlockWirker   = response.objectForKey("isKlockWirker") as? Bool
            let isMerchant      = response.objectForKey("isMerchant") as? Bool
            let merchantId      = response.objectForKey("MerchantId") as? Int
            let klockWirkerId   = response.objectForKey("KlockWirkerId") as? Int
            
            if(isKlockWirker == true){
                
                ApplicationInformation.setIsKlockWirker(true)
                
                self.klockWirkService.getKlockWirker(klockWirkerId!) {(response: KlockWirker) in
            
                    self.loadKlockWirkerTabBarController()
                }
            }
            if(isMerchant == true){
                
                ApplicationInformation.setIsMerchant(true)
                
                self.merchantService.getMerchant(merchantId!) {(response: Merchant) in
                    
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
