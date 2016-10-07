//
//  AppConstant.h
//  PayuMoneyApp
//
//  Created by Honey Lakhani on 7/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PayuMoneySDKKeychainItemWrapper.h"
#import "PayuMoneySDKReachability.h"



//TODO: Set Input Params Fields Here



#define MERCHANT_KEY @""
#define MERCHANT_SALT @""
#define MERCHANT_SURL @"https://test.payumoney.com/mobileapp/payumoney/success.php"
#define MERCHANT_FURL @"https://test.payumoney.com/mobileapp/payumoney/failure.php"
#define MERCHANT_ID @""


//TODO: Set it to 0 for LIVE transactions and 1 is for TEST environment
#define IS_DEBUG 1



#define USER_INPUT_EMAIL @"piyush.jain@payu.in"
#define USER_INPUT_TXN_ID @"0nf7"
#define USER_INPUT_PHONE @"8882434664"
#define USER_INPUT_PROD_INFO @"product_name"
#define USER_INPUT_FIRST_NAME @"piyush"


//Notification observers for payment callback
#define kNotificationTxnCompleted @"kNotificationTxnCompleted"
#define kNotificationSuccessTxn @"kNotificationSuccessTxn"
#define kNotificationFailureTxn @"kNotificationFailureTxn"
#define kNotificationRejectTxn @"kNotificationRejectTxn"





@interface PayuMoneySDKAppConstant : NSObject

+(PayuMoneySDKAppConstant *)sharedInstance;
@property(strong,nonatomic) NSString *accessToken;
@property PayuMoneySDKKeychainItemWrapper *keyChain;
@property (nonatomic, strong) PayuMoneySDKReachability *serverReachability;
@property (nonatomic) BOOL isServerReachable;
@property(nonatomic,strong)NSMutableDictionary *dictCurrentTxn;
-(void)cancelTransactionManuallyWithRequestBody:(NSString *)request;
-(void)noInternetConnectionAvailable;
+(BOOL) validateEmail: (NSString *) strEmail;
//To validate URL type
+(BOOL) validateURL: (NSString *) urlString;
//Check the object is null type or not.
+(BOOL)checkForEmptyOrNull:(id) object;
+(void)showLoader_OnView:(UIView *)vwLoader;
+(void)hideLoader;
+ (NSString *) appVersionNew;
+(void)showNetworkError;

+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
+(void)setSDKButtonEnabled:(UIButton*)btnSelected;
+(void)setSDKButtonDisbaled:(UIButton*)btnSelected;
-(NSString*) appUniqueID;

@end
