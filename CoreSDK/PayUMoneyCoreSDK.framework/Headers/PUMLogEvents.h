//
//  PUMLogEvents.h
//  PayUMoneyCoreSDK
//
//  Created by Umang Arya on 10/31/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const KPUMACardValue = @"Cards";
static NSString *const KPUMANetBankValue = @"Bank";
static NSString *const KPUMAWalletValue = @"PUMWallet";
static NSString *const KPUMAWalletCardValue = @"PUMWallet|Cards";
static NSString *const KPUMAWalletNetBankValue = @"PUMWallet|Bank";

static NSString *const kPUMAScreenTypeCheckout = @"Checkout";
static NSString *const kPUMAScreenTypeAddCard = @"AddCard";
static NSString *const kPUMAScreenTypeCVVEntry = @"CVVEntry";
static NSString *const kPUMAScreenTypeMoreNetBank = @"MoreNetBank";
static NSString *const kPUMAScreenTypeLogin = @"Login";
static NSString *const kPUMAScreenTypeVerifyOTP = @"VerifyOTP";
static NSString *const kPUMAScreenTypeWebView = @"WebView";
static NSString *const kPUMAScreenTypeTxnSucceeded = @"TxnSucceeded";
static NSString *const kPUMAScreenTypeTxnFailed = @"TxnFailed";

@interface PUMLogEvents : NSObject

+(void)sdkInit;

+(void)paymentAdded;

+(void)paymentSucceededForAmount:(NSString *) amount;

+(void)paymentFailedWithReason:(NSString *) reason andAmount:(NSString *) amount;

+(void)loginInitiatedWithUserName:(NSString *) username;

//+(void)loginIDEnteredWithIDValue:(NSString *)idValue;
//
//+(void)loginAuthEnteredWithIDType:(NSString *)idType;

+(void)loginOTPTriggeredWithOTPTriggered:(BOOL)otpTriggered withUserName:(NSString *) username;

+(void)loginOTPResentWithUserName:(NSString *)username;

+(void)hidePaymentDetailsClickedWithPage:(NSString *)page;

+(void)showPaymentDetailsClickedWithPage:(NSString *)page;

+(void)hideWalletDetailsClickedWithPage:(NSString *)page;

+(void)showWalletDetailsClickedWithPage:(NSString *)page;

+(void)backButtonClickedWithPage:(NSString *)page;

+(void)payNowButtonClickedWithPage:(NSString *)page;

//+(void)errorOccurredWithCode:(NSInteger)errorCode errorArea:(NSString *)errorArea;

+(void)paymentOptionSelectedWithPaymentMethod:(NSString *)paymentMethod;

+(void)savedCardDisplayedWithNoOfCards:(NSString *)noOfCards;

+(void)addCardButtonClicked;

//+(void)dc_ccCardNumberAdded;
//
//+(void)dc_ccCardExpAdded;
//
//+(void)dc_ccCardCVVAdded;

+(void)savedCardScrolled;

//+(void)payNowWithEMIClicked:(NSString *)finalPaymentOption savedCardUsed:(BOOL)savedCardUsed andBankName:(NSString *)bankName;

+(void)savedCardCVVEntered;

+(void)moreNBBanksClicked;

//+(void)moreEMIBanksClicked;

//+(void)twoFALoaded;

+(void)paymentAbandonedWithReason:(NSString *)reason;

+(void)nbUnreachableWithBankName:(NSString *)bankName;

@end
