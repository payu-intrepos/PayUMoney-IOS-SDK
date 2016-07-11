//
//  ServiceParameters.h
//  PayU SDK
//
//  Created by Honey Lakhani on 10/13/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayuMoneySDKRequestParams.h"
@interface PayuMoneySDKServiceParameters : NSObject
+(NSString *)preparePostBodyForLogin : (NSString *)username withPassword : (NSString *)password;
+(NSString *)prepareBodyForCreatePayment;
+(NSString *)PrepareBodyForGetPaymentMerchant : (NSString *)paymentId : (NSDictionary *)params;
+(NSString *)preparebodyForSignUp : (NSString *)email withPhone : (NSString *)phone withPassword : (NSString *)password;
+(NSString *)prepareBodyForOTP : (NSString *)email;
+(NSString *)prepareBodyForForgotPassword : (NSString *)email;
+(NSString *)prepareBodyForCancelTransactionWithPaymentId : (NSString *)paymentId withStatus : (NSString *)cancelled;
+(NSString *)prepareBodyForPostPayment : (NSString *)paymentID;
+(NSString *)prepareBodyForOneClick : (NSString *)enable;
+(NSString *)prepareBodyForHash : (PayuMoneySDKRequestParams *)params;
+(NSString *)prepareBodyForCardHashWithHash : (NSString *)hash withPaymentId : (NSString *)pid withUserId : (NSString *)uid;
@end
