//
//  PUMConstants.h
//  PayUMoneyCoreSDK
//
//  Created by Umang Arya on 7/4/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#ifndef PUMConstants_h
#define PUMConstants_h

typedef NS_ENUM(NSInteger, PUMEnvironment) {
    PUMEnvironmentProduction = 0,
    PUMEnvironmentTest = 1
};

// Issuer Collections
#define     ISSUER_LASER                                        @"LASER"
#define     ISSUER_DISCOVER                                     @"DISCOVER"
#define     ISSUER_SMAE                                         @"SMAE"
#define     ISSUER_RUPAY                                        @"RUPAY"
#define     ISSUER_VISA                                         @"VISA"
#define     ISSUER_MAST                                         @"MAST"
#define     ISSUER_MAES                                         @"MAES"
#define     ISSUER_DINR                                         @"DINR"
#define     ISSUER_AMEX                                         @"AMEX"
#define     ISSUER_JCB                                          @"JCB"



#define     EMI_SMALL                                           @"emi"
#define     EMI                                                 @"EMI"
#define     UPI                                                 @"UPI"
#define     CASH_CARD_SMALL                                     @"cashcard"
#define     CASH_CARD_CAPITAL                                   @"CASHCARD"
#define     CASH                                                @"CASH"

#define     PAYMENT_MODE_CASH_CARD                                          @"cashcard"
#endif /* PUMConstants_h */
