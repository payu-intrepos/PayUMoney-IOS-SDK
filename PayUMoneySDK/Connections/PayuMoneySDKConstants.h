//
//  SDKConstants.h
//  PayuMoney
//
//  Created by Kuldeep Saini on 11/3/15.
//  Copyright © 2015 PayuMoney. All rights reserved.
//

#ifndef SDKConstants_h
#define SDKConstants_h

#import "PayuMoneySDKConstants.h"
#import "PayuMoneySDKAppConstant.h"
#import "PayuMoneySDKRequestManager.h"
#import "PayuMoneySDKServiceParameters.h"
#import "PayuMoneySDKAppDelegate.h"
#import "PayuMoneySDKActivityView.h"
#import "NSString+Encode.h"
#import "UITextField+Keyboard.h"

#import "PayuMoneySDKCardView.h"


#import "PayuMoneySDKRequestParams.h"
#import "PayuMoneySDKSession.h"
#import "PayuMoneySDKNetBanking.h"
#import "PayuMoneySDKSavedCardCvv.h"
#import "PayuMoneySDKStoredCard.h"



#define StringFromDouble(x) [NSString stringWithFormat : @"%0.2lf",x]

#define ALERT(X,Y)    {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:X message:Y delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];[alert show];alert = nil;}

#define NOINTERNET    @"No Internet connection"
#define NETWORKCONNECTIONMESSAGE    @"Please connect your device to a network."
#define SDK_APP_DELEGATE ((PayuMoneySDKAppDelegate *)[[UIApplication sharedApplication] delegate])

#define Login_URL @"auth/oauth/token"
#define Auth_URL @"auth/user"
#define Payment_URL @"payment/app/payment/addSdkPayment"
#define Get_Payment_Merchant_URL @"payment/app/customer/getPaymentMerchant"
#define Sign_Up_URL @"auth/app/register"
#define Login_Params_URL @"auth/app/op/merchant/LoginParams"
#define OTP_URL @"auth/op/generateAndSendOTP"
#define Forgot_Password_URL @"auth/app/forgot/password"
#define Cancel_Transaction_URL @"payment/postBackParam.do"
#define Post_Payment_URL @"payment/app/postPayment"
#define One_CLick_Transaction_URL @"/auth/app/setUserPaymentOption"
#define KVAULT_PROD_URL @"https://www.payumoney.com/oneclick/getToken"
#define KVAULT_TEST_URL @"http://tvapaymon.payubiz.in/vault/getToken"
#define KVAULT_DELETE_TOKEN_URL_TEST @"http://tvapaymon.payubiz.in/vault/deleteToken"
#define KVAULT_DELETE_TOKEN_URL_PROD @"https://www.payumoney.com/oneclick/deleteToken"
#define TXNID @"txnid"
#define MERCHANTID @"merchantId"
#define SURL @"surl"
#define FURL @"furl"
#define PRODUCT_INFO @"productinfo"
#define FIRSTNAME @"firstname"
#define USER_EMAIL @"email"
#define USER_PHONE @"phone"
#define EMAIL_REGEX @"[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT_VALUE @"allowGuestCheckout"
#define MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT @"guestcheckout"
#define MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT_ONLY @"guestcheckoutonly"
#define OTP_LOGIN @"quickLogin"
#define EMAIL_REGEX @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define PASSWORD_REGEX @"^(?=.{6,}$)((.*[A-Za-z]+.*[0-9]+|.*[0-9]+.*[A-Za-z]+).*$)"
#define PHONE_REGEX @"^[6789]\\d{9}$"
#define LOADER_MESSAGE @"Please wait..."
#define APP_BACKGROUND_COLOR [UIColor whiteColor]

#define SDK_APP_TEXT_COLOR [UIColor colorWithRed:15.0/255.0 green:14.0/255.0 blue:12.0/255.0 alpha:1.0]
//
//#define HEADER_GREEN_COLOR [UIColor colorWithRed:136.0/255.0 green:179.0/255.0 blue:0.0/255.0 alpha:1.0]
//
//#define YELLOW_APP_COLOR [UIColor colorWithRed:253.0/255.0 green:216.0/255.0 blue:12.0/255.0 alpha:1.0]
#define SDK_WHITE_COLOR [UIColor whiteColor]
#define SDK_CLEAR_COLOR [UIColor clearColor]

#define SDK_BROWN_COLOR [UIColor colorWithRed:68.0/255.0 green:58.0/255.0 blue:28.0/255.0 alpha:1.0]
#define SDK_LIGHT_BROWN_COLOR [UIColor colorWithRed:171.0/255.0 green:164.0/255.0 blue:155.0/255.0 alpha:1.0]

#define SDK_UNDERLINE_TEXTFIELD_COLOR [UIColor darkGrayColor]

#define SDK_NOTIFICATION_BACKGROUND_COLOR [UIColor colorWithRed:255.0/255.0 green:247.0/255.0 blue:291.0/255.0 alpha:1.0]


#define SDK_PLAN_BACKGROUND_COLOR [UIColor colorWithRed:204.0/255.0 green:202.0/255.0 blue:199.0/255.0 alpha:1.0]

#define SDK_SCROLL_BACKGROUND_COLOR [UIColor colorWithRed:235.0/255.0 green:233.0/255.0 blue:230.0/255.0 alpha:1.0]
#define SDK_UNDERLINE_BACKGROUND_COLOR [UIColor colorWithRed:68.0/255.0 green:58.0/255.0 blue:28.0/255.0 alpha:1.0]

#define SDK_MAGENTA_OFFER_COLOR [UIColor colorWithRed:187.0/255.0 green:10.0/255.0 blue:74.0/255.0 alpha:1.0]

#define SDK_FONT_NORMAL(xx) [UIFont fontWithName:@"HelveticaNeue" size:xx]
#define SDK_FONT_MEDIUM(xx) [UIFont fontWithName:@"HelveticaNeue-Medium" size:xx]
#define SDK_FONT_BOLD(xx) [UIFont fontWithName:@"HelveticaNeue-Bold" size:xx]

#define KEY_MERCHANT_ID @"merchantID"
#define KEY_PAYMENT_ID @"paymentID"

#define SDK_APP_TITLE  @"PayUmoney"
#define SDK_KEYCHAIN_ACCOUNT_KEY @"PayUMoneySDKUnique"
#define amountregex @"\\d+(\\.\\d{1,2})?$"

#define SDK_BUNDLE_IDENTIFIER [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define CREDIT @"Credit Card"
#define DEBIT @"Debit Card"
#define SAVED @"Saved Cards"
#define NET_BANKING @"Net Banking"

#define SDK_amount @"amount"
#define SDK_firstName @"firstname"
#define SDK_txnId @"txnId"
#define SDK_merchantId @"merchantId"
#define SDK_phone  @"phone"
#define SDK_hash @"hash"
#define SDK_email @"email"
#define SDK_productinfo @"productInfo"
#define SDK_udf1 @"udf1"
#define SDK_udf2 @"udf2"
#define SDK_udf3 @"udf3"
#define SDK_udf4 @"udf4"
#define SDK_udf5 @"udf5"
#define SDK_key @"key"
#define SDK_salt @"salt"
#define SDK_surl @"surl"
#define SDK_furl @"furl"
#define SDK_result @"result"
#define SDK_keychain_id @"Logintest"
#define SDK_APP_CONSTANT [PayuMoneySDKAppConstant sharedInstance]

#endif /* SDKConstants_h */
