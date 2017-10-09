//
//  CTSConsumerProfileDetails.h
//  CitrusPay
//
//  Created by Mukesh Patil on 1/27/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 *   CTSConsumerProfileDetails Class.
 */
@interface CTSConsumerProfileDetails : JSONModel
/**
 *   The CTSConsumerProfileDetails class' paymentMode object.
 */
@property (strong) NSString <Optional> * paymentMode;
/**
 *   The CTSConsumerProfileDetails class' name object.
 */
@property (strong) NSString <Optional> * name;
/**
 *   The CTSConsumerProfileDetails class' savedCardToken object.
 */
@property (strong) NSString <Optional> * savedCardToken;
/**
 *   The CTSConsumerProfileDetails class' cardNumber object.
 */
@property (strong) NSString <Optional> * cardNumber;
/**
 *   The CTSConsumerProfileDetails class' cardExpiryDate object.
 */
@property (strong) NSString <Optional> * cardExpiryDate;
/**
 *   The CTSConsumerProfileDetails class' bank object.
 */
@property (strong) NSString <Optional> * bank;
/**
 *   The CTSConsumerProfileDetails class' cardScheme object.
 */
@property (strong) NSString <Optional> * cardScheme;
/**
 *   The CTSConsumerProfileDetails class' issuerCode object.
 */
@property (strong) NSString <Optional> * issuerCode;
/**
 *   The CTSConsumerProfileDetails class' amount object.
 */
@property (strong) NSString <Optional> * amount;
/**
 *   The CTSConsumerProfileDetails class' currency object.
 */
@property (strong) NSString <Optional> * currency;
/**
 *   The CTSConsumerProfileDetails class' maxBalance object.
 */
@property (strong) NSString <Optional> * maxBalance;
/**
 *   The CTSConsumerProfileDetails class' campaignCode object.
 */
@property (strong) NSString <Optional> * campaignCode;
/**
 *   The CTSConsumerProfileDetails class' cvv object.
 */
@property (strong) NSString <Optional> * cvv;
/**
 *   The CTSConsumerProfileDetails class' fingerPrint object.
 */
@property (strong) NSString <Optional> * fingerPrint;
/**
 *   The CTSConsumerProfileDetails class' selected object.
 */
@property (assign) BOOL selected;
/**
 *   The CTSConsumerProfileDetails class' shown object.
 */
@property (assign) BOOL shown;
/**
 *   The CTSConsumerProfileDetails class' defaultPaymentMode object.
 */
@property (assign) BOOL defaultPaymentMode;
/**
 *   canDoOneTapPayment.
 *
 *  @return The BOOL Object.
 */
- (BOOL)canDoOneTapPayment;
@end
