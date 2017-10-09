    //
    //  CTSUtility.h
    //  RestFulltester
    //
    //  Created by Yadnesh Wankhede on 17/06/14.
    //  Copyright (c) 2014 Citrus. All rights reserved.
    //

#import <Foundation/Foundation.h>
#import "CTSAuthLayerConstants.h"
#import "UserLogging.h"
#import "CTSBill.h"
#import "CTSContactUpdate.h"
#import "CTSUserAddress.h"
#import "CTSKeyStore.h"
#import "CTSProfileContactRes.h"
#import "CTSDyPPaymentInfo.h"
#import <UIKit/UIKit.h>
#import "CTSPaymentOption.h"
#import "CTSDataCache.h"
#import "CTSRuleInfo.h"
#import "CTSRestCoreResponse.h"
#import "CTSPgSettings.h"
#import "CTSLoginInfo.h"

#define SCHEME_MTRO @"MTRO"
#define SCHEME_VISA @"VISA"
#define SCHEME_AMEX @"AMEX"
#define SCHEME_RPAY @"RPAY"
#define SCHEME_DINERS @"DINERS"
#define SCHEME_MCRD @"MCRD"
#define SCHEME_JCB @"JCB"
#define SCHEME_DISCOVER @"DISCOVER"

#define UNKNOWN_CARD_TYPE @"UNKNOWN"


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


typedef enum{
    CardTypeCredit,
    CardTypeDebit,
    CardTypeDebitUnRecognized
    
} CardType;


    //on the mian thread
#define OnMainThread($block) ( [NSThread isMainThread] ? $block() : dispatch_async(dispatch_get_main_queue(), $block))



#define CTSLocalizedString(key, comment) \
[CTSUtility NSLocalizedString:(key)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define CITRUS_ORANGE_COLOR UIColorFromRGB(0XF79523)

extern NSString *const CTS_SIGNIN_USER_EMAIL ;

@interface CTSUtility : NSObject
typedef void (^ASBillCallback)(CTSBill* bill,NSError* error);

+ (UIColor*)getColorFromRGB:(unsigned int)rgbValue;


    //logger
+ (void)logProperties:(id)object ;



    //string utils
+(NSString *)removeWhiteSpacesFromString:(NSString *)string;
+(BOOL)stringContainsSpecialChars:(NSString *)toCheck exceptChars:(NSString*)exceptionChars exceptCharSet:(NSCharacterSet*)exceptionCharSet;
+(BOOL)islengthInvalid:(NSString*)string;
+(BOOL)isStringNonNumeric:(NSString *)string;
+(NSString *)toStringBool:(BOOL)paramBool;
+(BOOL)string:(NSString *)source containsString:(NSString*)desti;
+(NSString *)NSLocalizedString:(NSString *)string;
+(NSString *)removeNonNumericFromString:(NSString*)string;
+(BOOL)convertToBool:(NSString *)boolStr;
+(BOOL)toBool:(NSString*)boolString;
+(BOOL)isNonNumeric:(NSString *)string;
+(NSString *)toJson:(NSDictionary *)dict;
+(NSDictionary *)toDict:(NSString *)json;

    //app specific
+(BOOL)isSchemeAllowed:(NSString *)userScheme forOptions:(NSArray *)merchantOptions;
+(BOOL)isBankAllowed:(NSString *)userBank forOptions:(NSArray *)merchantOptions;
+(BOOL)isErrorJson:(NSString *)string;
+(void)storeLoginId:(NSString *)string;
+(NSString *)getLoginId;
+(void)removeLoginId;
+(BOOL)isVerifyPage:(NSString *)page withURL:(NSString *)url;
+(BOOL)isBadPasswordError:(NSError *)error;
+(NSArray*)uniqueSortedNetBanks:(NSArray*)merchantNetBanks;
+(NSDictionary*)getResponseIfTransactionIsFinished:(NSData*)postData;
+(NSDictionary*)getResponseIfTransactionIsComplete:(UIWebView *)webview ;
+(NSDictionary *)errorResponseTransactionFailed;
+(NSString *)fetchBankCodeForName:(NSString *)nameOfBank;
+(CTSRestCoreResponse*)addJsonErrorToResponse:(CTSRestCoreResponse*)response;
+(NSArray *)getLoadResponseIfSuccesfull:(NSURLRequest *)request;
+(int)extractReqId:(NSMutableDictionary *)response;
+(NSError *)extractError:(NSMutableDictionary *)response;
+(NSDictionary *)errorResponseIfReturnUrlDidntRespond:(NSString *)returnUrl webViewUrl:(NSString *)webviewUrl currentResponse:(NSDictionary *)responseDict;
+(NSDictionary *)errorResponseTransactionForcedClosedByUser;
+ (NSMutableArray *)fetchMappedCardSchemeForSaveCards:(NSArray*)cardsSchemeArray;
+ (NSString *)fetchBankNameByBankIssuerCode:(NSString *)bankIssuerCode;
+ (NSString*)createTXNId;
+(NSDictionary *)errorResponseDeviceOffline:(NSError *)error;
+(NSString *)grantTypeFor:(PasswordType)type;
+(NSString *)fetchCachedVanityUrl;
+(NSString*)fetchFromEnvironment:(NSString *)key;
+(NSString*)bankNameFromCID:(NSString *)cidCode pgSetting:(CTSPgSettings *)pgSetting;


    //Cache
+(CTSPgSettings *)getCachedPgSetting;
+(CTSPgSettings *)getCachedLoadMoneyPgSetting;


    //Oauth
+(NSDictionary*)readSigninTokenAsHeader;
+(NSDictionary*)readSignupTokenAsHeader;
+(NSDictionary*)readOauthTokenAsHeader:(NSString*)oauthToken;
+(NSString *)readAsBearer:(NSString *)oauthToken;



    //DP
+(void)requestDPBillForRule:(CTSRuleInfo *)ruleInfo billURL:(NSString *)billUrl callback:(ASBillCallback)callback;
+(void)requestBillAmount:(NSString *)amount billURL:(NSString *)billUrl callback:(ASBillCallback)callback;
+ (CTSBill*)getDPBillFromServer:(CTSRuleInfo *)ruleInfo txn:(NSString *)txnID billUrl:(NSString*)billUrl;


    //KeyStore
+(NSString *)fetchVanityUrl:(CTSKeyStore *)keyStore;
+(NSString *)fetchSigninId:(CTSKeyStore *)keyStore;
+(NSString *)fetchSigninSecret:(CTSKeyStore *)keyStore;
+(NSString *)fetchSignupId:(CTSKeyStore *)keyStore;
+(NSString *)fetchSigUpSecret:(CTSKeyStore *)keyStore;
+(CTSKeyStore *)keyStore;
+(CTSKeyStore *)fetchCachedKeyStore;

    //validators
+(BOOL)validateDecimalAmountString:(NSString *)amount;
+(BOOL)validateEmail:(NSString*)email;
+(BOOL)validateMobile:(NSString*)mobile;
+(BOOL)validateCardNumber:(NSString*)number;
+(BOOL)validateExpiryDate:(NSString*)date;
+(BOOL)validateCVV:(NSString*)cvv cardNumber:(NSString*)cardNumber;
+(BOOL)validateBill:(CTSBill *)bill;
+(BOOL)isVerifyPage:(NSString *)urlString;
+(BOOL)enterNumericOnly:(NSString*)string;
+(BOOL)enterCharecterOnly:(NSString*)string;
+(BOOL)isEmail:(NSString *)string;
+(BOOL)validateCVVNumber:(UITextField*)textField replacementString:(NSString*)string shouldChangeCharactersInRange:(NSRange)range;
+(BOOL)validateCVVNumber:(UITextField*)textField cardNumber:(NSString*)cardNumber replacementString:(NSString*)string shouldChangeCharactersInRange:(NSRange)range;
+(NSString*)mobileNumberToTenDigitIfValid:(NSString *)number;
+(NSError *)verifiyEmailOrMobile:(NSString *)userName;
+(BOOL)validateAmountString:(NSString *)amount;



    //colors/fonts
+(UIColor *)colorFromHexString:(NSString *)hexString;
+(NSString *)correctCommonAmountFormat:(NSString *)amount;

+(UIColor *)topBarColor;
+(UIColor *)topTitleTextColor;
+(UIColor *)buttonColor;
+(UIColor *)buttonTextColor;
+(UIColor *)indicatorTintColor;

    //style fonts PnP
+(NSDictionary*)fontStyleForNumber:(int)number;
+(UILabel *)lableWithStyleNumber:(int)number;
+(UIColor *)colorForStyle:(int)styleNumber;
+(UIFont *)fontForStyle:(int)styleNumber;

    //formatting
+(NSString *)cardNumberSpaced:(NSString *)cardNumber;
+(NSString *)dateToMMYYYYformat:(NSString *)date;
+(NSString *)addIndianCode:(NSString *)mobile;
+(NSString*)correctExpiryDate:(NSString *)date;
+(NSString *)convertToDecimalAmountString:(NSString *)amount;
+(BOOL)appendHyphenForCardnumber:(UITextField*)textField replacementString:(NSString*)string shouldChangeCharactersInRange:(NSRange)range;
+(BOOL)appendHyphenForMobilenumber:(UITextField*)textField replacementString:(NSString*)string shouldChangeCharactersInRange:(NSRange)range;
+(CTSContactUpdate *)correctContactIfNeeded:(CTSContactUpdate *)contact;
+(CTSUserAddress *)correctAdressIfNeeded:(CTSUserAddress *)address;
+(CTSContactUpdate *)convertFromProfile:(CTSProfileContactRes *)profile;
+(CTSContactUpdate *)convertFromProfile:(CTSProfileContactRes *)profile contact:(CTSContactUpdate *)contact;


    //image
+(UIImage *)imagefromBundleNamed:(NSString *)name class:(Class )class;


    //card specfic
+(NSString*)fetchCardSchemeForCardNumber:(NSString *)cardNumber;
+(BOOL)isCC:(NSDictionary *)savedCardDict;
+(BOOL)isDC:(NSDictionary *)savedCardDict;
+(BOOL)isAmex:(NSString *)number;
+(BOOL)isMaestero:(NSString *)number;


    //User defaults
+(NSString*)readFromDisk:(NSString*)key;
+(void)saveToDisk:(id)data as:(NSString*)key;
+(void)removeFromDisk:(NSString*)key;
+(id)readDataFromDisk:(NSString*)key;


    //web
+(void)deleteSigninCookie;
+(BOOL)isCookieSetAlready;
+(BOOL)isUserCookieValid;
+(NSString*)getHTMLWithString:(NSString *)string;
+(BOOL)isURL:(NSURL *)aURL toUrl:(NSURL *)bUrl;
@end
