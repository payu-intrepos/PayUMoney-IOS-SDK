//
//  PMSDKErrors.h
//  PayUmoney_SampleApp
//
//  Created by Umang Arya on 4/11/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUMSDKError : NSObject


typedef NS_ENUM(NSInteger, PUMSDKErrorCode)
{
    NoError = 7000,
    PUMErrorUserNotSignedIn,
    PUMErrorEmailNotValid,
    PUMErrorMobileNotValid,
    PUMErrorCvvNotValid,
    PUMErrorCardNumberNotValid,
    PUMErrorExpiryDateNotValid,
    PUMErrorPGInvalid,
    PUMErrorCardTypeInvalid,
    PUMErrorBankCodeInvalid,
    PUMErrorInvalidParameter,
    PUMErrorOauthTokenExpired,
    PUMErrorInternetDown,
    PUMErrorAmountNotValid,
    PUMErrorCardHolderNameInvalid,
    PUMErrorCardTokenInvalid,
    PUMErrorTransactionFailed,
    PUMErrorKeyStoreNotSet,
    PUMErrorCompletionHandlerNotFound,
    PUMErrorPasswordTypeNotAllowed,
    PUMErrorPnPMissingPaymentOption,
    PUMErrorAmountLessThanMinimumAmount,
    PUMErrorTokenInvalid,
    PUMErrorResponseNotADictionary,
    PUMErrorBackButtonPressed,
    PUMErrorUnKnownErrorOccured,
    PUMErrorSomeErrorOccured,
    PUMErrorTxnParamNotSet,
    PUMErrorNoPaymentModeSelected,
    PUMErrorCardDetailFailed,
    PUMErrorPaymentParamNotSet,
    PUMErrorCardLengthNot6,
    PUMErrorTxnExpired,
    PUMErrorMerchantKeyNotSet,
    PUMErrorMerchantIdNotSet,
    PUMErrorTxnIdInValid,
    PUMErrorSurlNotSet,
    PUMErrorSurlInvalid,
    PUMErrorFurlNotSet,
    PUMErrorFurlInvalid,
    PUMErrorHashValueInvalid,
    PUMErrorEnvironmentNotSet,
    PUMErrorReturnViewControllerNotSet,
    PUMErrorEnterValidOTPPassword,
    PUMErrorSomethingWentWrong,
    PUMErrorTxnLessThanMinWalletAllowed,
    PUMErrorInsufficientFund,
    PUMErrorWalletAmountMoreThanPayAmount,
    PUMErrorCCUnavailable,
    PUMErrorDCUnavailable,
    PUMErrorNBUnavailable,
    PUMErrorWalletUnavailable,
    PUMErrorPaymentIDUnavailable,
    PUMErrorMobileOrEmailInvalid,
    PUMError3PWalletUnavailable,
    PUMErrorSplitNotAllowedWith3PWallet,
    PUMError3PWalletNotSupported,
    PUMErrorCantSaveCard,
    PUMErrorEMIUnavailable,
    PUMErrorEMIOptionUnavailable,
    PUMErrorSplitNotAllowedWithEMI,
    PUMErrorInternationalCardWithEMI,
    PUMErrorDebitCardWithEMI,
    PUMInvalidReviewOrder,
    PUMErrorSaveCardUnavailable,
    PUMErrorSplitNotAllowedWithUPI,
    PUMErrorInvalidVPA,
    PUMErrorUnableToValidateVPA
};

+(NSError *)toNSError:(int)errorCode
              message:(NSString *)message;

+ (NSError*)getErrorForCode:(PUMSDKErrorCode)code;

@end
