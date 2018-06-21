//
//  PlugNPlay.h
//  PlugNPlay
//
//  Created by Mukesh Patil on 1/13/17.
//  Copyright © 2017 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>
#import "PnPUtility.h"
#import "UIUtility.h"

typedef void (^WalletValidationErrorCompletionHandler)(NSError *error);
typedef void (^PnPPaymentCompletionBlock)(NSDictionary *paymentResponse, NSError *error, id extraParam);
typedef void (^PaymentCompletionHandler)(NSDictionary *paymentResponse, NSError *error);


@interface PlugNPlay : NSObject

//When Sent YES, it disables the payment Completion Screen, app gets back to merchant app immideatly after the payment
+(void)setDisableCompletionScreen:(BOOL)isDisabled;

//When Sent YES, it disables the exit alert on checkout page, app gets back to merchant app immideatly after the back press
+(void)setExitAlertOnCheckoutPageDisabled:(BOOL)isDisabled;

//When Sent YES, it disables the exit alert on bank page, app gets back to merchant app immideatly after the back press
+(void)setExitAlertOnBankPageDisabled:(BOOL)isDisabled;

//sets the top bar color of the Plug and  Play SDK UI
+(void)setTopBarColor:(UIColor *)color;

//sets the top bar title text color of the Plug and  Play SDK UI
+(void)setTopTitleTextColor:(UIColor *)color;

//sets the bottom button color of the Plug and  Play SDK UI
+(void)setButtonColor:(UIColor *)color;

//sets the bottom button text color of the Plug and  Play SDK UI
+(void)setButtonTextColor:(UIColor *)color;


//sets the Merchant display name of the Plug and  Play SDK UI
+(void)setMerchantDisplayName:(NSString *)merchantDisplayName;

//sets the view returning view controller
+(void)setReturningViewController:(UIViewController*)vc;

//sets the indicator tint color on PnP UI
+(void)setIndicatorTintColor:(UIColor*)color;

/// Set this property to show order details. This should only contain NSDictionary objects with only one key value pair.
+(NSError *)setOrderDetails:(NSArray*)orderDetails;

/// Returns details of order containing NSDictionary
+(NSArray*)orderDetails;

//set payment paramters
//+(void)setPaymentParams:(PUMRequestParams*)paymentParams;

//Getters
+(BOOL)disableCompletionScreen;
+(BOOL)isExitAlertOnCheckoutPageDisabled;
+(BOOL)isExitAlertOnBankPageDisabled;

+(UIColor*)topBarColor;
+(UIColor*)topTitleTextColor;
+(UIColor*)buttonColor;
+(UIColor*)buttonTextColor;

+(NSString*)merchantDisplayName;
+(UIViewController*)returningViewController;
+(UIColor*)indicatorTintColor;

//+(PUMRequestParams*)getPaymentParams;


+(void)presentPaymentViewControllerWithTxnParams:(PUMTxnParam*)txnParam
                                onViewController:(UIViewController*)viewController
                             withCompletionBlock:(PnPPaymentCompletionBlock)completionBlock;


@end
