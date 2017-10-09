//
//  CTSConsumerProfile.h
//  CitrusPay
//
//  Created by Mukesh Patil on 1/27/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "CTSConsumerProfileDetails.h"

@class CTSUserDetails;

/**
 *   CTSConsumerProfile Class.
 */
@interface CTSConsumerProfile : JSONModel
/**
 *   The CTSConsumerProfile class' merchantAccessKey object.
 */
@property (strong) NSString <Optional> * merchantAccessKey;
/**
 *   The CTSConsumerProfile class' username object.
 */
@property (strong) NSString <Optional> * username;
/**
 *   The CTSConsumerProfile class' amount object.
 */
@property (strong) NSString <Optional> * amount;
/**
 *   The CTSConsumerProfile class' currency object.
 */
@property (strong) NSString <Optional> * currency;
/**
 *   The CTSConsumerProfile class' statusMsg object.
 */
@property (strong) NSString <Optional> * statusMsg;
/**
 *   The CTSConsumerProfile class' userDetails object.
 */
@property (strong) CTSUserDetails * userDetails;
/**
 *   The CTSConsumerProfile class' paymentOptionsList object.
 */
@property( strong) NSMutableArray<CTSConsumerProfileDetails *>* paymentOptionsList;

/**
 *   getSavedNBPaymentOptions.
 *
 *  @return The NSArray Object.
 */
- (NSArray *)getSavedNBPaymentOptions;
/**
 *   getSavedCCPaymentOptions.
 *
 *  @return The NSArray Object.
 */
- (NSArray *)getSavedCCPaymentOptions;
/**
 *   getSavedDCPaymentOptions
 *
 *  @return The NSArray Object..
 */
- (NSArray *)getSavedDCPaymentOptions;

/**
 *   getMVCAmount.
 *
 *  @return The NSString Object.
 */
- (NSString *)getMVCAmount;
/**
 *   getMVCMaxBalance.
 *
 *  @return The NSString Object.
 */
- (NSString *)getMVCMaxBalance;
/**
 *   getCampaignCode.
 *
 *  @return The NSString Object.
 */
- (NSString *)getCampaignCode;
/**
 *   getCashAmount.
 *
 *  @return The NSString Object.
 */
- (NSString *)getCashAmount;
/**
 *   getCashMaxBalance.
 *
 *  @return The NSString Object.
 */
- (NSString *)getCashMaxBalance;
@end
