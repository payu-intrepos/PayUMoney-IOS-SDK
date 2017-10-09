//
//  LazyPay.h
//  CitrusPay
//
//  Created by Mukesh Patil on 6/1/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CitrusPay/CitrusPay.h>
#import "LazyPayConfig.h"
#import "LPChekEligibility.h"
#import "LPPaymentReceipt.h"
#import "Version.h"

/**
 *  The LazyPay class' CompletionHandler CallBack.
 *
 *  The Newly created JSON, error object.
 */
typedef void (^CompletionHandler)(id JSON,
                                  NSError * error);
/**
 *   LazyPay Class.
 */
@interface LazyPay : NSObject

/**
*  isUserSignedIn  - Check User Logged In or Not.
*
*  @return The BOOL Value.
*/
+ (BOOL)isUserSignedIn;

/**
 *  signOut  Cleared the Saved Local Tokens
 *
 *  @return The BOOL Value.
 */
+ (BOOL)signOut;

/**
 *  canMakePayment  Check Users LazyPay Elibijiblity
 *
 *  @param lazyPayConfig  The lazyPayConfig into amount, billUrl, productSkuDetails, userDetails & userAddress.
 *  @param completion  The Created Request into CTSLPChekEligibility & NSError
 */
+ (void)canMakePayment:(LazyPayConfig *)lazyPayConfig
     completionHandler:(CompletionHandler)completion;

/**
 *  initiatePayment  - Lets Initiate Payment for LazyPay
 *
 *  @param lazyPayConfig  The lazyPayConfig into amount, billUrl, productSkuDetails, userDetails & userAddress.
 *  @param controller  The self controller object.
 *  @param completion  The Created Request into CTSLPPaymentReceipt & NSError
 */
+ (void)initiatePayment:(LazyPayConfig *)lazyPayConfig
andParentViewController:(id)controller
      completionHandler:(CompletionHandler)completion;

@end
