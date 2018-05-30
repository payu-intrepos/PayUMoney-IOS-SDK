//
//  PUMUtils.h
//  PayUmoneyiOS_SDK
//
//  Created by Kuldeep Saini on 10/14/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUMInternalConstants.h"
#import "PUMPaymentParam.h"

//// In a header file
typedef enum {
    KMB,
    ADBB,
    AXIB,
    BHNB,
    BOIB,
    BOMB,
    CABB,
    CBIB,
    CITNB,
    CPNB,
    CRPB,
    CSBN,
    CSMSNB,
    CUBB,
    DCBB,
    DCBCORP,
    DENN,
    DLSB,
    DSHB,
    FEDB,
    HDFB,
    ICIB,
    IDBB,
    IDFCNB,
    INDB,
    INIB,
    INOB,
    JAKB,
    JSBNB,
    KRKB,
    KRVB,
    KRVBC,
    LVCB,
    LVRB,
    OBCB,
    PMNB,
    PNBB,
    PSBNB,
    SBBJB,
    SBHB,
    SBIB,
    SBMB,
    SBPB,
    SBTB,
    SOIB,
    SRSWT,
    SVCNB,
    SYNDB,
    TBON,
    TMBB,
    UBIB,
    UBIBC,
    UCOB,
    UNIB,
    VJYB,
    YESB,
    NONE
} kBankCodeType;

// In a header file
//typedef enum {
//CID001, CID002, CID003, CID004, CID005, CID006, CID007, CID008, CID009, CID010, CID011, CID012, CID013, CID014, CID015, CID016, CID017, CID018, CID019, CID021, CID022, CID023, CID024, CID025, CID026, CID027, CID028, CID029, CID030, CID031, CID032, CID033, CID034, CID035, CID036, CID037, CID038, CID039, CID040, CID041, CID042, CID043, CID051, CID052, CID053, CID056, CID057, CID058, CID061, CID062, CID063, CID064, CID065, CID066, CID069, CID070, CID090, CID00 } kCIDType;

@interface PUMUtils : NSObject

+(NSString *)bankCodeStringToCID:(NSString*)strVal;

+(NSString*)correctExpiryDate:(NSString *)date;
+ (NSData *)createSHA512:(NSString *)key txnid:(NSString *)txnid amount:(NSString *)amount productinfo:(NSString *)productinfo firstname:(NSString *)firstname email:(NSString *)email salt:(NSString *)salt;
+ (NSData *) createSHA512:(NSString *)source;
+ (NSString *)getRandomString:(NSInteger)length;
+ (NSDictionary *)dictionaryWithPropertiesOfObject:(id)obj;

/*!
 * This method is called to Check Null Values and return valid string data.
 */
+(NSString*)checkNullValue:(id)text;


/*!
 * This method is called to get Random String of provided length.
 */
+(NSString *)getRandomStringOfLength:(NSInteger)length;


/*!
 * This method is called to Encrypt Card Numbers.(SHA-256 Encryption with Little Indian Encoding)
 */

+(NSString*) encryptCardNumberForEdgeRewards:(NSString*) cardNumber;
+ (NSData *) createSHA256:(NSData *)source;


/*!
 * This method is to calculate convfees based on Payment Mode (CC,DC,NB,WALLET)
 and ModeType(DEFAULT,AXIB)
 */

+(double)calculateConvFeesForPaymentMode:(NSString*)paymentMode
                             andModeType:(NSString*)modeType
                        isWalletSelected:(BOOL)isWalletSelected;

+ (double)calculateConvFeesForPayment:(PUMPaymentParam *)paymentParam;

/*!
 * Get base URL to be used with the APIs or WebView for currently active environment
 */

+ (NSString*)getBaseURLFor:(PUMBaseURLCategory)urlCategory;

/*!
 * Get Card Image Name based on type("MAST","VISA" etc)
 */
+(NSString *)mapCardSchmeTypeWithCG:(NSString *)cardType;


/*!
 * This method is called to check string is a numeric only string.
 */
+(BOOL)checkStringIsNumericOnly:(NSString *)testString;

+(NSString *)removeWhiteSpacesFromString:(NSString *)string;

+(NSString *)convertBoolToString:(BOOL) val;

+(void)setPnPVersion:(NSString *) version;

+(NSString *)getPnPVersion;

+(NSDecimalNumber *)roundUpNumberTo2DecimalPlaces:(NSDecimalNumber *) number;

+(NSString *)stringUpto2Decimal:(NSString *)str;

+(NSDecimalNumber *)decimalNumberFromFloat:(float)value;

+(NSString *)getTotalAmountFromPaymentResponse:(NSDictionary *) response;

+(NSString *)getPaymentIDFromAddPaymentResponse:(NSDictionary *) response;

+(NSString *)getAuthTypeFromAuth:(NSString *) otpOrPassword;

+(BOOL)isNumber:(NSString *) str;

+(id)objectFromString:(NSString *)str error:(NSError **)err;

@end
