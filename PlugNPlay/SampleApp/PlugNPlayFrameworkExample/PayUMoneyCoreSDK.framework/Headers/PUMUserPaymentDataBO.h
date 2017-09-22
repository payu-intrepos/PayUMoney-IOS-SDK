//
//  PUMUserPaymentDataBO.h
//  PayUmoneyiOS_SDK
//
//  Created by Imran Khan on 7/25/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUMUserPaymentDataBO : NSObject
@property NSString *wallet_amount;
@property NSString *wallet_availableAmount;
@property NSString *wallet_maxLimit;
@property NSString *wallet_maxLoadLimit;
@property NSString *wallet_message;
@property NSString *wallet_minLimit;
@property NSString *wallet_minLoadLimit;
@property NSString *wallet_status;

@property NSString *userId;
@property NSString *valueType;
@property NSString *user_email;
@property NSString *user_otp;
@property NSString *phone;
@property NSString *total_pay_amount;
@property NSString *wallet_userId;
@property NSString *wallet_load_paymentid;
@property NSString *wallet_amount_use;
//txnDetails
@property NSString *txn_email;
@property NSString *txn_phone;

@end
