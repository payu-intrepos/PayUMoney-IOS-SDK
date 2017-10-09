//
//  CTSError.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 26/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTSPaymentTransactionRes, CTSDyPResponse, CTSResponse, CTSBlazeCardTransactionInternal;

typedef enum {
    NoError = 7000,
    UserNotSignedIn,
    EmailNotValid,
    MobileNotValid,
    CvvNotValid,
    CardNumberNotValid,
    ExpiryDateNotValid,
    ServerErrorWithCode,
    InvalidParameter,
    OauthTokenExpired,
    CantFetchSignupToken,
    TokenMissing,
    InternetDown,
    WrongBill,
    NoViewController,
    ReturnUrlNotValid,
    AmountNotValid,
    PrepaidBillFetchFailed,
    NoOrMoreInstruments,
    BankAccountNotValid,
    NoCookieFound,
    ReturnUrlCallbackNotValid,
    TransactionForcedClosed,
    TransactionAlreadyInProgress,
    InsufficientBalance,
    CardHolderNameInvalid,
    DeleteCardNumberNotValid,
    MessageNotValid,
    BinCardLengthNotValid,
    DPRuleNameNotValid,
    DPAlteredAmountNotValid,
    PaymentInfoInValid,
    DPRequestTypeInvalid,
    DPSignatureInvalid,
    DPResponseNotFound,
    CitrusPaymentTypeInvalid,
    BankIssuerCode,
    UndefinedPaymentType,
    NoSigninData,
    BillUrlNotInvalid,
    DPOriginalAmountNotValid,
    CardTokenInvalid,
    DPMerchantQueryNotValid,
    TransactionFailed,
    KeyStoreNotSet,
    CitrusLinkResponseNotFound,
    CompletionHandlerNotFound,
    UnknownPasswordType,
    NoNewPrepaidPrelivilage,
    WrongTypeSubscription,
    NoRefreshToken,
    PasswordTypeNotAllowed,
    WrongPaymentAmount,
    PaymentInstrumentNotAllowed,
    AlreadyLimitedScope,
    InvalidOperation,
    EmailMobileBothInvalid,
    NotMobileBasedAccount,
    LoadMoneyFailed,
    SubscriptionIdInvalid,
    InvalidAutoloadAmount,
    InvalidThresholdAmount,
    NotCreditCard,
    NoCCLoadMoneyInfoFound,
    InvalidThresholdAndAutoLoadAmt,
    NoActiveSubscriptions,
    UserTappedDone,
    SimpliPayCantProcess,
    WalletPaymentCantProcess,
    LoadMoneyCantProcess,
    BillUrlOrObjectInvalid,
    OrchestrationLayerFailed,
    PnPMissingPaymentOption,
    AmountLessThanOne
} CTSErrorCode;


extern NSString * const CITRUS_ERROR_DOMAIN;
extern NSString * const CITRUS_ERROR_DOMAIN_DP;
extern NSString * const CITRUS_ERROR_DESCRIPTION_KEY;
extern int INTERNET_DOWN_STATUS_CODE;

@interface CTSError : NSObject
// Follwoing methods are for internal use only
+ (NSError*)getErrorForCode:(CTSErrorCode)code;
//+ (NSError*)getErrorForCode:(CTSErrorCode)code paramType:();

+ (NSError*)getServerErrorWithCode:(int)errorCode
                          withInfo:(NSDictionary*)information;
+(NSString *)getFakeJsonForCode:(CTSErrorCode)errorCode;
+(NSError *)errorForStatusCode:(int)statusCode;
+(NSError *)convertToError:(CTSPaymentTransactionRes *)ctsPaymentTxRes;
+(NSError *)convertToErrorDyIfNeeded:(CTSDyPResponse *)ctsPaymentTxRes;
+(NSError *)convertCTSResToErrorIfNeeded:(CTSResponse *)response;


+ (NSError *)parseBlazeNetError:(NSString *)errorResponse;
+ (NSError *)parseBlazeCardError:(CTSBlazeCardTransactionInternal *)errorResponse;
@end
