//
//  PUMInternalConstants.h
//  PayUmoney_SampleApp
//
//  Created by Vipin Aggarwal on 10/11/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>
// logging on/off
#ifdef DEBUG
#define PayULog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define PayULog(...)
#endif

/*!
 ********************************************* API URLs *************************************
 */

//Axis Bank Rewards Program URLs
#define BANK_REWARDS_PROCESS_REQUEST                @"payment/op/aimia/processRequest"
#define BANK_REWARDS_SENDOTP                        @"payment/op/aimia/sendOTP"
#define BANK_REWARDS_FAILANDRETURNTOMERCHANT        @"payment/op/aimia/failAndReturnToMerchant"
#define BANK_REWARDS_RESETAIMIAENTRY                @"payment/op/aimia/resetAimiaEntry"
//End Axis Bank Rewards Program URLs

#define DOWNLOAD_BANKIMAGE                          @"media/images/payment/payment/netbanking/"
#define CC_BIN_DETAILS                              @"payment/op/v1/getBinDetails" // params bin=541891
#define ADD_PAYMENT                                 @"payment/app/v2/addPayment"
#define SEND_PAYMENT_OTP                            @"auth/op/sendPaymentOTP"
#define USER_REG_AND_LOGIN                          @"auth/op/registerAndLogin"
#define USER_GENERATE_WALLET_CODE                   @"/auth/app/generateWalletCode"
#define USER_LOGIN_URL                              @"auth/oauth/token"
#define USER_INFO_URL                               @"auth/app/user"
#define USER_LOAD_WALLET_URL                        @"payment/app/wallet/loadWalletPayment"
#define USER_FETCH_PAYMENT_USER_DATA_URL            @"payment/app/v1/fetchPaymentUserData"
#define FETCH_USER_DATA_URL                         @"payment/op/v1/fetchUserDataFromEmailMobile"
#define GET_MULTIPLE_BIN_DETAILS                    @"payment/op/v1/getMultipleBinDetails"


//Cards
#define GET_USER_SAVE_CARDS                         @"payment/op/hasSavedCard" //@"payment/op/getSaveCardCount" // params email=p.bharat@payu.in&phone=7200225586

//NB
#define  NB_BANK_LIST_URL                           @"payment/op/getNetBankingStatus"

//PURE USER WALLET
#define PWALLET_USER_MOBILE_NUM                     @"p_user_mobile_num"
#define PWALLET_USER_EMAIL                          @"p_user_email"
#define PWALLET_USER_OTP_MSG                        @"p_user_otp_msg"
#define PWALLET_USER_EXISTS_FOR_EMAIL               @"p_user_exist_for_email"
#define PWALLET_USER_GRANT_TYPE                     @"password"

#define Auth_URL                                    @"auth/user"
#define VERIFY_PAYMENT_STATUS                       @"payment/app/payment/verifyPaymentStatus" //POST
#define CHECK_PAYMENT_DETAILS_STATUS                @"payment/app/checkPaymentDetails"
#define Payment_URL                                 @"payment/app/payment/addSdkPayment"
#define Get_Payment_Merchant_URL                    @"payment/makePayment" //payment/app/customer/makePayment
#define Sign_Up_URL                                 @"auth/app/register"
#define Login_Params_URL                            @"auth/app/op/merchant/LoginParams"
#define OTP_URL                                     @"auth/op/generateAndSendOTP"
#define Forgot_Password_URL                         @"auth/app/forgot/password"
#define Cancel_Transaction_URL                      @"payment/postBackParam.do"
#define Cancel_Transaction                          @"payment/postBackParamIcp.do"
#define Post_Payment_URL                            @"payment/app/postPayment"

// ONE_TAP_ENABLE
#define ENABLE_ONE_TAP                              @"auth/app/setUserPaymentOption"  //params oneClickTxn=-1 OR 0 OR 1 <POST
//#define KVAULT_TEST_URL                             @"http://tvapaymon.payubiz.in/vault/getToken" //POST
#define KVAULT_TEST_URL                             @"https://pp41.payumoney.com/oneclick/getToken" //POST
#define KVAULT_DELETE_TOKEN_URL_TEST                @"http://tvapaymon.payubiz.in/vault/deleteToken"
#define KVAULT_PROD_URL                             @"https://www.payumoney.com/oneclick/getToken" //POST
#define KVAULT_DELETE_TOKEN_URL_PROD                @"https://www.payumoney.com/oneclick/deleteToken"
#define FETCH_EMI                                   @"payment/op/getEmiInterestForBank"

#define ANALYTICS_BASE_URL                          @"https://analyticsapi.citruspay.com/dcapi"
#define ANALYTICS_AUTH_ENDPOINT                     @"auth"
#define ANALYTICS_POST_EVENT_ENDPOINT               @"api/publishevents"


/*!
 ************************************** UI Related constants *****************************************
 */

#define DISABLE_TEXT_FIELD_BORDER   [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0]
#define ENABLE_TEXT_FIELD_BORDER    [UIColor colorWithRed:165.0/255.0 green:195.0/255.0 blue:57.0/255.0 alpha:1.0]

//Colors
#define COLOR_BLACK                 [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]
#define COLOR_LIGHT_GREEN           [UIColor colorWithRed:238.0/255.0 green:245.0/255.0 blue:216.0/255.0 alpha:1.0]
#define COLOR_ORANGE                [UIColor colorWithRed:244.0/255.0 green:171.0/255.0 blue:92.0/255.0 alpha:1.0]
#define COLOR_APP_BACKGROUND        [UIColor whiteColor]
#define COLOR_6AC451				[UIColor colorWithRed:106.0/255.0 green:196.0/255.0 blue:81.0/255.0 alpha:1.0]
#define COLOR_D3D3D3				[UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0]
#define COLOR_717171				[UIColor colorWithRed:113.0/255.0 green:113.0/255.0 blue:113.0/255.0 alpha:1.0]
#define COLOR_231120				[UIColor colorWithRed:35.0/255.0 green:17.0/255.0 blue:32.0/255.0 alpha:1.0]
#define COLOR_A5C339				[UIColor colorWithRed:165.0/255.0 green:195.0/255.0 blue:57.0/255.0 alpha:1.0]
#define COLOR_EFEFEF				[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0]
#define COLOR_414042				[UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:66.0/255.0 alpha:1.0]
#define COLOR_D6D6D4				[UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:212.0/255.0 alpha:1.0]
#define COLOR_E6E7E8				[UIColor colorWithRed:230.0/255.0 green:231.0/255.0 blue:232.0/255.0 alpha:1.0]
#define COLOR_F0F4E0				[UIColor colorWithRed:240.0/255.0 green:244.0/255.0 blue:224.0/255.0 alpha:1.0]
#define COLOR_F79622				[UIColor colorWithRed:247.0/255.0 green:150.0/255.0 blue:34.0/255.0 alpha:1.0]
#define COLOR_484749				[UIColor colorWithRed:72.0/255.0 green:71.0/255.0 blue:73.0/255.0 alpha:1.0]
#define COLOR_7F7F7F				[UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0]
#define COLOR_231F20				[UIColor colorWithRed:35.0/255.0 green:31.0/255.0 blue:32.0/255.0 alpha:1.0]
#define COLOR_D0D2CF				[UIColor colorWithRed:208.0/255.0 green:210.0/255.0 blue:207.0/255.0 alpha:1.0]
#define COLOR_C9C9C9				[UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0]
#define COLOR_EDC8C4				[UIColor colorWithRed:237.0/255.0 green:200.0/255.0 blue:196.0/255.0 alpha:1.0]
#define COLOR_ERR_MSG [UIColor colorWithRed:196.0/255.0 green:64.0/255.0 blue:63.0/255.0 alpha:1.0]

//Symbols
#define RUPEES_SIGN_TEXT @"₹"

//Fonts
#define FONT_NORMAL(xx)             [UIFont fontWithName:@"Helvetica" size:xx]
#define FONT_LIGHT(xx)              [UIFont fontWithName:@"Helvetica-Light" size:xx]
#define FONT_MEDIUM(xx)             [UIFont fontWithName:@"Helvetica-Medium" size:xx]
#define FONT_BOLD(xx)               [UIFont fontWithName:@"Helvetica-Bold" size:xx]

#define ALL_UITEXTFIELD_HEIGHT      55.0f
#define PAY_BUTTON_HEIGHT           50.0f
#define CARD_ENTRY_CELL_HEIGHT      250
#define GUEST_USER_CELL_HEIGHT      270
#define EMI_NORMAL_STATE_HEIGHT     70.0
#define EMI_SELECTED_STATE_HEIGHT   150.0
#define EMI_BUTTON_HEIGHT           45.0
#define FASTER_CARD_OTP_HEIGHT      270


/*!
 ***************************************************   Security ********************************
 */
#define AIMIA_CONSTANTS_EDGE_CARD_NUMBER_ENCRYPT_PREFIX     @"7_7'x5|>H@Ih'4S"
#define SDK_KEYCHAIN_ACCOUNT_KEY                            @"PayUMoneySDKUnique"
#define SDK_KEYCHAIN_TOKEN_KEY                              @"PayUMoneySDKToken"
#define AUTHORIZATION_SALT                                  @"payumoney12"
//#define AUTHORIZATION_SALT                                @"paiumkney183"

/*!
 ************************************************** Regular expressions ************************
 */

#define PASSWORD_REGEX              @"^(?=.{6,}$)((.*[A-Za-z]+.*[0-9]+|.*[0-9]+.*[A-Za-z]+).*$)"
#define PHONE_REGEX                 @"^[6789]\\d{9}$"
#define EMAIL_REGEX                 @"[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

/*!
 ************************************************** Text Constants *****************************
 */
#define SDK_APP_TITLE               @"PayUmoney"
#define NOINTERNET                  @"No Internet connection"
#define NETWORKCONNECTIONMESSAGE    @"Please connect your device to a network."
#define LOADER_MESSAGE              @"Please wait..."
#define SUCCESS_RESPONSE           @"payumoney/success.php"
#define FAILURE_RESPONSE           @"payumoney/failure.php"
/*!
 ************************************************** Macros **************************************
 */
#define SDK_BUNDLE_IDENTIFIER   [[[NSBundle bundleForClass:[self class]] infoDictionary] objectForKey:@"CFBundleIdentifier"]

#define StringFromDouble(x) [NSString stringWithFormat : @"%0.2lf",x]

/*!
 ************************************************** Keys ***************************************
 */
#define KEY_MERCHANT_ID             @"merchantID"
#define PUBLIC_KEY                  @"PUBLIC_KEY"
#define KEY_PAYMENT_ID              @"paymentID"
#define KEY_PAYMENT_ID_LWALLET      @"paymentID_load_wallet"
#define KEY_ACCESS_TOKEN            @"access_token"
#define KEY_USER_EMAIL              @"user_email"
#define KEY_USER_PHONE              @"user_phone"
#define KEY_REMEMBER_ON_THIS_DEVICE @"remember_on_this_device"
#define KEY_ONE_TAP_KEY             @"one_tap_status"
#define KEY_SAVE_CURRENT_CARD       @"save_current_card"
#define KEY_ORDER_AMOUNT_KEY        @"orderAmount"
#define KEY_TOTAL_AMOUNT_TO_PAY_KEY @"total_amount_to_pay"
#define KEY_OFFER_TYPE_KEY          @"offerType"
#define KEY_OFFER_AMOUNT_KEY        @"offerAmount"


#define kNavBarHeight               64
#define kSDK_TXN_CALLBACK           @"passdata"
#define kSDK_TXN_SUCCESS            @"success"
#define kSDK_TXN_FAILURE            @"failure"
#define kSDK_TXN_REJECTED           @"rejected"

#define KEY_NITRO_ENABLED           @"nitroEnabled"
#define KEY_RESULT                  @"result"

#define KEY_USER_ENABLED            @"userEnabled"
#define KEY_USER_ID                 @"userId"
/*!
 ************************************************** General ************************************
 */
#define configData                  @"configData"
#define merchantCategoryType        @"merchantCategoryType"
#define onlywallet                  @"onlywallet"
#define CREDIT                      @"Credit Card"
#define SWITCH_USER_ACCOUNT         @"Switch Account"
#define DEBIT                       @"Debit Card"
#define SAVED                       @"Saved Cards"
#define NET_BANKING                 @"Net Banking"
#define USER_AGENT_FOR_SDK          @"PayUMoneyiOSSDK"
#define ERROR_WHEN_KEY_NULL         @"Unexpected error occured"

/*!
 ************************************************** Internal Environments ***********************
 */
#define ENVIRONMENT_PP42                                        @"PP42"
#define ENVIRONMENT_PP25                                        @"PP25"
#define ENVIRONMENT_PP41                                        @"PP41"
#define ENVIRONMENT_PP10                                        @"PP10"
#define ENVIRONMENT_PP0                                         @"PP0"
#define ENVIRONMENT_PP4                                         @"PP4"
#define ENVIRONMENT_MOBILE_TEST                                 @"MobileTest"

//API URLs
#define ENVIRONMENT_PRODUCTION_API_URL                          @"https://www.payumoney.com/"
#define ENVIRONMENT_TEST_API_URL                                @"https://www.payumoney.com/sandbox/"
#define ENVIRONMENT_PP42_API_URL                                @"https://pp42.payumoney.com/"
#define ENVIRONMENT_PP25_API_URL                                @"https://pp25.payumoney.com/"
#define ENVIRONMENT_PP48_API_URL                                @"https://pp51.payumoney.com/"
#define ENVIRONMENT_PP41_API_URL                                @"https://pp41.payumoney.com/"
#define ENVIRONMENT_PP10_API_URL                                @"https://pp10.payumoney.com/"
#define ENVIRONMENT_PP0_API_URL                                 @"https://pp0.payumoney.com/"
#define ENVIRONMENT_PP4_API_URL                                 @"https://pp4.payumoney.com/"
#define ENVIRONMENT_PP22_API_URL                                @"https://pp22.payumoney.com/"
#define ENVIRONMENT_MOBILE_TEST_API_URL                         @"https://mobiletest.payumoney.com/"
#define ENVIRONMENT_PP44_API_URL                                @"https://pp44.payumoney.com/"

//Web URLs
#define ENVIRONMENT_PRODUCTION_WEB_URL                          @"https://secure.payu.in/_payment"
#define ENVIRONMENT_TEST_WEB_URL                                @"https://sandboxsecure.payu.in/_payment"
#define ENVIRONMENT_PP42_WEB_URL                                @"http://pp42.secure.payu.in/_payment"
#define ENVIRONMENT_PP25_WEB_URL                                @"http://pp25.secure.payu.in/_payment"
#define ENVIRONMENT_PP41_WEB_URL                                @"http://pp41.secure.payu.in/_payment"
#define ENVIRONMENT_PP10_WEB_URL                                @"http://pp10.secure.payu.in/_payment"
#define ENVIRONMENT_PP0_WEB_URL                                 @"http://pp0.secure.payu.in/_payment"
#define ENVIRONMENT_PP48_WEB_URL                                @"http://pp51.secure.payu.in/_payment"
#define ENVIRONMENT_PP4_WEB_URL                                 @"http://pp4.secure.payu.in/_payment"
#define ENVIRONMENT_MOBILE_TEST_WEB_URL                         @"http://mobiletest.payu.in/_payment"
#define ENVIRONMENT_PP22_WEB_URL                                @"http://pp22.secure.payu.in/_payment"
#define ENVIRONMENT_PP44_WEB_URL                                @"http://pp44.secure.payu.in/_payment"



#define TXNID @"txnid"
#define MERCHANTID @"merchantId"
#define SURL @"surl"
#define FURL @"furl"
#define PRODUCT_INFO @"productinfo"
#define FIRSTNAME @"firstname"
#define USER_EMAIL @"email"
#define USER_PHONE @"phone"
#define OTP_LOGIN @"quickLogin"



/*!
 ************************************************** Analytics **********************************
 */
#define DEVICE_ANALYTICS                                        @"PUMDeviceAnalytics"
#define EVENT_ANALYTICS                                         @"PUMEventAnalytics"
#define ANALYTICS_TIMEOUT_INTERVAL                              5
#define TEMP_ANALYTICS                                          @"PUMTempAnalytics"
#define ANALYTICS_API_KEY @"377B75201AAA8CCC59468DBD3239F8ED15FACCCD017C03628DDFAC808074128B"
#define ANALYTICS_SECRET_KEY @"BO0l3u5zQGE5mxav24tXf0Ge6CdFQLIEjr6xZbKEah0SX2s22Dh2sQ"

/*!
 ************************************************** ENUMs **************************************
 */



#define     RAW_JSON                                            @"RawJSON"
#define     PARSED_RESPONSE                                     @"ParsedResponse"




typedef NS_ENUM(NSInteger, PUMBaseURLCategory) {
    PUMBaseURLForAPI,
    PUMBaseURLForWeb
};

typedef NS_ENUM(NSInteger, PUMInternalEnvironment) {
    PUMEnvironmentMobileTest = 3,
    PUMEnvironmentPP42,
    PUMEnvironmentPP41,
    PUMEnvironmentPP10,
    PUMEnvironmentPP0,
    PUMEnvironmentPP4,
    PUMEnvironmentPP22,
    PUMEnvironmentPP48,
    PUMEnvironmentPP44,
    PUMEnvironmentPP25
};


typedef NS_ENUM(NSInteger,SDK_REQUEST_TYPE ) {
    // SDK Enums
    SDK_USER_SAVE_CARDS,
    SDK_SEND_OTP,
    SDK_RESEND_OTP,
    SDK_CC_BIN_DETAILS,
    SDK_REQUEST_SIGNUP = 200,
    SDK_REQUEST_PAYMENT,
    SDK_REQUEST_GET_PAYMENT_MERCHANT,
    SDK_REQUEST_PARAMS,
    SDK_REQUEST_OTP,
    SDK_REQUEST_LOGIN,
    SDK_REQUEST_KVAULT_TEST,
    SDK_REQUEST_KVAULT_PROD,
    SDK_REQUEST_USER_REG_AND_LOGIN,
    SDK_REQUEST_GET_PROFILE,
    SDK_REQUEST_FORGOT_PASSWORD,
    SDK_CANCEL_TRANSACTION,
    SDK_REQUEST_CANCEL_TXN_MANUALLY,
    SDK_REQUEST_POST_PAYMENT,
    SDK_REQUEST_ONE_CLICK,
    SDK_REQUEST_HASH,
    SDK_REQUEST_CARD_ONE_CLICK,
    BANK_REWARDS_FETCH,
    SDK_REQUEST_ONE_TAP,
    SDK_AFTER_LOGIN,
    SDK_REQUEST_BANK_LIST,
    SDK_REQUEST_LOAD_WALLET,
    BANK_REWARDS_FETCH_POINTS,
    SDK_GENERATE_WALLET_CODE,
    SDK_FETCH_PAYMENT_USER_DATA,
    SDK_FETCH_PAYMENT_PROFILE_DATA,
    SDK_EMI_DETAILS,
    SDK_ANALYTICS_FETCH_API_TOKEN,
    SDK_ANALYTICS_SEND,
    SDK_FETCH_USER_DATA,
    SDK_GET_MULTIPLE_BIN_DETAILS
    
};

static NSString *const kPUMAOTP = @"OTP";
static NSString *const kPUMAPassword = @"Password";


@interface PUMInternalConstants : NSObject
@end
