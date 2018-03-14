//
//  PayUMoneyCoreSDK.h
//  PayUmoney_SDK
//
//  Created by Umang Arya on 5/2/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PUMPaymentParam.h"
#import "PUMTxnParam.h"
#import "PUMSDKError.h"
#import "PUMUserPaymentDataBO.h"
#import "PUMActivityView.h"
#import "PUMUIConfig.h"
#import "PUMUtils.h"
#import "PUMHelperClass.h"
#import "PUMTextField.h"
#import "PUMLogEvents.h"


#define SDK_Default_COLOR UIColorFromRGB([PUMUIConfig intFromHexString:defaultLinkTextColor])
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define ATTRIBUTE_ALLOC __attribute__((unavailable("alloc not available, call initWithTxnParam: error: instead")))
#define ATTRIBUTE_INTI __attribute__((unavailable("init not available, call initWithTxnParam: error: instead")))
#define ATTRIBUTE_NEW __attribute__((unavailable("new not available, call initWithTxnParam: error: instead")))
#define ATTRIBUTE_COPY __attribute__((unavailable("copy not available, call initWithTxnParam: error: instead")))

typedef void (^PUMRawJSONCompletionBlock)(NSDictionary *response ,NSError *error, id extraParam);
typedef void (^PUMPaymentCompletionBlock)(NSDictionary *response ,NSError *error ,NSError *validationError, id extraParam);
@interface PayUMoneyCoreSDK : NSObject


@property (nonatomic, readonly) PUMTxnParam *txnParam;


+ (instancetype)alloc ATTRIBUTE_ALLOC;
- (instancetype)init  ATTRIBUTE_INTI;
+ (instancetype)init  ATTRIBUTE_INTI;
+ (instancetype)new   ATTRIBUTE_NEW;
+ (instancetype)copy  ATTRIBUTE_INTI;


+ (PayUMoneyCoreSDK *)initWithTxnParam:(PUMTxnParam *)txnParam error:(NSError **)error;

+ (PayUMoneyCoreSDK *)sharedInstance;


/**
 *   isUserSignedIn.
 *
 *  @return The User SignedIn YES/NO.
 */
+ (BOOL)isUserSignedIn;
/**
 *   signOut.
 *
 *  @return The User signOut YES/NO.
 */
+ (BOOL)signOut;

- (void)showLoginVCOnViewController:(UIViewController *)viewController
                withCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)showWebViewWithPaymentParam:(PUMPaymentParam *)paymentParam
                   onViewController:(UIViewController *)viewController
                withCompletionBlock:(PUMPaymentCompletionBlock)completionBlock;


//APIs
- (void)addPaymentAPIWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)fetchPaymentUserDataAPIWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)getBinDetailsAPI:(NSString *)cardBin
     withCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)getNetBankingStatusAPIWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)fetchUserDataAPIWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)sendPaymentOTPforMobileOrEmail:(NSString *) mobileOrEmail APIWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)verifyOTPOrPassword:(NSString *) otpOrPassword forMobileOrEmail:(NSString *) mobileOrEmail APIWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)getMultipleBinDetailsAPI:(NSArray *)arrCardBin
             withCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

/**
 This API is used to mark txn as user cancelled, when user decides to cancel the transaction

 @param completionBlock PUMRawJSONCompletionBlock
 */
- (void)markTxnCancelWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;
//

+ (BOOL)destroy;

@end
