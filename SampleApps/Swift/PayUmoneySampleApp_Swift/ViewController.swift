//
//  ViewController.swift
//  frameworkIntegration
//
//  Created by Honey Lakhani on 1/16/17.
//  Copyright © 2017 com.payu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  //MARK: Stored properties
  var params : PUMRequestParams = PUMRequestParams.shared()
  var utils : Utils = Utils()
  
  //MARK: IBOutlets
  @IBOutlet weak var txtFldAmt: UITextField!
  @IBOutlet weak var txtFldName: UITextField!
  @IBOutlet weak var txtFldEmail: UITextField!
  @IBOutlet weak var txtFldProductInfo: UITextField!
  
  //MARK: IBActions
  @IBAction func btnSubmitClicked(_ sender: Any) {
    startPayment()
  }
  
  //MARK: UIView lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: Helper methods
  func startPayment() -> Void {
    if((txtFldAmt.text) != nil){
      if (Double(txtFldAmt.text!)! > 1000000.00) {
        showAlertViewWithTitle(title: "Amount Exceeding the limit", message: "1000000")
        return
      }
      params.amount = txtFldAmt.text;
    }
     //PUMEnvironment.test for test environment and PUMEnvironment.production for live environment.
      params.environment = PUMEnvironment.test;
      params.firstname = txtFldName.text;
      params.key = "40747T";
      params.merchantid = "396132";  //Merchant merchantid
      params.logo_url = ""; //Merchant logo_url
      params.productinfo = "Product Info";
      params.email = txtFldEmail.text;  //user email
      params.phone = ""; //user phone
      params.txnid = utils.getRandomString(2);  //set your correct transaction id here
      params.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php";
      params.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php";
    
    //Below parameters are optional. It is to store any information you would like to save in PayU Database regarding trasnsaction. If you do not intend to store any additional info, set below params as empty strings.
    
      params.udf1 = "";
      params.udf2 = "";
      params.udf3 = "";
      params.udf4 = "";
      params.udf5 = "";
      params.udf6 = "";
      params.udf7 = "";
      params.udf8 = "";
      params.udf9 = "";
      params.udf10 = "";
    //We strictly recommend that you calculate hash on your server end. Just so that you can quickly see demo app working, we are providing a means to do it here. Once again, this should be avoided.
    if(params.environment == PUMEnvironment.production){
      generateHashForProdAndNavigateToSDK()
    }
    else{
     calculateHashFromServer()
    }
      // assign delegate for payment callback.
    params.delegate = self;
     }
  
  func generateHashForProdAndNavigateToSDK() -> Void {
    let txnid = params.txnid!
    //add your salt in place of 'salt' if you want to test on live environment.
    //We suggest to calculate hash from server and not to keep the salt in app as it is a severe security vulnerability.
    let hashSequence : NSString = "\(params.key)|\(txnid)|\(params.amount)|\(params.productinfo)|\(params.firstname)|\(params.email)|||||||||||salt" as NSString
    let data :NSString = utils.createSHA512(hashSequence as String!) as NSString
    params.hashValue = data as String!;
       startPaymentFlow();
  }


  func transactinCanceledByUser() -> Void {
    self.dismiss(animated: true){
      self.showAlertViewWithTitle(title: "Message", message: "Payment Cancelled ")
    }
  }
 
  func startPaymentFlow() -> Void {
    let paymentVC : PUMMainVController = PUMMainVController()
    var paymentNavController : UINavigationController;
    paymentNavController = UINavigationController(rootViewController: paymentVC);
    self.present(paymentNavController, animated: true, completion: nil)
  }
  
  func transactionCompleted(withResponse response : NSDictionary,errorDescription error:NSError) -> Void {
    self.dismiss(animated: true){
      self.showAlertViewWithTitle(title: "Message", message: "congrats! Payment is Successful")
    }
  }
  

  func transactinFailed(withResponse response : NSDictionary,errorDescription error:NSError) -> Void {
    self.dismiss(animated: true){
      self.showAlertViewWithTitle(title: "Message", message: "Oops!!! Payment Failed")
    }
  }
  
  func showAlertViewWithTitle(title : String,message:String) -> Void {
    let alertController : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
      UIAlertAction in
      NSLog("OK Pressed")
    }
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
  }

// MARK:HASH CALCULATION
  
  //hash calculation strictly recommended to be done on your server end. This is just to show the hash sequence format and oe the api call for hash should be. Encryption is SHA-512.
 func prepareHashBody()->NSString{
  return "key=\(params.key!)&amount=\(params.amount!)&txnid=\(params.txnid!)&productinfo=\(params.productinfo!)&email=\(params.email!)&firstname=\(params.firstname!)" as NSString;
  }

 func calculateHashFromServer(){
  let config = URLSessionConfiguration.default // Session Configuration
  let session = URLSession(configuration: config) // Load configuration into Session
  let url = URL(string: "https://test.payumoney.com/payment/op/v1/calculateHashForTest")!
  var request = URLRequest(url: url)
  request.httpBody = prepareHashBody().data(using: String.Encoding.utf8.rawValue)
  request.httpMethod = "POST"
  
  let task = session.dataTask(with: request, completionHandler: {
    (data, response, error) in
    if error != nil {
      print(error!.localizedDescription)
    } else {
      do {
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]{
          //Implement your logic
          print(json)
          let status : NSNumber = json["status"] as! NSNumber
          if(status.intValue == 0)
          {
           self.params.hashValue = json["result"] as! String!
            OperationQueue.main.addOperation {
              self.startPaymentFlow()
            }
          }
          else{
            OperationQueue.main.addOperation {
            self.showAlertViewWithTitle(title: "Message", message: json["message"] as! String)
            }
          }
        }
      } catch {
        print("error in JSONSerialization")
      }
    }
  })
    task.resume()
  }
}
