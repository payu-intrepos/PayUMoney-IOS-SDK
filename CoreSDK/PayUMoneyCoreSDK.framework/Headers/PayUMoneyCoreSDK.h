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
#import "UIImageView+CitrusGraphics.h"


#define SDK_Default_COLOR UIColorFromRGB([PUMUIConfig intFromHexString:defaultLinkTextColor])
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define ATTRIBUTE_ALLOC __attribute__((unavailable("alloc not available, call initWithTxnParam: error: instead")))
#define ATTRIBUTE_INTI __attribute__((unavailable("init not available, call initWithTxnParam: error: instead")))
#define ATTRIBUTE_NEW __attribute__((unavailable("new not available, call initWithTxnParam: error: instead")))
#define ATTRIBUTE_COPY __attribute__((unavailable("copy not available, call initWithTxnParam: error: instead")))

typedef void (^PUMRawJSONCompletionBlock)(NSDictionary *response ,NSError *error, id extraParam);
typedef void (^PUMPaymentCompletionBlock)(NSDictionary *response ,NSError *error ,NSError *validationError, id extraParam);
/**
 This completion blocks takes actionOccurred as a param and returns the title of the RightBarButton in Payment's WebView
 */
typedef NSString* (^PUMRightActionCompletionBlock)(BOOL actionOccurred);

@interface PayUMoneyCoreSDK : NSObject


@property (nonatomic, readonly) PUMTxnParam *txnParam;


+ (instancetype)alloc ATTRIBUTE_ALLOC;
- (instancetype)init  ATTRIBUTE_INTI;
+ (instancetype)init  ATTRIBUTE_INTI;
+ (instancetype)new   ATTRIBUTE_NEW;
+ (instancetype)copy  ATTRIBUTE_INTI;


+ (PayUMoneyCoreSDK *)initWithTxnParam:(PUMTxnParam *)txnParam error:(NSError **)error;

+ (PayUMoneyCoreSDK *)sharedInstance;

@property (copy,nonatomic) PUMRightActionCompletionBlock rightActionBlock;

/**
 *   isUserSignedIn.
 *
 *  @return The User SignedIn YES/NO.
 */
+ (BOOL)isUserSignedIn;

/**
 *   Tells if guest user is signed up automatically or not.
 */
+ (BOOL)guestSignUpEnabled;

/**
 *   signOut.
 *
 *  @return The User signOut YES/NO.
 */
+ (BOOL)signOut;

/// Set this property to show order details. This should only contain NSDictionary objects with only one key value pair.
-(NSError *)setOrderDetails:(NSArray*)orderDetails;

/// Returns details of order containing NSDictionary
-(NSArray*)orderDetails;

- (void)showLoginVCOnViewController:(UIViewController *)viewController
                withCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

- (void)showWebViewWithPaymentParam:(PUMPaymentParam *)paymentParam
                   onViewController:(UIViewController *)viewController
                withCompletionBlock:(PUMPaymentCompletionBlock)completionBlock;


//APIs
- (void)addPaymentAPIWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;

/// This method is used for getting updated emi tenures (including convenience fee) from bank code
- (void)getEMIOptionsForBank:(NSString *)bankCode completion:(PUMRawJSONCompletionBlock)completionBlock;


/// This method is used for getting updated emi tenures on the basis of amount provided. Amount should contain convenience fee as well
- (void)getEMIOptionsForAmount:(NSString *)amount completion:(PUMRawJSONCompletionBlock)completionBlock;

/// Checks if UPI option is available or not.
- (BOOL)isUPIOptionAvailable;

/** Checks if VPA is valid or not. VPA should be in a format example@@example
 @param vpa The VPA whose validation needs to be performed
 */
- (void)validateVPA:(NSString *)vpa completion:(void(^)(BOOL isValidVPA, NSError *error))completionBlock;

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
 Returns Valid EMI Options. It takes minimum value for EMI into consideration.
 
 @param emiArray The array from which valid EMI option is to be fetched
 @return Valid EMI Options
 */
- (NSMutableArray *)validEmiOptions:(NSMutableArray *)emiArray;

/**
 This API is used to mark txn as user cancelled, when user decides to cancel the transaction

 @param completionBlock PUMRawJSONCompletionBlock
 */
- (void)markTxnCancelWithCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock;
//

+ (BOOL)destroy;

@end
