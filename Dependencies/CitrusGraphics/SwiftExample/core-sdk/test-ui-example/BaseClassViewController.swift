//
//  BaseClassViewController.swift
//  CitrusPayExample
//
//  Created by Mukesh Patil on 4/19/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

import Foundation
import CitrusPay

class BaseClassViewController: UIViewController {
    
    var authLayer : CTSAuthLayer?
    var profileLayer : CTSProfileLayer?
    var paymentLayer : CTSPaymentLayer?
    
    var contactInfo : CTSContactUpdate?
    var addressInfo : CTSUserAddress?
    var customParams: [String : AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initializeSDK()
    }
    
    
    func initializeSDK() -> Void {
            
        CitrusPaymentSDK.initWithSign(inID: SignInIdSB, signInSecret: SignInSecretKeySB, signUpID: SubscriptionIdSB, signUpSecret: SubscriptionSecretKeySB, vanityUrl: VanityUrlSB, environment: CTSEnvSandbox)
        
        CitrusPaymentSDK.setLogLevel(.verbose)
        
        CitrusPaymentSDK.enableLoader()
        
        CitrusPaymentSDK.setLoaderColor(UIColor .orange)
        
        self.authLayer = CTSAuthLayer.fetchShared()
        self.profileLayer = CTSProfileLayer.fetchShared()
        self.paymentLayer = CTSPaymentLayer.fetchShared()
        
        
        contactInfo?.firstName = TEST_FIRST_NAME;
        contactInfo?.lastName = TEST_LAST_NAME;
        contactInfo?.email = TEST_EMAIL;
        contactInfo?.mobile = TEST_MOBILE;
        
        addressInfo?.city = TEST_CITY;
        addressInfo?.country = TEST_COUNTRY;
        addressInfo?.state = TEST_STATE;
        addressInfo?.street1 = TEST_STREET1;
        addressInfo?.street2 = TEST_STREET2;
        addressInfo?.zip = TEST_ZIP;
        
        customParams = ["USERDATA2":"MOB_RC|9988776655" as AnyObject,
            "USERDATA10":"test" as AnyObject,
            "USERDATA4":"MOB_RC|test@gmail.com" as AnyObject,
            "USERDATA3":"MOB_RC|4111XXXXXXXX1111" as AnyObject]
        
    }
    
    
}

