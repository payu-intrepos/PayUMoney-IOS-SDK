//
//  HomeViewController.swift
//  CitrusPayExample
//
//  Created by Mukesh Patil on 4/19/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

import UIKit

class HomeViewController: BaseClassViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Core SDK Demo v\(SDK_VERSION)"

        self.defaultLoginView()

        //        self.login()
    }
    
    func defaultLoginView() -> Void {
        let userDetails = CTSUser()
        userDetails.mobile = TEST_MOBILE
        userDetails.email = TEST_EMAIL
        userDetails.firstName = TEST_FIRST_NAME //optional
        userDetails.lastName = TEST_LAST_NAME //optional
        userDetails.address = nil //optional
        
        self.authLayer?.requestDefaultLoginView(userDetails,
                                                scope: CTSWalletScopeFull,
                                                customParams: nil,
                                                screenOverride: false,
                                                viewController: self,
                                                callback: { (error , response) in
                                                    if(error != nil) {
                                                        UIUtility.toastMessage(onScreen:error?.localizedDescription)
                                                        print("error: \(String(describing: error?.localizedDescription))")
                                                    } else {
                                                        print("success: \(String(describing: response))")
                                                        UIUtility.toastMessage(onScreen: "Success")
                                                    }
        })
    }

    func login() -> Void {
        self.authLayer?.requestMasterLink(TEST_EMAIL,
                                          mobile: TEST_MOBILE,
                                          scope:CTSWalletScopeFull,
                                          completionHandler: { (linkResponse, error) -> Void in
                                            if(error != nil){
                                                UIUtility.toastMessage(onScreen:error?.localizedDescription)
                                                print("Response JSON: \(String(describing: error?.localizedDescription))")
                                            }else{
                                                UIUtility.toastMessage(onScreen: linkResponse?.userMessage)
                                                print("success")
                                                
                                                DispatchQueue.main.async {
                                                    self.showAndVerifyOtp()
                                                }
                                            }
                                            
        })
    }
    
    func showAndVerifyOtp() -> Void {
        
        let alert = UIAlertController (title: "", message: "Please enter the OTP sent to your phone", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            // Now do whatever you want with inputTextField (remember to unwrap the optional)
            self.authLayer?.requestMasterLinkSignIn(withPassword: alert.textFields![0].text,
                                                    passwordType: PasswordTypeOtp,
                                                    completionHandler: { (error) -> Void in
                                                        if (error != nil) {
                                                            // Handle Error
                                                            UIUtility.toastMessage(onScreen: "Verification Failed")
                                                            print("Verification Failed")
                                                        }
                                                        else{
                                                            // Handle Success
                                                            UIUtility.toastMessage(onScreen: "Success")
                                                            print("success")
                                                            CTSOauthManager.readPasswordSigninOuthData();
                                                        }
            })
        }))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "OTP"
            textField.keyboardType=UIKeyboardType.numberPad
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // this is just sample code
    class  func requestBillAmount (amount :NSString, customParams :NSArray, billURL :NSString, completion : @escaping (_ bill :CTSBill? ,_ error :NSError?)->Void){
        let session = URLSession.shared;
        
        let url = NSURL(string: "\(billURL)?amount\(amount)&\(customParams)")
        
        let loadTask = session.dataTask(with: url! as URL) { data, response, error in
            // let loadTask = session.dataTaskWithURL(url! as URL) { (data :NSData?, response :URLResponse?, error :NSError?) -> Void in
            if let errorResponse = error {
                completion(nil, errorResponse as NSError?)
            }else if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode != 200 {
                    let errorResponse = NSError(domain: "Domain", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey :"Http status code has unexpected value"])
                    completion(nil, errorResponse)
                }else{
                    let dataString = String(data: data!, encoding: String.Encoding.utf8)
                    var jsonError : JSONModelError?
                    let sampleBill: CTSBill = CTSBill(string:dataString, error:&jsonError)
                    if (jsonError != nil) {
                        completion(sampleBill, nil)
                    }
                    else {
                        completion(sampleBill, nil)
                    }
                }
            }
        }
        loadTask.resume()
        
    }
}
