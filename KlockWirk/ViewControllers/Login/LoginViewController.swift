//
//  LoginViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 8/9/15.
//  Copyright (c) 2015 KlockWirk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate  {
    
 
    let loginService        = LoginService()
    let klockWirkService    = KlockWirkerServices()
    let merchantService     = MerchantServices()
  

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var registerButton: TKTransitionSubmitButton!
    @IBOutlet weak var loginButton: TKTransitionSubmitButton!
    @IBOutlet weak var emaiAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rememberMeButton: RadioButton!
    
    
    
    init(){
        
        super.init(nibName: "LoginViewController", bundle: nil);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
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
        stopActivityIndicator()
    }

    
    
    
    
    //MARK: Setup Methods
    
    func setupInputFields(){
    
        emaiAddress.autocorrectionType = .No
        emaiAddress.layer.borderWidth = 1.0
        emaiAddress.layer.borderColor = UIColor.lightGrayColor().CGColor
        emaiAddress.layer.cornerRadius = 3.0;
        emaiAddress.leftView           = UIView(frame: CGRectMake(0, 0, 5, 20))
        emaiAddress.leftViewMode        = UITextFieldViewMode.Always;
        
        password.autocorrectionType = .No
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.lightGrayColor().CGColor
        password.layer.cornerRadius = 3.0;
        password.leftView           = UIView(frame: CGRectMake(0, 0, 5, 20))
        password.leftViewMode        = UITextFieldViewMode.Always;
    }
    
    func setupLoginButton(){
        
       loginButton.layer.cornerRadius = 4
        activityIndicator.hidden = true
    }
    
    
    func setupRegisterButton(){
        
        registerButton.layer.cornerRadius = 4
    }
    
    func setupViewProperties(){
        
        self.title = "KlockWirk"
    }
    
    func setupNavigationButtons(){
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: UIBarButtonItemStyle.Plain, target: self, action: "registerButtonTapped")
    }
    
    func setupDelegates(){
        
        emaiAddress.delegate = self
        password.delegate = self
    }
    
    func setupRememberMeButton(){
        
        rememberMeButton.setImage(UIImage(named: "unchecked.png"), forState: .Normal)
        rememberMeButton.setImage(UIImage(named: "checked.png"), forState: .Selected)
        rememberMeButton.addTarget(self, action: "rememberMeTouched:", forControlEvents: UIControlEvents.ValueChanged)
        rememberMeButton.selected = false
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
    
    func areLoginFieldsValid() -> Bool{
        
        if(emaiAddress.text == "" || password.text == ""){
            
            return false
        }
        
        return true
    }

    
    

    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        registerNotification()
        setupViewProperties()
        setupInputFields()
        setupLoginButton()
        setupRegisterButton()
        setupRememberMeButton() 
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
    
    func storeUserLogin(){
        
        if(rememberMeButton.selected){
        
            ApplicationInformation.storeUserLogin(emaiAddress.text!,
                password: password.text!,
                shouldAutoLogin: true,
                isKlockWirker: ApplicationInformation.isKlockWirker(),
                isMerchant: ApplicationInformation.isMerchant())
        }
    }
    
    func loginUser(){
        
        ApplicationInformation.clearSharedData()
        
        self.view.endEditing(true)
        
        if(areLoginFieldsValid()){
            
            startActivityIndicator()
            
            loginService.login(emaiAddress.text!, password: password.text!) { (response:NSDictionary) in
                
                ApplicationInformation.setIsUserLoggedIn(true)
                
                let isKlockWirker   = response.objectForKey("isKlockWirker") as? Bool
                let isMerchant      = response.objectForKey("isMerchant") as? Bool
                let merchantId      = response.objectForKey("MerchantId") as? Int
                let klockWirkerId   = response.objectForKey("KlockWirkerId") as? Int
                
                if(isKlockWirker == true){
                    
                    ApplicationInformation.setIsKlockWirker(true)
                    ApplicationInformation.setKlockWirkerId(klockWirkerId!)
                    
                    self.klockWirkService.getKlockWirker(klockWirkerId!) {(response: KlockWirker) in
                        
                        self.loadKlockWirkerTabBarController()
                    }
                }
                if(isMerchant == true){
                    
                    ApplicationInformation.setIsMerchant(true)
                    ApplicationInformation.setMerchantId(merchantId!)
                    
                    self.merchantService.getMerchant(merchantId!) {(response: Merchant) in
                        
                        self.loadMerchantTabBarController()
                    }
                }
                
                self.storeUserLogin()
            }
        }
        else{
            
            if(emaiAddress.text == ""){
                
                shakeTextField(emaiAddress)
            }
            if(password.text == ""){
                
                shakeTextField(password)
            }
        }
        
        
    }
    
    
    
    //MARK Keyboard event handlers
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField == password){
            
            loginUser()
        }
        else{
            
            password.becomeFirstResponder()
        }
        
        return true;
    }
    
    

    
    //MARK Button event handlers
    
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
        
        loginUser()
    }
    
    @IBAction func rememberMeTouched(sender: RadioButton) {
        
        if(sender.selected){
            
            sender.selected = false
        }
        else if(sender.selected == false){
            
            sender.selected = true
        }
    }
    
    @IBAction func forgotPasswordTouched(sender: AnyObject) {
        
        self.presentViewController( UINavigationController(rootViewController: ForgotPasswordViewController()), animated: true, completion: nil)
    }
    

}
