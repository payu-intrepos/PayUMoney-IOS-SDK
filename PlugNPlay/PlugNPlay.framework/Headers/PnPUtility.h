//
//  PnPUtility.h
//  PlugNPlay
//
//  Created by Yadnesh Wankhede on 10/5/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface PnPUtility : NSObject
+(void)cachePaymentDictionary:(NSDictionary *)paymentReceipt;
+(void)handleCancellPayment:(UIViewController *)viewController;
+(void)handlePaymentData:(NSDictionary *)response error:(NSError *)error success:(BOOL)success viewC:(UIViewController *)viewController;
//+(PlugAndPlayPayment *)paymentProperties;
//+(NSString *)paymentAmount;
//+(UIViewController *)merchantReturnVC;
+(id)completionHandler;

+(void)cacheFetchUserData:(id)fetchUserData;
+(id)userData;

//+(BOOL)isCompletionScreenDisabled;
//+(NSString*)merchantDisplayName;
//
+(NSError *)paymentError;

+(void)cachePaymentError:(NSError *)error;
+(void)callCompletionWithPaymentResponse;
+(void)pushSuccessController:(NSString *)payAmount viewController:(UIViewController *)vc;

//+(UIColor *)topBarColor;
//+(UIColor *)topTitleTextColor;
//+(UIColor *)buttonColor;
//+(UIColor *)buttonTextColor;
//+(NSString *)fetchBankNameByIFSCCode:(NSString *)bankIFSCCode;
//+(NSString *)fetchInitialFourAlphabetsFromIFSCCode:(NSString *)bankIFSCCode;

//+(BOOL)shouldReloadWallet;
//+(void)setReloadWalletFlag;
//+(void)resetReloadWalletFlag;

//+(void)setLoadMoneyReturnUrl:(NSString *)url;
//+(NSString *)loadMoneyReturnUrl;

+(void)handleFailureWithViewC:(UIViewController *)controller message:(NSString *)message title:(NSString*)title;

#pragma mark - Taken from PnPUtility
#pragma mark -
+(BOOL)isStringNonNumeric:(NSString *)string;
+ (NSString*)fetchCardSchemeForCardNumber:(NSString*)cardNumber;
+(NSString *)removeWhiteSpacesFromString:(NSString *)string;
+ (BOOL)validateExpiryDate:(NSString*)date;
+(UIImage *)imagefromBundleNamed:(NSString *)name class:(Class )class;

#pragma mark - Validators
+(BOOL)validateDecimalAmountString:(NSString *)amount;
+(BOOL)validateEmail:(NSString*)email;
//+(BOOL)validateMobile:(NSString*)mobile;
+(BOOL)validateCardNumber:(NSString*)number;
+(BOOL)validateCVV:(NSString*)cvv cardNumber:(NSString*)cardNumber;
//+(BOOL)isVerifyPage:(NSString *)urlString;
//+(BOOL)enterNumericOnly:(NSString*)string;
//+(BOOL)enterCharecterOnly:(NSString*)string;
//+(BOOL)isEmail:(NSString *)string;
//+(BOOL)validateCVVNumber:(UITextField*)textField replacementString:(NSString*)string shouldChangeCharactersInRange:(NSRange)range;
//+(BOOL)validateCVVNumber:(UITextField*)textField cardNumber:(NSString*)cardNumber replacementString:(NSString*)string shouldChangeCharactersInRange:(NSRange)range;
//+(NSString*)mobileNumberToTenDigitIfValid:(NSString *)number;
//+(NSError *)verifiyEmailOrMobile:(NSString *)userName;
+(BOOL)validateAmountString:(NSString *)amount;

#pragma mark - Formatters
+(NSString *)cardNumberSpaced:(NSString *)cardNumber;
+(NSString *)cardNumberSpaced:(NSString *)cardNumber withCardType:(NSString *)cardType;

+(UIColor *)colorForStyle:(int)styleNumber;
+(UIColor *)colorFromHexString:(NSString *)hexString;
+(UIFont *)fontForStyle:(int)styleNumber;
+(UILabel *)lableWithStyleNumber:(int)number;
+(UIColor *)getViewBackgroundColor;

#pragma mark - Helpers
+(NSArray*)uniqueSortedNetBanks:(NSArray*)merchantNetBanks;
+(NSString*)getFirstNChars:(unsigned int)n fromString:(NSString*)str;
+(void)showAnimConstraint:(NSLayoutConstraint*)constraint
                    value:(int)constraintValue
                   sender:(UIView *)view;

+(NSDecimalNumber *)roundUpNumberTo2DecimalPlaces:(NSDecimalNumber *) number;
+(NSString *)getDisplayCardNameForCardNumber:(NSString *)cardNumber pg:(NSString *) pg;
+(BOOL)isAmexCard:(NSString *)cardNumber;

+ (NSArray *)topNBBanks;

+ (void)saveTopNBBanks:(NSArray *)topNBBanks;

+ (void)usedNBForBank:(NSString *)bankName andBankCode:(NSString *)bankCode;

+ (NSArray *)selectedWallets;

+ (void)usedWallet:(NSString *)name code:(NSString *)code;
+ (void)saveTopWallets:(NSArray *)topWallets;


+ (NSArray *)selectedEMIOptions;
+ (void)usedEMIOption:(NSString *)name code:(NSString *)code;
+ (void)saveTopEMIOptions:(NSArray *)topEMIOptions;

+ (NSArray *)getCardBinsArrayFromStoredCardArray:(NSArray *) arr;
+(NSString *)getDisplayCardNameForBankName:(NSString *)bankName pg:(NSString *) pg;

@end
