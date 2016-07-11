//
//  PayuRequestManager.h
//  PayuMoney
//
//  Created by Imran Khan on 10/5/15.
//  Copyright © 2015 PayuMoney. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    
    
    // SDK Enums
    SDK_REQUEST_SIGNUP = 200,
    SDK_REQUEST_PAYMENT,
    SDK_REQUEST_GET_PAYMENT_MERCHANT,
    SDK_REQUEST_PARAMS,
    SDK_REQUEST_OTP,
    SDK_REQUEST_LOGIN,
    SDK_REQUEST_GET_PROFILE,
    SDK_REQUEST_FORGOT_PASSWORD,
    SDK_CANCEL_TRANSACTION,
    SDK_REQUEST_CANCEL_TXN_MANUALLY,
    SDK_REQUEST_POST_PAYMENT,
    SDK_REQUEST_ONE_CLICK,
    SDK_REQUEST_HASH,
    SDK_REQUEST_CARD_ONE_CLICK
    
}SDK_REQUEST_TYPE;



// // Test Mode
#define SDK_BASE_URL(xx) [NSString stringWithFormat:@"https://mobiletest.payumoney.com/%@",xx]
#define Web_Payment_URL @"https://mobiletest.payu.in/_seamless_payment"
#define SDK_Hash_Url  @"http://mobiletest.payumoney.com/payment/op/calculateHashForTest"

//

//#define SDK_BASE_URL(xx) [NSString stringWithFormat:@"http://pp10.payumoney.com/%@",xx]
//#define Web_Payment_URL @"http://pp10.payu.in/_seamless_payment"

//#define SDK_BASE_URL(xx) [NSString stringWithFormat:@"http://pp0.payumoney.com/%@",xx]
//#define Web_Payment_URL @"http://pp0.secure.payu.in/_seamless_payment"

// Dev
//#define SDK_BASE_URL(xx) [NSString stringWithFormat:@"https://mobiledev.payumoney.com/%@",xx]
//#define Web_Payment_URL @"https://mobiledev.payu.in/_seamless_payment"

// Live Mode
//#define SDK_BASE_URL(xx) [NSString stringWithFormat:@"https://www.payumoney.com/%@",xx]
//#define Web_Payment_URL @"https://secure.payu.in/_seamless_payment"
//



@interface PayuMoneySDKRequestManager : NSObject<NSURLSessionDataDelegate>

-(void)hitWebServiceForURLWithPostBlock:(BOOL)isPost isAccessTokenRequired:(BOOL)tokenRequired webServiceURL:(NSString *)apiURL withBody:(NSString *)requestBody andTag:(SDK_REQUEST_TYPE)tag completionHandler:(void (^)(id, SDK_REQUEST_TYPE, NSError *))callback;



@end
