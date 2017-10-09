//
//  PlugNPlay.h
//  PlugNPlay
//
//  Created by Mukesh Patil on 1/13/17.
//  Copyright © 2017 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <CitrusPay/CitrusPay.h>

#import "Version.h"
#import "PlugAndPlayPayment.h"
#import "PnPToolbar.h"
#import "PnPWithdrawMoneyVerifyViewController.h"
#import "PnPUtility.h"
#import "LeftRightStrip.h"
#import "PnPSetupAutoLoadView.h"
#import "PnPWalletManagementConstants.h"
#import "PnPCvvInputViewController.h"
#import "PnPWalletPayViewController.h"
#import "PnPAddCardViewController.h"
#import "PnPWalletManagementViewController.h"
#import "PnPCardManagementTableViewCell.h"

typedef void (^WalletValidationErrorCompletionHandler)(NSError *error);

@interface PlugNPlay : NSObject {
    UIViewController *merchantReturnViewController;
    NSString *payAmount;
}

//Launches the Plug and Play UI for Payments

+(void)presentPaymentsViewController:(PlugAndPlayPayment *)payment
                             forUser:(CTSUser *)user
                      viewController:(UIViewController *)viewController
                          completion:(CTSSimpliPayCompletionHandler)completion;

//Launches the Plug and Play
+(void)presentWalletViewController:(CTSUser *)user
                         returnURL:(NSString*)loadMoneyReturnURL
                      customParams:(NSDictionary <Optional> *)customParams
                    viewController:(UIViewController *)viewController
                        completion:(WalletValidationErrorCompletionHandler)completion;

//When Sent YES, it disables the Wallet payment UI in the Plug and Play Payment UI
+(void)disableWallet:(BOOL)isDisabled;

//When Sent YES, it disables the Cards payment UI in the Plug and Play Payment UI
+(void)disableCards:(BOOL)isDisabled;

//When Sent YES, it disables the Netbanking payment UI in the Plug and Play Payment UI
+(void)disableNetbanking:(BOOL)isDisabled;

//When Sent YES, it disables the payment Completion Screen, app gets back to merchant app immideatly after the payment
+(void)disableCompletionScreen:(BOOL)isDisabled;

//sets the top bar color of the Plug and  Play SDK UI
+(void) setTopBarColor:(UIColor *)color;

//sets the top bar title text color of the Plug and  Play SDK UI
+(void) setTopTitleTextColor:(UIColor *)color;

//sets the bottom button color of the Plug and  Play SDK UI
+(void) setButtonColor:(UIColor *)color;

//sets the bottom button text color of the Plug and  Play SDK UI
+(void) setButtonTextColor:(UIColor *)color;


//sets the Merchant display name of the Plug and  Play SDK UI
+(void) setMerchantDisplayName:(NSString *)merchantDisplayName;

@end
