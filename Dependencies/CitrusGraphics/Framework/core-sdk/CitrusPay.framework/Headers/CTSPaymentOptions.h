//
//  CTSPaymentOptions.h
//  CitrusPay
//
//  Created by Mukesh Patil on 1/28/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "CTSError.h"
#import "CTSConsumerProfileDetails.h"
#import "CTSPaymentDetailUpdate.h"

/**
 *   CTSPaymentOptions Class.
 */
@interface CTSPaymentOptions : JSONModel
/**
 *   The CTSPaymentOptions class' paymentMode object.
 */
@property (strong) NSString <Optional> * paymentMode;
/**
 *   The CTSPaymentOptions class' name object.
 */
@property (strong) NSString <Optional> * name;
/**
 *   The CTSPaymentOptions class' cardNumber object.
 */
@property (strong) NSString <Optional> * cardNumber;
/**
 *   The CTSPaymentOptions class' cardExpiryDate object.
 */
@property (strong) NSString <Optional> * cardExpiryDate;
/**
 *   The CTSPaymentOptions class' cardScheme object.
 */
@property (strong) NSString <Optional> * cardScheme;
/**
 *   The CTSPaymentOptions class' amount object.
 */
@property (strong) NSString <Optional> * amount;
/**
 *   The CTSPaymentOptions class' currency object.
 */
@property (strong) NSString <Optional> * currency;
/**
 *   The CTSPaymentOptions class' cvv object.
 */
@property (strong) NSString <Optional> * cvv;
/**
 *   The CTSPaymentOptions class' bank object.
 */
@property (strong) NSString <Optional> * bank;
/**
 *   The CTSPaymentOptions class' issuerCode object.
 */
@property (strong) NSString <Optional> * issuerCode;
/**
 *   The CTSPaymentOptions class' campaignCode object.
 */
@property (strong) NSString <Optional> * campaignCode;
/**
 *   The CTSPaymentOptions class' savedCardToken object.
 */
@property (strong) NSString <Optional> * savedCardToken;
/**
 *   The CTSPaymentOptions class' maxBalance object.
 */
@property (strong) NSString <Optional> * maxBalance;

/**
 *   creditCardOption.
 *
 *  @param cardNumber     The CardNumber NSString.
 *  @param cardExpiryDate The CardExpiryDate NSString.
 *  @param cvv            The CVV NSString.
 *
 *  @return The CTSPaymentOptions Object.
 */
+ (CTSPaymentOptions *)creditCardOption:(NSString *)cardNumber
                         cardExpiryDate:(NSString *)cardExpiryDate
                                    cvv:(NSString *)cvv;

/**
 *   debitCardOption.
 *
 *  @param cardNumber     The CardNumber NSString.
 *  @param cardExpiryDate The CardExpiryDate NSString.
 *  @param cvv            The CVV NSString.
 *
 *  @return The CTSPaymentOptions Object.
 */
+ (CTSPaymentOptions *)debitCardOption:(NSString *)cardNumber
                        cardExpiryDate:(NSString *)cardExpiryDate
                                   cvv:(NSString *)cvv;

/**
 *   netBankingOption.
 *
 *  @param bank       The Bank NSString.
 *  @param issuerCode The IssuerCode NSString.
 *
 *  @return The CTSPaymentOptions Object.
 */
+ (CTSPaymentOptions *)netBankingOption:(NSString *)bank
                             issuerCode:(NSString *)issuerCode;

/**
 *   creditCardTokenized.
 *
 *  @param paymentDetails The PaymentDetails CTSConsumerProfileDetails.
 *
 *  @return The CTSPaymentOptions Object.
 */
+ (CTSPaymentOptions *)creditCardTokenized:(CTSConsumerProfileDetails *)paymentDetails;

/**
 *   debitCardTokenized.
 *
 *  @param paymentDetails The PaymentDetails CTSConsumerProfileDetails.
 *
 *  @return The CTSPaymentOptions Object.
 */
+ (CTSPaymentOptions *)debitCardTokenized:(CTSConsumerProfileDetails *)paymentDetails;

/**
 *   netBankingTokenized.
 *
 *  @param paymentDetails The PaymentDetails CTSConsumerProfileDetails.
 *
 *  @return The CTSPaymentOptions Object.
 */
+ (CTSPaymentOptions *)netBankingTokenized:(CTSConsumerProfileDetails *)paymentDetails;

/**
 *   prepaidOption.
 *
 *  @return The CTSPaymentOptions Object.
 */
+ (CTSPaymentOptions *)prepaidOption;
/**
 *   MVCOption
 *
 *  @param campaignCode MVCOption.
 *
 *  @return The CTSPaymentOptions Object.
 */
+ (CTSPaymentOptions *)MVCOption:(NSString *)campaignCode;

/**
 *   setTransactionAmount.
 *
 *  @param amount The Amount NSString.
 */
- (void)setTransactionAmount:(NSString *)amount;

/**
 *   validatePaymentInfo.
 *
 *  @return The CTSErrorCode Object.
 */
- (CTSErrorCode)validatePaymentInfo;

/**
 *   isTokenized.
 *
 *  @return The BOOL Object.
 */
- (BOOL)isTokenized;

/**
 *   toCTSPaymentDetailUpdate.
 *
 *  @return The CTSPaymentDetailUpdate Object.
 */
- (CTSPaymentDetailUpdate *)toCTSPaymentDetailUpdate;

/**
 *   canDoOneTapPayment.
 *
 *  @return The BOOL Object.
 */
- (BOOL)canDoOneTapPayment;
@end
