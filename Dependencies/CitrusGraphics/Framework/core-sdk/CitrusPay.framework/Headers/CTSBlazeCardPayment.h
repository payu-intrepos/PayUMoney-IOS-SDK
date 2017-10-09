//
//  CTSBlazeCardPayment.h
//  CitrusPay
//
//  Created by Mukesh Patil on 2/23/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "CTSError.h"

/**
 *   CTSBlazeCardPayment Class.
 */
@interface CTSBlazeCardPayment : JSONModel
/**
 *   The CTSBlazeCardPayment class' cardType object.
 */
@property (strong) NSString <Optional> * cardType;
/**
 *   The CTSBlazeCardPayment class' cardScheme object.
 */
@property (strong) NSString <Optional> * cardScheme;
/**
 *   The CTSBlazeCardPayment class' cardNo object.
 */
@property (strong) NSString <Optional> * cardNo;
/**
 *   The CTSBlazeCardPayment class' cvv object.
 */
@property (strong) NSString <Optional> * cvv;
/**
 *   The CTSBlazeCardPayment class' expiry object.
 */
@property (strong) NSString <Optional> * expiry;
/**
 *   The CTSBlazeCardPayment class' savedCardToken object.
 */
@property (strong) NSString <Optional> * savedCardToken;
/**
 *   The CTSBlazeCardPayment class' name object.
 */
@property (strong) NSString <Optional> * name;


/**
 *   initWithCreditCard
 *
 *  @return The CTSBlazeCardPayment Object.
 */
- (instancetype)initWithCreditCard;

/**
 *   initWithDebitCard
 *
 *  @return The CTSBlazeCardPayment Object.
 */
- (instancetype)initWithDebitCard;

/**
 *   isTokenizedCard
 *
 *  @return The BOOL Value.
 */
- (BOOL)isTokenizedCard;

/**
 *   validateTokenized
 *
 *  @return The CTSErrorCode Object.
 */
- (CTSErrorCode)validateTokenized;

/**
 *   validatePaymentInfo
 *
 *  @return The CTSErrorCode Object.
 */
- (CTSErrorCode)validatePaymentInfo;

/**
 *   doCardCorrectionsIfNeeded
 */
- (void)doCardCorrectionsIfNeeded;

@end
