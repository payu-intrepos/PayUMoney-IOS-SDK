//
//  ViewController.swift
//  PlugNPlay
//
//  Created by mukeshpatil1 on 01/17/2017.
//  Copyright (c) 2017 mukeshpatil1. All rights reserved.
//

import UIKit
import Foundation

import PlugNPlay

import QuartzCore

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var authLayer : CTSAuthLayer?
    
    @IBOutlet weak var tfEmail : UITextField?
    @IBOutlet weak  var tfMobile : UITextField?
    @IBOutlet weak  var tfAmount : UITextField?
    @IBOutlet weak  var tfTopNavColor : UITextField?
    @IBOutlet weak  var tfNavTitleColor : UITextField?
    @IBOutlet weak  var tfButtonColor : UITextField?
    @IBOutlet weak  var tfButtonTextColor : UITextField?
    @IBOutlet weak  var tfMerchantDisplayName : UITextField?
    var toConstraint : NSLayoutConstraint?
    @IBOutlet weak  var serverSelector : UISegmentedControl?
    @IBOutlet weak  var navigationBar : UINavigationBar?
    @IBOutlet weak  var btnPayment : UIButton?
    @IBOutlet weak  var btnMyWallet : UIButton?
    @IBOutlet weak  var navItem : UILabel?
    @IBOutlet weak  var scrollView : UIScrollView?
    var fieldInAction : UITextField?
    var activeField : UITextField?
    @IBOutlet weak var version : UILabel?
    
    var email : NSString?
    var mobile : NSString?
    var amount : NSString?
    var navBarColorText : NSString?
    var navBarTitleColorText : NSString?
    var buttonColorText : NSString?
    var buttonTitleColorText : NSString?
    var merchantName : NSString?
    var billUrl : NSString?
    var loadWalletReturnUrl : NSString?
    var customParams: [String : AnyObject] = [:]
    
    var isCompletionDisable : Bool?
    var isWalletDisable : Bool?
    var isCardsDisable : Bool?
    var isNetbankDisable : Bool?
    var keyboardVisible : Bool?
    
    
    let SCROLLVIEW_HEIGHT = 600
    let SCROLLVIEW_WIDTH = 320
    let defaultTopNavColor = "F79523"
    let defaultNavTitleColor = "FFFFFF"
    let defaultButtonColor = "F79523"
    let defaultButtonTextColor = "FFFFFF"
    let defaultMerchantName = "Shopmatics"
    
    func tapped() {
        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        keyboardVisible = false
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("topNavColor:%@",tfTopNavColor?.text ?? "")
        isCompletionDisable = false
        isCardsDisable = false
        isNetbankDisable = false
        isWalletDisable = false
        
        let tapScroll : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapped))
        tapScroll.cancelsTouchesInView = true
        scrollView?.addGestureRecognizer(tapScroll)
        
        
        scrollView?.delegate = self
        keyboardVisible = false
        tfEmail?.delegate = self
        tfMobile?.delegate = self
        tfAmount?.delegate = self
        
        self.view.backgroundColor = UIColor.white
        
        tfTopNavColor?.delegate = self
        tfNavTitleColor?.delegate = self
        tfButtonColor?.delegate = self
        tfButtonTextColor?.delegate = self
        
        tfNavTitleColor?.clearButtonMode = UITextFieldViewMode.whileEditing
        tfButtonColor?.clearButtonMode = UITextFieldViewMode.whileEditing
        tfButtonTextColor?.clearButtonMode = UITextFieldViewMode.whileEditing
        tfTopNavColor?.clearButtonMode = UITextFieldViewMode.whileEditing
        
        
        self.loadThemeColor()
        
        let countryCode : UILabel = UILabel(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        countryCode.text = " +91"
        countryCode.font = UIFont.boldSystemFont(ofSize: 14)
        tfMobile?.leftView = countryCode
        tfMobile?.leftViewMode = UITextFieldViewMode.always
        navItem?.text = tfMerchantDisplayName?.text
        serverSelector?.selectedSegmentIndex = 1
        
        var font : UIFont = UIFont()
        if #available(iOS 8.2, *) {
            font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        } else {
            // Fallback on earlier versions
        }
        serverSelector?.setTitleTextAttributes([NSFontAttributeName: font],
                                               for: .normal)
        
        self.version?.text = "© Citrus Payments. PlugNPlay Demo v\(PLUGNPLAY_VERSION)"
        
        self.initPNP()
    }
    
    
    func loadThemeColor() {
        print("topNavColor1 :%@",tfTopNavColor?.text ?? "")
        
        let navColor = self.initFromHexString(hexStr: (tfTopNavColor?.text)!)
        print("navColor :%@",navColor)
        navigationBar?.barTintColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfTopNavColor?.text)!))
        tfNavTitleColor?.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfNavTitleColor?.text)!))
        
        tfTopNavColor?.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfTopNavColor?.text)!))
        tfButtonColor?.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfButtonColor?.text)!))
        tfButtonTextColor?.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfButtonTextColor?.text)!))
        btnPayment?.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfButtonColor?.text)!))
        navItem?.textColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfNavTitleColor?.text)!))
        btnMyWallet?.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfButtonColor?.text)!))
        
        btnMyWallet?.setTitleColor(CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfButtonTextColor?.text)!)), for: UIControlState.normal)
        btnPayment?.setTitleColor(CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: (tfButtonTextColor?.text)!)), for: UIControlState.normal)
    }
    
    
    func resetThemeDetails() {
        UserDefaults.standard.removeObject(forKey: "NAVCOLOR")
        UserDefaults.standard.removeObject(forKey: "NAVTITLECOLOR")
        
        UserDefaults.standard.removeObject(forKey: "BUTTONCOLOR")
        UserDefaults.standard.removeObject(forKey: "BUTTONTEXTCOLOR")
        
        tfTopNavColor?.text = defaultTopNavColor
        tfNavTitleColor?.text = defaultNavTitleColor
        tfButtonColor?.text = defaultButtonColor
        tfButtonTextColor?.text = defaultButtonTextColor
    }
    
    func fetchRememberedDetails() {
        
        email = UserDefaults.standard.string(forKey: "EMAIL") as NSString?
        amount = UserDefaults.standard.string(forKey: "AMOUNT") as NSString?
        mobile = UserDefaults.standard.string(forKey: "MOBILE") as NSString?
        navBarColorText = UserDefaults.standard.string(forKey: "NAVCOLOR") as NSString?
        
        navBarTitleColorText = UserDefaults.standard.string(forKey: "NAVTITLECOLOR") as NSString?
        buttonColorText = UserDefaults.standard.string(forKey: "BUTTONCOLOR") as NSString?
        buttonTitleColorText = UserDefaults.standard.string(forKey: "BUTTONTEXTCOLOR") as NSString?
        merchantName = UserDefaults.standard.string(forKey: "MERCHANTNAME") as NSString?
        
        if email?.length != 0 {
            tfEmail?.text = email as String?
        }
        if amount?.length != 0 {
            tfAmount?.text = amount as String?
        }
        if mobile?.length != 0 {
            tfMobile?.text = mobile as String?
        }
        if navBarColorText?.length != 0 {
            tfTopNavColor?.text = navBarColorText as String?
        }
        if navBarTitleColorText?.length != 0 {
            tfNavTitleColor?.text = navBarTitleColorText as String?
        }
        if buttonColorText?.length != 0 {
            tfButtonColor?.text = buttonColorText as String?
        }
        if buttonTitleColorText?.length != 0 {
            tfButtonTextColor?.text = buttonTitleColorText as String?
        }
        if merchantName?.length != 0 {
            tfMerchantDisplayName?.text = merchantName as String?
        }
    }
    
    
    func rememberEnteredDetails() {
        UserDefaults.standard.set(tfAmount?.text, forKey: "AMOUNT")
        UserDefaults.standard.set(tfEmail?.text, forKey: "EMAIL")
        UserDefaults.standard.set(tfMobile?.text, forKey: "MOBILE")
        
        UserDefaults.standard.set(tfTopNavColor?.text, forKey: "NAVCOLOR")
        UserDefaults.standard.set(tfNavTitleColor?.text, forKey: "NAVTITLECOLOR")
        UserDefaults.standard.set(tfButtonColor?.text, forKey: "BUTTONCOLOR")
        UserDefaults.standard.set(tfButtonTextColor?.text, forKey: "BUTTONTEXTCOLOR")
        UserDefaults.standard.set(tfMerchantDisplayName?.text, forKey: "MERCHANTNAME")
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillBeShown(notification : NSNotification){
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        let activeTextFieldRect: CGRect? = activeField?.frame
        let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
        if (!aRect.contains(activeTextFieldOrigin!)) {
            scrollView?.scrollRectToVisible(activeTextFieldRect!, animated:true)
        }
    }
    
    func keyboardWillBeHidden(notification : NSNotification) {
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        keyboardVisible = true
    }
    
    
    func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.fetchRememberedDetails()
        
        self.registerForKeyboardNotifications()
        self.scrollView?.contentSize = CGSize(width: SCROLLVIEW_WIDTH, height: SCROLLVIEW_HEIGHT)
        keyboardVisible = false
    }
    
    func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func initPNP() {
        if self.selectedEnv() == CTSEnvSandbox {
            CitrusPaymentSDK.initWithSign(inID: SignInIdSB, signInSecret: SignInSecretKeySB, signUpID: SubscriptionIdSB, signUpSecret: SubscriptionSecretKeySB, vanityUrl: VanityUrlSB, environment: CTSEnvSandbox)
            CitrusPaymentSDK.setLogLevel(CTSLogLevel.verbose)
            
            billUrl = BillUrlSB as NSString?
            loadWalletReturnUrl = LoadWalletReturnUrlSB as NSString?
            
        }else if(self.selectedEnv() == CTSEnvProduction){
            CitrusPaymentSDK.initWithSign(inID: SignInIdProd, signInSecret: SignInSecretKeyProd, signUpID: SubscriptionIdProd, signUpSecret: SubscriptionSecretKeyProd, vanityUrl: VanityUrlProd, environment: CTSEnvProduction)
            CitrusPaymentSDK.setLogLevel(CTSLogLevel.verbose)
            
            billUrl = BillUrlProd as NSString?
            loadWalletReturnUrl = LoadWalletReturnUrlProd as NSString?
        }
        
        print("topNavColor:%@",tfTopNavColor?.text ?? "")
        let topNavHexInt : UInt32 = self.initFromHexString(hexStr: (tfTopNavColor?.text)!)
        
        let topTitleHexInt : UInt32 = self.initFromHexString(hexStr: (tfNavTitleColor?.text)!)
        
        let buttonHexInt : UInt32 = self.initFromHexString(hexStr: (tfButtonColor?.text)!
        )
        
        let buttonTitleHexInt : UInt32 = self.initFromHexString(hexStr: (tfButtonTextColor?.text)!)
        
        
        //#008312 - green
        //#C333A1 - purple
        //#EF5B30 - orange
        //#35CA4B - light green
        
        // CitrusPaymentSDK.setTopBarColor(UIColorFromRGB(topNavHexInt))
        // [CitrusPaymentSDK setTopBarColor:UIColorFromRGB(topNavHexInt)];
        CitrusPaymentSDK.setTopBarColor(CTSUtility.getColorFromRGB(topNavHexInt))
        CitrusPaymentSDK.setTopTitleTextColor(CTSUtility.getColorFromRGB(topTitleHexInt))
        CitrusPaymentSDK.setButtonColor(CTSUtility.getColorFromRGB(buttonHexInt))
        CitrusPaymentSDK.setButtonTextColor(CTSUtility.getColorFromRGB(buttonTitleHexInt))
        CitrusPaymentSDK.setIndicatorTintColor(UIColor.orange)
        
    }
    
    @IBAction func pay() {
        self.makePayment()
    }
    
    @IBAction func resetTheme() {
        self.resetThemeDetails()
    }
    
    func selectedEnv() -> CTSEnvironment {
        if serverSelector?.selectedSegmentIndex == 0 {
            return CTSEnvSandbox
        }
        return CTSEnvProduction
    }
    
    
    func makePayment() {
        tfAmount?.resignFirstResponder()
        tfMobile?.resignFirstResponder()
        tfEmail?.resignFirstResponder()
        
        self.initPNP()
        PlugNPlay.setMerchantDisplayName(tfMerchantDisplayName?.text)
        
        PlugNPlay.disableCompletionScreen(isCompletionDisable!)
        PlugNPlay.disableCards(isCardsDisable!)
        PlugNPlay.disableNetbanking(isNetbankDisable!)
        PlugNPlay.disableWallet(isWalletDisable!)
        
        let paymentInfo : PlugAndPlayPayment = PlugAndPlayPayment()
        paymentInfo.billUrlOrCTSBillObject = self.billUrl
        paymentInfo.payAmount = tfAmount?.text
        
        let user : CTSUser = CTSUser()
        user.mobile = tfMobile?.text
        user.email = tfEmail?.text
        
        user.firstName = "firstName" //Optional
        user.lastName = "lastName" //Optional
        user.address = nil //Optional
        
        self.rememberEnteredDetails()
        
        PlugNPlay.presentPaymentsViewController(paymentInfo, for: user, viewController: self) { (paymentReceipt, error) in
            if((error) != nil){
                UIUtility.toastMessage(onScreen: error?.localizedDescription)
            }else{
                
                if(paymentReceipt?.isSuccess())!{
                    UIUtility.toastMessage(onScreen: "payment successful")
                }else{
                    UIUtility.toastMessage(onScreen: NSString(format: "Failed, %@",(paymentReceipt?.transactionStatus())!) as String!)
                    
                }
            }
        }
        
    }
    
    
    @IBAction func myWallet() {
        tfAmount?.resignFirstResponder()
        tfMobile?.resignFirstResponder()
        tfEmail?.resignFirstResponder()
        
        
        //prepare all the parameters for Plug and Play
        self.initPNP()
        let user : CTSUser = CTSUser()
        user.mobile = tfMobile?.text
        user.email = tfEmail?.text
        
        user.firstName = "firstName"
        user.lastName = "lastName"
        user.address = nil
        
        self.rememberEnteredDetails()
        
        customParams = ["USERDATA2":"MOB_RC|9988776655" as AnyObject,
                        "USERDATA10":"test" as AnyObject,
                        "USERDATA4":"MOB_RC|test@gmail.com" as AnyObject,
                        "USERDATA3":"MOB_RC|4111XXXXXXXX1111" as AnyObject]
        
        PlugNPlay.presentWalletViewController(user,
                                              returnURL: self.loadWalletReturnUrl as String!,
                                              customParams: customParams,
                                              viewController: self) { (error) in
                                                if((error) != nil){
                                                    UIUtility.toastMessage(onScreen: error?.localizedDescription)
                                                }
                                                else {
                                                    UIUtility.toastMessage(onScreen: "payment successful")
                                                }
        }
    }
    
    @IBAction func signOut() {
        self.doSignOut()
        UIUtility.toastMessage(onScreen: "Signout Successful")
    }
    
    
    func doSignOut() {
        let authLayer : CTSAuthLayer = CitrusPaymentSDK.fetchSharedAuthLayer()
        authLayer.signOut()
        
        self.initPNP()
        
    }
    
    func initFromHexString(hexStr : String) -> UInt32 {
        var hexInt : UInt32 = 0
        // Create scanner
        let scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    @IBAction func disableCompletion(sender : UISwitch) {
        var isDisable : Bool = false
        if sender.isOn {
            isDisable = true
        }
        isCompletionDisable = isDisable
    }
    
    @IBAction func disableWallet(sender : UISwitch) {
        var isDisable : Bool = false
        if sender.isOn {
            isDisable = true
        }
        isWalletDisable = isDisable
        
    }
    
    @IBAction func  disableNetbanking(sender : UISwitch) {
        var isDisable : Bool = false
        if sender.isOn {
            isDisable = true
        }
        isNetbankDisable = isDisable
    }
    
    @IBAction func disableCards(sender : UISwitch) {
        var isDisable : Bool = false
        if sender.isOn {
            isDisable = true
        }
        isCardsDisable = isDisable
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfEmail?.resignFirstResponder()
        tfMobile?.resignFirstResponder()
        tfAmount?.resignFirstResponder()
        tfNavTitleColor?.resignFirstResponder()
        tfButtonTextColor?.resignFirstResponder()
        tfButtonColor?.resignFirstResponder()
        tfButtonTextColor?.resignFirstResponder()
        tfMerchantDisplayName?.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let contentInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        self.scrollView?.contentInset = contentInsets
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (fieldInAction?.tag)! > 5 {
            
            textField.backgroundColor =  CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: textField.text!))
        }
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fieldInAction = textField
        activeField = textField
        self.scrollView?.isScrollEnabled = true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag > 5 {
            if (textField.text?.characters.count)! >= 6 && string.characters.count > 0 {
                return false
            }
            
            var finalColorString : NSString?
            if string.characters.count > 0 {
                finalColorString = NSString(format: "%@%@",textField.text!,string)
            }else{
                finalColorString =  (textField.text! as NSString).replacingCharacters(in: range, with: string) as? NSString
            }
            textField.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: finalColorString! as String))
            
            if textField.tag == 9 {
                navigationBar?.barTintColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: finalColorString! as String))
                // navigationBar?.barTintColor
            }else if (textField.tag == 8){
                navItem?.textColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: finalColorString! as String))
            }else if (textField.tag == 7){
                btnPayment?.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: finalColorString! as String))
                btnMyWallet?.backgroundColor = CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: finalColorString! as String))
            }else{
                
                btnMyWallet?.setTitleColor(CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: finalColorString! as String)), for: UIControlState.normal)
                btnPayment?.setTitleColor(CTSUtility.getColorFromRGB(self.initFromHexString(hexStr: finalColorString! as String)), for: UIControlState.normal)
            }
        }else if(textField.tag == 5){
            var finalMerchantName : NSString?
            if string.characters.count > 0 {
                finalMerchantName = NSString(format: "%@%@",textField.text!,string)
            }else{
                
                
                finalMerchantName =  (textField.text! as NSString).replacingCharacters(in: range, with: string) as? NSString
                
            }
            navItem?.text = finalMerchantName as String?
        }
        return true
    }
    
    @IBAction func selectorValueChanged() {
        self.doSignOut()
    }
    
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
}
