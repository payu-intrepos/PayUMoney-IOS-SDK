//
//  ViewController.swift
//  LazyPayExample
//
//  Created by Mukesh Patil on 12/20/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

import UIKit

import LazyPay

class ViewController: UIViewController {

    @IBOutlet weak var mobileTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var amountTextField: UITextField?
    @IBOutlet weak var signOutButton: UIBarButtonItem?
    @IBOutlet weak var initiatePaytButton: UIButton?
    @IBOutlet weak var checkEligibliytButton: UIButton?
    @IBOutlet weak var indicatorView: UIActivityIndicatorView?

    var user: LPUserDetails!
    var addressInfo: LPUserAddress!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.checkEligibliytButton?.layer.cornerRadius = 5
        self.initiatePaytButton?.layer.cornerRadius = 5

        title = "LazyPay Demo v\(LAZYPAY_VERSION)"

        self.initializeSDK()

        self.setAddress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if LazyPay.isUserSignedIn() {
            self.signOutButton?.title = "SignOut"
            self.mobileTextField?.isHidden = true
            self.emailTextField?.isHidden = true
            self.checkEligibliytButton?.isHidden = true
        }
        else {
            self.signOutButton?.title = ""
            self.mobileTextField?.isHidden = false
            self.emailTextField?.isHidden = false
            self.checkEligibliytButton?.isHidden = false
        }
        self.mobileTextField?.text = ""
        self.emailTextField?.text = ""
        self.amountTextField?.text = ""
    }

    func initializeSDK() -> Void {
        CitrusPaymentSDK.initWithSign(inID: SignInIdSB, signInSecret: SignInSecretKeySB, signUpID: SubscriptionIdSB, signUpSecret: SubscriptionSecretKeySB, vanityUrl: VanityUrlSB, environment: CTSEnvSandbox)
        
        CitrusPaymentSDK.setLogLevel(.verbose)
    }
    
    func setAddress() -> Void {
            addressInfo = LPUserAddress()
            addressInfo.city = "TEST_CITY"
            addressInfo.country = "TEST_COUNTRY"
            addressInfo.state = "TEST_STATE"
            addressInfo.street1 = "TEST_STREET1"
            addressInfo.street2 = "TEST_STREET2"
            addressInfo.zip = "TEST_ZIP"
    }
    
    func isInputDataSet() -> Bool {
        DispatchQueue.main.async(execute: {() -> Void in
            self.indicatorView?.isHidden = false
            self.indicatorView?.startAnimating()
        })

        if !LazyPay.isUserSignedIn() {
            if ((self.mobileTextField?.text?.characters.count)! == 0 ||
                self.emailTextField?.text?.characters.count == 0) {
                var alertController: UIAlertController!
                alertController = UIAlertController(title: "Error!", message: "Input data can't be empty!!\nPlease enter valid input.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok action"), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                    print("Ok action")
                })
                alertController.addAction(okAction)
                DispatchQueue.main.async(execute: {() -> Void in
                    self.present(alertController, animated: true, completion: { _ in })
                })
                
                self.mobileTextField?.resignFirstResponder()
                self.emailTextField?.resignFirstResponder()

                return false
            }
        }
        
        if ((self.amountTextField?.text?.characters.count)! == 0) {
            var alertController: UIAlertController!
            alertController = UIAlertController(title: "Error!", message: "Input data can't be empty!!\nPlease enter valid input.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok action"), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                print("Ok action")
            })
            alertController.addAction(okAction)
            DispatchQueue.main.async(execute: {() -> Void in
                self.present(alertController, animated: true, completion: { _ in })
            })
            
            self.amountTextField?.resignFirstResponder()

            return false
        }
        
        user = LPUserDetails()
        user.email = self.emailTextField?.text
        user.mobile = self.mobileTextField?.text
        
        return true
    }

    
   @IBAction func canMakePayment() -> Void {

    if self.isInputDataSet() == false {
        DispatchQueue.main.async(execute: {() -> Void in
            self.indicatorView?.stopAnimating()
            self.indicatorView?.isHidden = true
        })
        return
    }

   let lazyPayConfig = LazyPayConfig.init(CFloat((self.amountTextField?.text)!)!,
                                          billUrl: BillUrlSB,
                                          productSkuDetails: nil,
                                          user: user!,
                                          address: addressInfo!)
    
    LazyPay.canMakePayment(lazyPayConfig!) { (JSON, error) in
        var alertController: UIAlertController!
        if (error != nil) {
            alertController = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: .alert)
        }
        else {
            var chekEligibility: LPChekEligibility!
            chekEligibility = JSON as! LPChekEligibility!
            alertController = UIAlertController(title: "Success!", message: chekEligibility.reason!, preferredStyle: .alert)
        }
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok action"), style: .default, handler: {(_ action: UIAlertAction) -> Void in
            print("Ok action")
        })
        alertController.addAction(okAction)
        DispatchQueue.main.async(execute: {() -> Void in
            self.indicatorView?.stopAnimating()
            self.indicatorView?.isHidden = true

            self.present(alertController, animated: true, completion: { _ in })
        })
    }
    
    }

    
    @IBAction func initiatePayment() -> Void {
        if self.isInputDataSet() == false {
            DispatchQueue.main.async(execute: {() -> Void in
                self.indicatorView?.stopAnimating()
                self.indicatorView?.isHidden = true
            })
            return
        }

        let lazyPayConfig = LazyPayConfig.init(CFloat((self.amountTextField?.text)!)!,
                                               billUrl: BillUrlSB,
                                               productSkuDetails: nil,
                                               user: user!,
                                               address: addressInfo!)

        LazyPay.initiatePayment(lazyPayConfig,
                                andParentViewController: self) {
                                    (JSON, error) in
            var alertController: UIAlertController!
            if (error != nil) {
                alertController = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: .alert)
            }
            else {
                var paymentReceipt: NSDictionary
                paymentReceipt = JSON as! NSDictionary
                 let paymentStatus = paymentReceipt["TxStatus"]
                 alertController = UIAlertController(title: "Success!!", message: "TxStatus : \(paymentStatus!)", preferredStyle: .alert)
            }
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok action"), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                print("Ok action")
            })
            
             alertController.addAction(okAction)
            DispatchQueue.main.async(execute: {() -> Void in
                self.indicatorView?.stopAnimating()
                self.indicatorView?.isHidden = true

                self.present(alertController, animated: true, completion: { _ in })
            })
        }
    }

    @IBAction func logOutButtonAction() {
        if LazyPay.isUserSignedIn() {
            let alertController = UIAlertController(title: "Warning!!", message: "Are you sure you want to logout.", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: NSLocalizedString("Yes", comment: "Yes action"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                print("Yes action")
                if LazyPay.signOut() {
                    self.mobileTextField?.isHidden = false
                    self.emailTextField?.isHidden = false
                    self.checkEligibliytButton?.isHidden = false
                    self.signOutButton?.title = ""
                }
            })
            let noAction = UIAlertAction(title: NSLocalizedString("No", comment: "No action"), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                print("No action")
            })
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.present(alertController, animated: true, completion: { _ in })
            })
        }
    }
}

