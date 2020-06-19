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
 ************************************** UI Related constants *****************************************
 */

#define DISABLE_TEXT_FIELD_BORDER   [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0]
#define ENABLE_TEXT_FIELD_BORDER    [UIColor colorWithRed:165.0/255.0 green:195.0/255.0 blue:57.0/255.0 alpha:1.0]

//Colors
#define COLOR_BLACK                 [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]
#define COLOR_LIGHT_GREEN           [UIColor colorWithRed:238.0/255.0 green:245.0/255.0 blue:216.0/255.0 alpha:1.0]
#define COLOR_ORANGE                [UIColor colorWithRed:244.0/255.0 green:171.0/255.0 blue:92.0/255.0 alpha:1.0]
#define COLOR_APP_BACKGROUND        [UIColor whiteColor]
#define COLOR_6AC451                [UIColor colorWithRed:106.0/255.0 green:196.0/255.0 blue:81.0/255.0 alpha:1.0]
#define COLOR_D3D3D3                [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0]
#define COLOR_717171                [UIColor colorWithRed:113.0/255.0 green:113.0/255.0 blue:113.0/255.0 alpha:1.0]
#define COLOR_231120                [UIColor colorWithRed:35.0/255.0 green:17.0/255.0 blue:32.0/255.0 alpha:1.0]
#define COLOR_A5C339                [UIColor colorWithRed:165.0/255.0 green:195.0/255.0 blue:57.0/255.0 alpha:1.0]
#define COLOR_EFEFEF                [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0]
#define COLOR_414042                [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:66.0/255.0 alpha:1.0]
#define COLOR_D6D6D4                [UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:212.0/255.0 alpha:1.0]
#define COLOR_E6E7E8                [UIColor colorWithRed:230.0/255.0 green:231.0/255.0 blue:232.0/255.0 alpha:1.0]
#define COLOR_F0F4E0                [UIColor colorWithRed:240.0/255.0 green:244.0/255.0 blue:224.0/255.0 alpha:1.0]
#define COLOR_F79622                [UIColor colorWithRed:247.0/255.0 green:150.0/255.0 blue:34.0/255.0 alpha:1.0]
#define COLOR_484749                [UIColor colorWithRed:72.0/255.0 green:71.0/255.0 blue:73.0/255.0 alpha:1.0]
#define COLOR_7F7F7F                [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0]
#define COLOR_231F20                [UIColor colorWithRed:35.0/255.0 green:31.0/255.0 blue:32.0/255.0 alpha:1.0]
#define COLOR_D0D2CF                [UIColor colorWithRed:208.0/255.0 green:210.0/255.0 blue:207.0/255.0 alpha:1.0]
#define COLOR_C9C9C9                [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0]
#define COLOR_EDC8C4                [UIColor colorWithRed:237.0/255.0 green:200.0/255.0 blue:196.0/255.0 alpha:1.0]
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


typedef NS_ENUM(NSInteger, PUMBaseURLCategory) {
    PUMBaseURLForAPI,
    PUMBaseURLForWeb,
    PUMBaseURLForCitrusCheckout
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
    PUMEnvironmentPP25,
    PUMEnvironmentPP58
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
    SDK_GET_MULTIPLE_BIN_DETAILS,
    SDK_VALIDATE_VPA
};

static NSString *const kPUMAOTP = @"OTP";
static NSString *const kPUMAPassword = @"Password";


@interface PUMInternalConstants : NSObject
@end
