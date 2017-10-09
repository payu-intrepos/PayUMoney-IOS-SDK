//
//  PnPUtility.h
//  PlugNPlay
//
//  Created by Yadnesh Wankhede on 10/5/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlugAndPlayPayment.h"
#import <CitrusPay/CTSUser.h>
#import <CitrusPay/CTSPaymentReceipt.h>





@interface PnPUtility : NSObject
+(PlugAndPlayPayment *)paymentProperties;
+(NSString *)paymentAmount;
+(UIViewController *)merchantReturnVC;
+(id)completionHandler;
+(CTSUser*)pnpUser;
+(BOOL)isCompletionScreenDisabled;
+(NSString*)merchantDisplayName;
+(CTSPaymentReceipt *)paymentReceipt;
+(NSError *)paymentError;
+(void)cachePaymentReceipt:(CTSPaymentReceipt *)paymentReceipt;
+(void)cachePaymentError:(NSError *)error;
+(void)callCompletionWithPaymentResponse;
+(void)pushSuccessController:(NSString *)payAmount viewController:(UIViewController *)vc;
+(void)handlePaymentResponse:(CTSPaymentReceipt *) paymentReceipt error: (NSError *)error viewC:(UIViewController *)viewController isLoad:(BOOL)isLoad;
+(UIColor *)topBarColor;
+(UIColor *)topTitleTextColor;
+(UIColor *)buttonColor;
+(UIColor *)buttonTextColor;
+(NSString *)fetchBankNameByIFSCCode:(NSString *)bankIFSCCode;
+(NSString *)fetchInitialFourAlphabetsFromIFSCCode:(NSString *)bankIFSCCode;
+(BOOL)shouldReloadWallet;
+(void)setReloadWalletFlag;
+(void)resetReloadWalletFlag;
+(BOOL)shouldReloadAutoLoadSubscription;
+(void)setReloadAutoLoadFlag;
+(void)resetReloadAutoLoadFlag;
+(BOOL)shouldReloadWithdrawMoney;
+(void)setReloadWithdrawMoneyFlag;
+(void)resetReloadWithdrawMoneyFlag;
+(BOOL)isWalletDisabled;
+(BOOL)isCardDisabled;
+(BOOL)isNetbankDisabled;

+(void)resetAutoLoadSubscription;
+(void)setAutoLoadSubscrition;
+(BOOL)isAutoLoadSubscribed;
+(void)setLoadMoneyReturnUrl:(NSString *)url;
+(NSString *)loadMoneyReturnUrl;

+(void)handleFailureWithViewC:(UIViewController *)controller message:(NSString *)message title:(NSString*)title;
@end
