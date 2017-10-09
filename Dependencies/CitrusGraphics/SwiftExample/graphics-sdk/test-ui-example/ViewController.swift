//
//  ViewController.swift
//  CitrusGraphicsExample
//
//  Created by Mukesh Patil on 10/4/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

import UIKit

import CitrusPay
import CitrusGraphics

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    var authLayer : CTSAuthLayer?
    var profileLayer : CTSProfileLayer?
    
   var walletArray : NSMutableArray?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activity: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Citrus Graphics Demo v\(CITRUSGRAPHICS_VERSION)"
        self.initializeSDK()
        
        
        self.getWalletAction()

        if #available(iOS 10.0, *) {
            //tableView?.prefetchDataSource = self
        }
    }
    
    
    func initializeSDK() -> Void {
        
        CitrusPaymentSDK.initWithSign(inID: SignInIdSB, signInSecret: SignInSecretKeySB, signUpID: SubscriptionIdSB, signUpSecret: SubscriptionSecretKeySB, vanityUrl: VanityUrlSB, environment: CTSEnvSandbox)
        
//        CitrusPaymentSDK.setLogLevel(.verbose)
        
        self.authLayer = CTSAuthLayer.fetchShared()
        self.profileLayer = CTSProfileLayer.fetchShared()
    }

    
    @IBAction func loginAction() {
        self.siginIn()
    }

      func siginIn() {
        DispatchQueue.main.async {
            self.activity.startAnimating()
        }

        self.authLayer?.requestMasterLink(nil,
                                          mobile: TEST_MOBILE,
                                          scope:CTSWalletScopeLimited,
                                          completionHandler: { (linkResponse, error) -> Void in
                                            DispatchQueue.main.async {
                                                if (error != nil) {
                                                    UIUtility.toastMessage(onScreen: error?.localizedDescription)
                                                    print("Response JSON: \(String(describing: error?.localizedDescription))")
                                                }
                                                else {
                                                    UIUtility.toastMessage(onScreen: linkResponse?.userMessage)
                                                    print("success")
                                                }
                                                self.activity.stopAnimating()
                                            }
                                            
        })
    }
    
    
    @IBAction func getWalletAction() {
        if ((self.walletArray?.count) != nil) {
            self.walletArray?.removeAllObjects()
            DispatchQueue.main.async {
                CitrusGraphics.clearCache()
                self.tableView.reloadData()
            }
        }
        self.getWalletInfo()
    }

    func getWalletInfo() {
        DispatchQueue.main.async {
            self.activity.startAnimating()
        }
        
        self.profileLayer?.requestPaymentInformation(completionHandler: { (consumerProfile, error) in
            if ((error) != nil) {
                UIUtility.toastMessage(onScreen: error?.localizedDescription)
                print("Response JSON: \(String(describing: error?.localizedDescription))")
            }
            else {
                print("success : consumerProfile :\(String(describing: consumerProfile?.paymentOptionsList))")
                
                self.walletArray = consumerProfile?.paymentOptionsList
                
               // let netBankingArray = consumerProfile?.getSavedNBPaymentOptions()
                //let debitCardArray = consumerProfile?.getSavedDCPaymentOptions()
               // let creditCardArray = consumerProfile?.getSavedCCPaymentOptions()

              //  self.walletArray?.addObjects(from: netBankingArray!)
              //  self.walletArray?.addObjects(from: debitCardArray!)
               // self.walletArray?.addObjects(from: creditCardArray!)
                
                print("walletArray :\(String(describing: self.walletArray))")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            DispatchQueue.main.async {
                self.activity.stopAnimating()
            }
        })
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((self.walletArray?.count) != nil) {
            return (self.walletArray?.count)!
        }
        else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CGCell", for: indexPath) as! TableViewCell
        
        let dict : NSDictionary = self.walletArray![indexPath.row] as! NSDictionary
        
        let paymentMode = dict["paymentMode"] as! String
        let paymentMode_NET_BANKING = "NET_BANKING"
        let paymentMode_DEBIT_CARD = "DEBIT_CARD"
        let paymentMode_CREDIT_CARD = "CREDIT_CARD"

        DispatchQueue.main.async {
            if paymentMode == paymentMode_NET_BANKING {
                cell.cellLabel?.text = dict["name"] as? String
                cell.cellImageView?.setSystemActivity()
                cell.cellImageView?.loadCitrusBank(bankCID: (dict["issuerCode"] as? String)!)
            }
            else if paymentMode == paymentMode_DEBIT_CARD || paymentMode == paymentMode_CREDIT_CARD {
                cell.cellLabel?.text = dict["name"] as? String
                cell.cellImageView?.setSystemActivity()
                cell.cellImageView?.loadCitrusCard(cardScheme: (dict["cardScheme"] as? String)!)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

}
