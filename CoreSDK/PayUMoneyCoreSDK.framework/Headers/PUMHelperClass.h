//
//  PUMHelperClass.h
//  PayUMoneyCoreSDK
//
//  Created by Umang Arya on 7/3/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUMHelperClass : NSObject

+ (double)calculateConvFeesForPaymentMode:(NSString*)paymentMode
                             andModeType:(NSString*)modeType
                          isSplitPayment:(BOOL)splitPayment;

+ (BOOL)isCardNumberValid:(NSString *)cardNumber cardType:(NSString *)cardType;

+ (BOOL)validateLuhnCheckOnCardNumber:(NSString *) cardNumber;

+ (BOOL)isExpiryMonth:(NSString *)month andExpiryYearValid:(NSString *)year forCardType:(NSString *)cardType;

+ (BOOL)isCvvValid:(NSString *)cvv forCardType:(NSString *)cardType;

+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;

+ (BOOL)isValidAmount:(NSString *)amount;

+ (BOOL)isValidEmail:(NSString *)email;

+ (BOOL)validateRegex:(NSString *) regex onString:(NSString *) str;

+ (BOOL)isNitroFlowEnabledForMerchant;

+ (BOOL)isUserAccountActive;

+ (NSString *)getUserNameFromFetchUserDataAPI;

+ (BOOL)isUserMobileNumberRegistered;

+ (NSString *)getUserMobileNumberFromFetchUserDataAPI;

+ (NSString *)getUserEmailFromFetchUserDataAPI;

@end
