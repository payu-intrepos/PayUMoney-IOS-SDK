//
//  CTSPaymentLayer.h
//  RestFulltester
//
//  Created by Raji Nair on 19/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CTSCardBinJSON.h"

#import "CTSRestPluginBase.h"
#import "CTSRuleInfo.h"
#import "CTSAuthLayer.h"
#import "CitrusCashRes.h"
#import "CTSPaymentDetailUpdate.h"
#import "CTSUser.h"
#import "CTSDyPResponse.h"
#import "CTSBill.h"
#import "CTSPgSettings.h"
#import "CTSTransferMoneyResponse.h"
#import "CTSAmount.h"
#import "CTSCashoutBankAccount.h"
#import "CTSCardBinResponse.h"
#import "CTSCashoutToBankRes.h"
#import "CTSPrepaidBill.h"
#import "CTSPaymentTransactionRes.h"
#import "CTSPGHealthRes.h"
#import "CTSDyPValidateRuleReq.h"
#import "CTSPrepaidPayResp.h"
#import "CTSPaymentRequest.h"
#import "HVDOverlay.h"
#import "CTSSimpliChargeDistribution.h"
#import "CTSPaymentOptions.h"
#import "CTSPaymentReceipt.h"
#import "CTSAutoLoadSubGetResp.h"
#import "CTSLoadAndPayRes.h"
#import "CTSLoadMoney.h"
#import "CTSAutoLoad.h"
#import "PaymentType.h"

/// Class Models.
@class   CTSPaymentWebViewController , CTSContactUpdate, CTSUserAddress;

/**
 PaymentRequestType enum.
 */
typedef enum {
    /**
     *   The PaymentAsGuestReqId type of PaymentRequestType enum.
     */
    PaymentAsGuestReqId,
    /**
     *   The PaymentUsingtokenizedCardBankReqId type of PaymentRequestType enum.
     */
    PaymentUsingtokenizedCardBankReqId,
    /**
     *   The PaymentUsingSignedInCardBankReqId type of PaymentRequestType enum.
     */
    PaymentUsingSignedInCardBankReqId,
    /**
     *   The PaymentPgSettingsReqId type of PaymentRequestType enum.
     */
    PaymentPgSettingsReqId,
    /**
     *   The PaymentAsCitruspayInternalReqId type of PaymentRequestType enum.
     */
    PaymentAsCitruspayInternalReqId,
    /**
     *   The PaymentAsCitruspayReqId type of PaymentRequestType enum.
     */
    PaymentAsCitruspayReqId,
    /**
     *   The PaymentGetPrepaidBillReqId type of PaymentRequestType enum.
     */
    PaymentGetPrepaidBillReqId,
    /**
     *   The PaymentLoadMoneyCitrusPayReqId type of PaymentRequestType enum.
     */
    PaymentLoadMoneyCitrusPayReqId,
    /**
     *   The PaymentCashoutToBankReqId type of PaymentRequestType enum.
     */
    PaymentCashoutToBankReqId,
    /**
     *   The PaymentChargeInnerWebNormalReqId type of PaymentRequestType enum.
     */
    PaymentChargeInnerWebNormalReqId,
    /**
     *   The PaymentChargeInnerWeblTokenReqId type of PaymentRequestType enum.
     */
    PaymentChargeInnerWeblTokenReqId,
    /**
     *   The PaymentChargeInnerWebLoadMoneyReqId type of PaymentRequestType enum.
     */
    PaymentChargeInnerWebLoadMoneyReqId,
    /**
     *   The PGHealthReqId type of PaymentRequestType enum.
     */
    PGHealthReqId,
    /**
     *   The PaymentDynamicPricingReqId type of PaymentRequestType enum.
     */
    PaymentDynamicPricingReqId,
    /**
     *   The PaymentRequestTransferMoney type of PaymentRequestType enum.
     */
    PaymentRequestTransferMoney,
    /**
     *   The PaymentDPValidateRuleReqId type of PaymentRequestType enum.
     */
    PaymentDPValidateRuleReqId,
    /**
     *   The PaymentDPCalculateReqId type of PaymentRequestType enum.
     */
    PaymentDPCalculateReqId,
    /**
     *   The PaymentDPQueryMerchantReqId type of PaymentRequestType enum.
     */
    PaymentDPQueryMerchantReqId,
    /**
     *   The PaymentCardBinServiceReqId type of PaymentRequestType enum.
     */
    PaymentCardBinServiceReqId,
    /**
     *   The PayUsingDynamicPricingReqId type of PaymentRequestType enum.
     */
    PayUsingDynamicPricingReqId,
    /**
     *   The PayPrepaidNewReqId type of PaymentRequestType enum.
     */
    PayPrepaidNewReqId,
    /**
     *   The PayPrepaidNewInternalReqId type of PaymentRequestType enum.
     */
    PayPrepaidNewInternalReqId,
    /**
     *   The PaymentNewAsGuestReqId type of PaymentRequestType enum.
     */
    PaymentNewAsGuestReqId,
}PaymentRequestType;


/**
 *   AutoLoadSubsctiptionType enum.
 */
typedef enum{
    /**
     *   The AutoLoadSubsctiptionTypeActive type of AutoLoadSubsctiptionType enum.
     */
    AutoLoadSubsctiptionTypeActive,
    /**
     *   The AutoLoadSubsctiptionTypeInActive type of AutoLoadSubsctiptionType enum.
     */
    AutoLoadSubsctiptionTypeInActive,
    /**
     *   The AutoLoadSubsctiptionTypeAll type of AutoLoadSubsctiptionType enum.
     */
    AutoLoadSubsctiptionTypeAll
}AutoLoadSubsctiptionType;

/**
 *   CitrusPaymentType enum.
 */
typedef enum{
    /**
     *   The CitrusPaymentTypeDirect type of CitrusPaymentType enum.
     */
    CitrusPaymentTypeDirect,
    /**
     *   The CitrusPaymentTypeCitrusCash type of CitrusPaymentType enum.
     */
    CitrusPaymentTypeCitrusCash,
}CitrusPaymentType;

/**
 *   LoadMoneyResponeKey.
 */
extern NSString * const LoadMoneyResponeKey;

#define LogThread LogTrace(@"THREAD  %@", [NSThread currentThread]);

/// Class Models.
@class CTSAuthLayer;
@class CTSAuthenticationProtocol;
@class CTSPaymentLayer;

/**
 *   CTSPaymentProtocol.
 */
@protocol CTSPaymentProtocol<NSObject>
    @optional
- (void)payment:(CTSPaymentLayer*)layer
didMakeUserPayment:(CTSPaymentTransactionRes*)paymentInfo
          error:(NSError*)error;
    
    /**
     *  Guest payment callback
     *
     *  @param layer
     *  @param paymentInfo
     *  @param error
     */
    @optional
- (void)payment:(CTSPaymentLayer*)layer
didMakePaymentUsingGuestFlow:(CTSPaymentTransactionRes*)paymentInfo
          error:(NSError*)error;
    
    //Vikas new payment api
    /**
     *  Guest payment callback
     *
     *  @param layer
     *  @param responseString
     *  @param error
     */
    
    @optional
- (void)payment:(CTSPaymentLayer*)layer
didMakeNewPaymentUsingGuestFlow:(NSString*)responseString
          error:(NSError*)error;
    
    /**
     *  response for tokenized payment
     *
     *  @param layer
     *  @param paymentInfo
     *  @param error
     */
    @optional
- (void)payment:(CTSPaymentLayer*)layer
didMakeTokenizedPayment:(CTSPaymentTransactionRes*)paymentInfo
          error:(NSError*)error;
    
    /**
     *  pg setting are recived for merchant
     *
     *  @param pgSetting pegsetting,nil in case of error
     *  @param error     ctserror
     */
    @optional
- (void)payment:(CTSPaymentLayer*)layer
didPaymentCitrusCash:(CTSCitrusCashRes*)pgSettings
          error:(NSError*)error;
    
    /**
     *   didRequestMerchantPgSettings.
     *
     *  @param layer The layer CTSPaymentLayer.
     *  @param linkRes The pgSettings CTSPgSettings.
     *  @param error The error NSError.
     */
    @optional
- (void)payment:(CTSPaymentLayer*)layer
didRequestMerchantPgSettings:(CTSPgSettings*)pgSettings
          error:(NSError*)error;
    
    /**
     *   didGetPrepaidBill.
     *
     *  @param layer The layer CTSPaymentLayer.
     *  @param bill The bill CTSPrepaidBill.
     *  @param error The error NSError.
     */
    @optional
- (void)payment:(CTSPaymentLayer*)layer
didGetPrepaidBill:(CTSPrepaidBill*)bill
          error:(NSError*)error;
    
    
    /**
     *   didLoadMoney.
     *
     *  @param layer The layer CTSPaymentLayer.
     *  @param paymentInfo The paymentInfo CTSPaymentTransactionRes.
     *  @param error The error NSError.
     */
    @optional
- (void)payment:(CTSPaymentLayer*)layer
   didLoadMoney:(CTSPaymentTransactionRes*)paymentInfo
          error:(NSError*)error;
    
    
    /**
     *   didCashoutToBank.
     *
     *  @param layer The layer CTSPaymentLayer.
     *  @param cashoutToBankRes The cashoutToBankRes CTSCashoutToBankRes.
     *  @param error The error NSError.
     */
    @optional
- (void)payment:(CTSPaymentLayer*)layer
didCashoutToBank:(CTSCashoutToBankRes *)cashoutToBankRes
          error:(NSError*)error;
    @end


// CallBack Handlers
/**
 *   The CTSPaymentLayer class' CTSSimpliPayCompletionHandler CallBack.
 *
 *   The Newly created paymentReceipt, error object.
 */
typedef void (^CTSCardBinServiceCompletionHandler)(CTSCardBinJSON *cardBinJSON, NSError *error);

/**
 *   The CTSPaymentLayer class' CTSSimpliPayCompletionHandler CallBack.
 *
 *   The Newly created paymentReceipt, error object.
 */
typedef void (^CTSSimpliPayCompletionHandler)(CTSPaymentReceipt *paymentReceipt,
NSError *error);

/**
 *   The CTSPaymentLayer class' CTSPaymentDistributionCompletionHandler CallBack.
 *
 *   The Newly created amountDistribution, error object.
 */
typedef void (^CTSPaymentDistributionCompletionHandler)(CTSSimpliChargeDistribution *amountDistribution,
NSError *error);

/**
 *   The CTSPaymentLayer class' ASGetAutoloadSubsCallback CallBack.
 *
 *   The Newly created autoloadSubscriptions, error object.
 */
typedef void (^ASGetAutoloadSubsCallback)(CTSAutoLoadSubGetResp* autoloadSubscriptions,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASAutoLoadCallback CallBack.
 *
 *   The Newly created autoloadResponse, error object.
 */
typedef void (^ASAutoLoadCallback)( CTSAutoLoadSubResp *autoloadResponse,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASLoadAndSubscribeCallback CallBack.
 *
 *   The Newly created loadAndSubscribe, error object.
 */
typedef void (^ASLoadAndSubscribeCallback)(CTSLoadAndPayRes* loadAndSubscribe,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASMakeUserPaymentCallBack CallBack.
 *
 *   The Newly created paymentInfo, error object.
 */
typedef void (^ASMakeUserPaymentCallBack)(CTSPaymentTransactionRes* paymentInfo,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASMakeTokenizedPaymentCallBack CallBack.
 *
 *   The Newly created paymentInfo, error object.
 */
typedef void (^ASMakeTokenizedPaymentCallBack)(CTSPaymentTransactionRes* paymentInfo,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASMakeGuestPaymentCallBack CallBack.
 *
 *   The Newly created paymentInfo, error object.
 */
typedef void (^ASMakeGuestPaymentCallBack)(CTSPaymentTransactionRes* paymentInfo,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASMakeNewPaymentCallBack CallBack.
 *
 *   The Newly created responseString, error object.
 */
typedef void (^ASMakeNewPaymentCallBack)(NSString* responseString , NSError* error);

/**
 *   The CTSPaymentLayer class' ASMakeCitruspayCallBackInternal CallBack.
 *
 *   The Newly created paymentInfo, error object.
 */
typedef void (^ASMakeCitruspayCallBackInternal)(CTSPaymentTransactionRes* paymentInfo,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASCitruspayCallback CallBack.
 *
 *   The Newly created citrusCashResponse, error object.
 */
typedef void (^ASCitruspayCallback)(CTSCitrusCashRes* citrusCashResponse,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASGetMerchantPgSettingsCallBack CallBack.
 *
 *   The Newly created pgSettings, error object.
 */
typedef void (^ASGetMerchantPgSettingsCallBack)(CTSPgSettings* pgSettings,
NSError* error);

/**
 *   The CTSAuthLayer class' ASGetPrepaidBill CallBack.
 *
 *   The Newly created prepaidBill, error object.
 */
typedef void (^ASGetPrepaidBill)(CTSPrepaidBill* prepaidBill,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASLoadMoneyCallBack CallBack.
 *
 *   The Newly created paymentInfo, error object.
 */
typedef void (^ASLoadMoneyCallBack)(CTSPaymentTransactionRes* paymentInfo,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASCashoutToBankCallBack CallBack.
 *
 *   The Newly created cashoutRes, error object.
 */
typedef void (^ASCashoutToBankCallBack)(CTSCashoutToBankRes *cashoutRes,
NSError* error);

/**
 *   The CTSAuthLayer class' ASGetPGHealth CallBack.
 *
 *   The Newly created pgHealthRes, error object.
 */
typedef void (^ASGetPGHealth)(CTSPGHealthRes* pgHealthRes,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASPerformDynamicPricingCallback CallBack.
 *
 *   The Newly created dyPResponse, error object.
 */
typedef void (^ASPerformDynamicPricingCallback)(CTSDyPResponse* dyPResponse,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASDPValidateRuleCallback CallBack.
 *
 *   The Newly created dyPResponse, error object.
 */
typedef void (^ASDPValidateRuleCallback)(CTSDyPResponse* dyPResponse,
NSError* error);

/**
 *   The CTSPaymentLayer class' ASMoneyTransferCallback CallBack.
 *
 *   The Newly created transferMoneyRes, error object.
 */
typedef void (^ASMoneyTransferCallback)(CTSTransferMoneyResponse* transferMoneyRes
,NSError* error);

/**
 *   The CTSPaymentLayer class' ASCardBinServiceCallback CallBack.
 *
 *   The Newly created cardBinResponse, error object.
 */
typedef void (^ASCardBinServiceCallback)(CTSCardBinResponse* cardBinResponse
,NSError* error);

/**
 *   The CTSPaymentLayer class' ASPrepaidPayCallback CallBack.
 *
 *   The Newly created prepaidPay, error object.
 */
typedef void (^ASPrepaidPayCallback)(CTSPrepaidPayResp* prepaidPay,
NSError* error);
/**
 *   CTSPaymentLayer.
 */
@interface CTSPaymentLayer : CTSRestPluginBase <CTSAuthenticationProtocol, UIWebViewDelegate> {
    /**
     *  The CTSPaymentLayer class' finished object.
     */
    BOOL finished;
    /**
     *  The CTSPaymentLayer class' cCashReturnUrl object.
     */
    NSString *cCashReturnUrl;
    /**
     *  The CTSPaymentLayer class' prepaidRequestType object.
     */
    PaymentRequestType prepaidRequestType;
    /**
     *  The CTSPaymentLayer class' tempCVVStoreObject object.
     */
    CTSPaymentDetailUpdate *tempCVVStoreObject;
}
    /**
     *  The CTSPaymentLayer class' citrusCashBackViewController object.
     */
    @property (strong) UIViewController *citrusCashBackViewController;
    /**
     *  The CTSPaymentLayer class' citrusPayWebview object.
     */
    @property(strong)UIWebView *citrusPayWebview;
    /**
     *  The CTSPaymentLayer class' merchantTxnId object.
     */
    @property(strong) NSString* merchantTxnId;
    /**
     *  The CTSPaymentLayer class' signature object.
     */
    @property(strong) NSString* signature;
    /**
     *  The CTSPaymentLayer class' delegate object.
     */
    @property(weak) id <CTSPaymentProtocol> delegate;
    /**
     *  The CTSPaymentLayer class' paymentWebViewController object.
     */
    @property(strong) CTSPaymentWebViewController *paymentWebViewController;
    
    
    /**
     *   Fetch Shared PaymentLayer.
     *
     *  @return The PaymentLayer object.
     */
+(CTSPaymentLayer*)fetchSharedPaymentLayer;
    
    /**
     *   initWithUrl.
     *
     *  @param url The Transaction Amount.
     *
     *  @return The Newly created object.
     */
- (instancetype)initWithUrl:(NSString *)url;
    
    /**
     *   initWithKeyStore.
     *
     *  @param keystoreArg The signinId String, signUpId String, signinSecret String, signUpSecret String and vanity String.
     *
     *  @return The Newly created object.
     */
- (instancetype)initWithKeyStore:(CTSKeyStore *)keystoreArg;
    
    /**
     ***************************************************************************************************************
     BIN SERVICE API'S
     ***************************************************************************************************************
     */
    /**
     *  requestCardBINService -
     *
     *  @param firstSixCardNumber - The firstSixCardNumber String
     *  @param completion - return callback into cardBinJSON & error
     */
- (void)requestCardBINService:(NSString *)firstSixCardNumber
            completionHandler:(CTSCardBinServiceCompletionHandler)completion;
    
    /**
     *  requestAuthCardBINService -
     *
     *  @param firstSixCardNumber - The firstSixCardNumber String
     *  @param completion - return callback into cardBinJSON & error
     */
- (void)requestAuthCardBINService:(NSString *)firstSixCardNumber
                completionHandler:(CTSCardBinServiceCompletionHandler)completion;
    
    /**
     ***************************************************************************************************************
     SIMPLIPAY - SINGLE PAYMEN INTERFACE
     ***************************************************************************************************************
     */
    
    /**
     *  requestSimpliPay - SimpliPay Init Orchestration Layer For All Payment Single End Point.
     *
     *  @param paymentType - The PaymentType (MVCPayment/citrusCashPayment/PGPayment/performDynamicPricing/splitPayment/loadMoney).
     *  @param controller  - The Current Controller Self Object.
     *  @param completion  - The Callback into PaymentReceipt & Error.
     */
- (void)requestSimpliPay:(PaymentType *)paymentType
 andParentViewController:(UIViewController *)controller
       completionHandler:(CTSSimpliPayCompletionHandler)completion;
    
    /**
     *  requestCalculatePaymentDistribution - Request Calculate Payment Distribution - for Split Payment.
     *
     *  @param amount     - The Transaction Amount.
     *  @param completion - The callback into AmountDistribution viz mvcAmount, cashAmount, remainingAmount & totalAmount, BOOL useMVC, useCash & enoughMVCAndCash.
     */
- (void)requestCalculatePaymentDistribution:(NSString *)amount
                          completionHandler:(CTSPaymentDistributionCompletionHandler)completion;
    
    
    
    /**
     ***************************************************************************************************************
     AUTOLOAD
     ***************************************************************************************************************
     */
    
    /**
     *   requestUpdateAutoLoadSubId.
     *
     *  @param subId           The subId NSString.
     *  @param autoLoadAmt     The autoLoadAmt NSString.
     *  @param thresholdAmount The thresholdAmount NSString.
     *  @param callback        The callback ASAutoLoadCallback.
     */
-(void)requestUpdateAutoLoadSubId:(NSString *)subId
                   autoLoadAmount:(NSString *)autoLoadAmt
                  thresholdAmount:(NSString *)thresholdAmount
                       completion:(ASAutoLoadCallback)callback;
    
    /**
     *   requestGetAutoLoadSubType.
     *
     *  @param type     The type AutoLoadSubsctiptionType.
     *  @param callback The callback ASGetAutoloadSubsCallback.
     */
-(void)requestGetAutoLoadSubType:(AutoLoadSubsctiptionType)type
                      completion:(ASGetAutoloadSubsCallback)callback;
    
    /**
     *   requestGetActiveAutoLoadSubscription.
     *
     *  @param callback The callback ASAutoLoadCallback.
     */
-(void)requestGetActiveAutoLoadSubscription:(ASAutoLoadCallback)callback;
    
    /**
     *   requestDeactivateAutoLoadSubId.
     *
     *  @param subId    The subId subId.
     *  @param callback The callback ASAutoLoadCallback.
     */
-(void)requestDeactivateAutoLoadSubId:(NSString*)subId
                           completion:(ASAutoLoadCallback)callback;
    
    /**
     *   requestDeactivateAutoLoadSubscription.
     *
     *  @param callback The callback ASAutoLoadCallback.
     */
-(void)requestDeactivateAutoLoadSubscription:(ASAutoLoadCallback)callback;
    
    /**
     *   requestLoadAndSubscribe.
     *
     *  @param loadMoney The loadMoney CTSLoadMoney.
     *  @param autoload  The autoload CTSAutoLoad.
     *  @param callback  The callback ASLoadAndSubscribeCallback.
     */
- (void)requestLoadAndSubscribe:(CTSLoadMoney*)loadMoney
                       autoLoad:(CTSAutoLoad *)autoload
          withCompletionHandler:(ASLoadAndSubscribeCallback)callback;
    
    /**
     *   requestSubscribeAutoAfterLoad.
     *
     *  @param autoload The autoload CTSAutoLoad.
     *  @param callback The callback ASAutoLoadCallback.
     */
- (void)requestSubscribeAutoAfterLoad:(CTSAutoLoad *)autoload
                withCompletionHandler:(ASAutoLoadCallback)callback;
    
    /**
     *   requestLoadAndIncrementAutoloadSubId.
     *
     *  @param subId     The subId NSString.
     *  @param loadMoney The loadMoney CTSLoadMoney.
     *  @param autoload  The autoload CTSLoadMoney.
     *  @param callback  The callback ASLoadAndSubscribeCallback.
     */
- (void)requestLoadAndIncrementAutoloadSubId:(NSString *)subId
                                   loadMoney:(CTSLoadMoney*)loadMoney
                                    autoLoad:(CTSAutoLoad *)autoload
                       withCompletionHandler:(ASLoadAndSubscribeCallback)callback;
    
    
    /**
     *   requestDPQueryMerchant.
     *
     *  @param merchantAccessKey The merchantAccessKey String.
     *  @param signature         The signature String.
     *  @param callback          The ASPerformDynamicPricingCallback callback.
     */
- (void)requestDPQueryMerchant:(NSString *)merchantAccessKey
                     signature:(NSString *)signature
             completionHandler:(ASPerformDynamicPricingCallback)callback;
    
    /**
     *  request card pament options(visa,master,debit) and netbanking settngs for
     *the merchant
     *
     *  @param vanityUrl pass in unique vanity url obtained from Citrus Payment
     *sol.
     */
- (void)requestMerchantPgSettings:(NSString*)vanityUrl
            withCompletionHandler:(ASGetMerchantPgSettingsCallBack)callback;
    
    /**
     *   requestGetPrepaidBillForAmount.
     *
     *  @param amount    The amount String.
     *  @param returnUrl The returnUrl String.
     *  @param callback  The ASGetPrepaidBill callback.
     */
-(void)requestGetPrepaidBillForAmount:(NSString *)amount
                            returnUrl:(NSString *)returnUrl
                withCompletionHandler:(ASGetPrepaidBill)callback;
    
    /**
     *   requestCashoutToBank.
     *
     *  @param bankAccount The bankAccount String.
     *  @param amount      The amount String.
     *  @param callback    The ASCashoutToBankCallBack callback.
     */
-(void)requestCashoutToBank:(CTSCashoutBankAccount *)bankAccount
                     amount:(NSString *)amount
          completionHandler:(ASCashoutToBankCallBack)callback;
    
    /**
     get PG Health percentage.
     @param callback   Set success/failure callBack.
     @details          It will return JSON of PG health into bank code with percentage value.
     */
    
-(void)requestGetPGHealthWithCompletionHandler:(ASGetPGHealth)callback;
    
    /**
     *   requestCardDetails.
     *
     *  @param firstSix The firstSix Amount.
     *  @param callback The ASCardBinServiceCallback callback.
     */
-(void)requestCardDetails:(NSString *)firstSix
        completionHandler:(ASCardBinServiceCallback)callback;
    
    /**
     *   requestTransferMoneyTo.
     *
     *  @param username The username String.
     *  @param amount   The amount String.
     *  @param message  The message String.
     *  @param callback The ASMoneyTransferCallback callback.
     */
-(void)requestTransferMoneyTo:(NSString *)username
                       amount:(NSString *)amount
                      message:(NSString *)message
            completionHandler:(ASMoneyTransferCallback)callback;
    
    /**
     *   requestLoadMoneyPgSettingsCompletionHandler.
     *
     *  @param callback The ASGetMerchantPgSettingsCallBack callback.
     */
- (void)requestLoadMoneyPgSettingsCompletionHandler:(ASGetMerchantPgSettingsCallBack)callback;
    
    
    /**
     ***************************************************************************************************************
     DEPRECATED Start
     ***************************************************************************************************************
     */
    
    /**
     *   requestChargeTokenizedPayment.
     *
     *  @param paymentInfo The paymentInfo CTSPaymentDetailUpdate.
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param bill        The bill CTSBill.
     *  @param custParams  The custParams NSDictionary.
     *  @param callback    The callback ASMakeTokenizedPaymentCallBack.
     */
- (void)requestChargeTokenizedPayment:(CTSPaymentDetailUpdate*)paymentInfo
                          withContact:(CTSContactUpdate*)contactInfo
                          withAddress:(CTSUserAddress*)userAddress
                                 bill:(CTSBill *)bill
                         customParams:(NSDictionary *)custParams
                withCompletionHandler:(ASMakeTokenizedPaymentCallBack)callback DEPRECATED_MSG_ATTRIBUTE("use requestChargePayment:withContact:withAddress:bill:customParams:returnViewController:withCompletionHandler:");
    
    /**
     *   requestChargePayment.
     *
     *  @param paymentInfo The paymentInfo CTSPaymentDetailUpdate.
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param bill        The bill CTSBill.
     *  @param custParams  The custParams NSDictionary.
     *  @param callback    The callback ASMakeGuestPaymentCallBack.
     */
- (void)requestChargePayment:(CTSPaymentDetailUpdate*)paymentInfo
                 withContact:(CTSContactUpdate*)contactInfo
                 withAddress:(CTSUserAddress*)userAddress
                        bill:(CTSBill *)bill
                customParams:(NSDictionary *)custParams
       withCompletionHandler:(ASMakeGuestPaymentCallBack)callback
    DEPRECATED_MSG_ATTRIBUTE("use requestChargePayment:withContact:withAddress:bill:customParams:returnViewController:withCompletionHandler:");
    
    /**
     *   requestLoadMoneyInCitrusPay.
     *
     *  @param paymentInfo The paymentInfo CTSPaymentDetailUpdate.
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param amount      The amount NSString.
     *  @param returnUrl   The returnUrl NSString.
     *  @param custParams  The custParams NSDictionary.
     *  @param callback    The callback ASLoadMoneyCallBack.
     */
- (void)requestLoadMoneyInCitrusPay:(CTSPaymentDetailUpdate *)paymentInfo
                        withContact:(CTSContactUpdate*)contactInfo
                        withAddress:(CTSUserAddress*)userAddress
                             amount:(NSString *)amount
                          returnUrl:(NSString *)returnUrl
                       customParams:(NSDictionary *)custParams
              withCompletionHandler:(ASLoadMoneyCallBack)callback __attribute__((deprecated("Please use requestSimpliPay:andParentViewController:completionHandler: instead")));
    
    //new prepaid pay api
    
    /**
     *   requestChargeCitrusWalletWithContact.
     *
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param bill        The bill CTSBill.
     *  @param controller  The controller UIViewController.
     *  @param callback    The callback ASCitruspayCallback.
     */
- (void)requestChargeCitrusWalletWithContact:(CTSContactUpdate*)contactInfo
                                     address:(CTSUserAddress*)userAddress
                                        bill:(CTSBill *)bill
                        returnViewController:(UIViewController *)controller
                       withCompletionHandler:(ASCitruspayCallback)callback __attribute__((deprecated("Please use requestSimpliPay:andParentViewController:completionHandler: instead")));
    
    
    //old prepaid pay api
    
    /**
     *   requestChargeCitrusCashWithContact.
     *
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param bill        The bill CTSBill.
     *  @param custParams  The custParams NSDictionary.
     *  @param controller  The controller UIViewController.
     *  @param callback    The callback ASCitruspayCallback.
     */
- (void)requestChargeCitrusCashWithContact:(CTSContactUpdate*)contactInfo
                               withAddress:(CTSUserAddress*)userAddress
                                      bill:(CTSBill *)bill
                              customParams:(NSDictionary *)custParams
                      returnViewController:(UIViewController *)controller
                     withCompletionHandler:(ASCitruspayCallback)callback DEPRECATED_MSG_ATTRIBUTE("Use requestChargeCitrusWalletWithContact:address:bill:customParams:returnViewController:withCompletionHandler: ");
    
    /**
     *   requestChargeTokenizedPayment.
     *
     *  @param paymentInfo The paymentInfo CTSPaymentDetailUpdate.
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param bill        The bill CTSBill.
     *  @param custParams  The custParams NSDictionary.
     *  @param controller  The controller UIViewController.
     *  @param callback    The callback ASCitruspayCallback.
     */
- (void)requestChargeTokenizedPayment:(CTSPaymentDetailUpdate*)paymentInfo
                          withContact:(CTSContactUpdate*)contactInfo
                          withAddress:(CTSUserAddress*)userAddress
                                 bill:(CTSBill *)bill
                         customParams:(NSDictionary *)custParams
                 returnViewController:(UIViewController *)controller
                withCompletionHandler:(ASCitruspayCallback)callback DEPRECATED_MSG_ATTRIBUTE("use requestChargePayment:withContact:withAddress:bill:customParams:returnViewController:withCompletionHandler:");
    
    
    // single hop
    /**
     *   requestDirectChargePayment.
     *
     *  @param paymentInfo The paymentInfo CTSPaymentDetailUpdate.
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param bill        The bill CTSBill.
     *  @param controller  The controller UIViewController.
     *  @param callback    The Transaction Amount.
     */
- (void)requestDirectChargePayment:(CTSPaymentDetailUpdate*)paymentInfo
                       withContact:(CTSContactUpdate*)contactInfo
                       withAddress:(CTSUserAddress*)userAddress
                              bill:(CTSBill *)bill
              returnViewController:(UIViewController *)controller
             withCompletionHandler:(ASCitruspayCallback)callback __attribute__((deprecated("Please use requestSimpliPay:andParentViewController:completionHandler: instead")));
    
    
    //moto call
    /**
     *   requestChargePayment.
     *
     *  @param paymentInfo The paymentInfo CTSPaymentDetailUpdate.
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param bill        The bill CTSBill.
     *  @param custParams  The Transaction Amount.
     *  @param controller  The controller UIViewController.
     *  @param callback    The Transaction Amount.
     */
- (void)requestChargePayment:(CTSPaymentDetailUpdate*)paymentInfo
                 withContact:(CTSContactUpdate*)contactInfo
                 withAddress:(CTSUserAddress*)userAddress
                        bill:(CTSBill *)bill
                customParams:(NSDictionary *)custParams
        returnViewController:(UIViewController *)controller
       withCompletionHandler:(ASCitruspayCallback)callback __attribute__((deprecated("Please use requestSimpliPay:andParentViewController:completionHandler: instead")));
    
    
    /**
     *   requestLoadMoneyInCitrusPay.
     *
     *  @param paymentInfo The paymentInfo CTSPaymentDetailUpdate.
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param amount      The amount NSString.
     *  @param returnUrl   The returnUrl NSString.
     *  @param custParams  The custParams NSDictionary.
     *  @param controller  The controller UIViewController.
     *  @param callback    The callback ASCitruspayCallback.
     */
- (void)requestLoadMoneyInCitrusPay:(CTSPaymentDetailUpdate *)paymentInfo
                        withContact:(CTSContactUpdate*)contactInfo
                        withAddress:(CTSUserAddress*)userAddress
                             amount:(NSString *)amount
                          returnUrl:(NSString *)returnUrl
                       customParams:(NSDictionary *)custParams
               returnViewController:(UIViewController *)controller
              withCompletionHandler:(ASCitruspayCallback)callback __attribute__((deprecated("Please use requestSimpliPay:andParentViewController:completionHandler: instead")));
    
    
    /**
     *   requestChargeDynamicPricingContact.
     *
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param custParams  The custParams custParams.
     *  @param controller  The controller UIViewController.
     *  @param callback    The callback ASCitruspayCallback.
     */
- (void)requestChargeDynamicPricingContact:(CTSContactUpdate*)contactInfo
                               withAddress:(CTSUserAddress*)userAddress
                              customParams:(NSDictionary *)custParams
                      returnViewController:(UIViewController *)controller
                     withCompletionHandler:(ASCitruspayCallback)callback;
    
    /**
     *   requestPerformDynamicPricingRule.
     *
     *  @param ruleInfo    The Transaction Amount.
     *  @param payment The paymentInfo CTSPaymentDetailUpdate.
     *  @param bill        The bill CTSBill.
     *  @param user        The user CTSUser.
     *  @param requestType The requestType DPRequestType.
     *  @param extraParams The extraParams NSDictionary.
     *  @param callback    The callback ASPerformDynamicPricingCallback.
     */
-(void)requestPerformDynamicPricingRule:(CTSRuleInfo *)ruleInfo
                            paymentInfo:(CTSPaymentDetailUpdate *)payment
                                   bill:(CTSBill *)bill
                                   user:(CTSUser *)user
                                   type:(DPRequestType)requestType
                            extraParams:(NSDictionary *)extraParams
                      completionHandler:(ASPerformDynamicPricingCallback)callback __attribute__((deprecated("Please use requestSimpliPay:andParentViewController:completionHandler: instead")));
    
    
    /**
     *   requestPerformDynamicPricingRule.
     *
     *  @param ruleInfo    The Transaction Amount.
     *  @param payment The paymentInfo CTSPaymentDetailUpdate.
     *  @param billUrl     The billUrl NSString.
     *  @param user        The user CTSUser.
     *  @param extraParams The extraParams NSDictionary.
     *  @param callback    The callback ASPerformDynamicPricingCallback.
     */
-(void)requestPerformDynamicPricingRule:(CTSRuleInfo *)ruleInfo
                            paymentInfo:(CTSPaymentDetailUpdate *)payment
                                billUrl:(NSString *)billUrl
                                   user:(CTSUser *)user
                            extraParams:(NSDictionary *)extraParams
                      completionHandler:(ASPerformDynamicPricingCallback)callback __attribute__((deprecated("Please use requestSimpliPay:andParentViewController:completionHandler: instead")));
    
    /**
     *   requestPerformDynamicPricingRule.
     *
     *  @param ruleInfo    The Transaction Amount.
     *  @param payment The paymentInfo CTSPaymentDetailUpdate.
     *  @param bill        The bill CTSBill.
     *  @param user        The user CTSUser.
     *  @param extraParams The extraParams NSDictionary.
     *  @param callback    The callback ASPerformDynamicPricingCallback.
     */
- (void)requestPerformDynamicPricingRule:(CTSRuleInfo *)ruleInfo
                             paymentInfo:(CTSPaymentDetailUpdate *)payment
                                    bill:(CTSBill *)bill
                                    user:(CTSUser *)user
                             extraParams:(NSDictionary *)extraParams
                       completionHandler:(ASPerformDynamicPricingCallback)callback DEPRECATED_ATTRIBUTE;
    
    // for lazy pay only - moto call
    
    /**
     *   requestChargePayment.
     *
     *  @param paymentInfo The paymentInfo CTSPaymentDetailUpdate.
     *  @param contactInfo The contactInfo CTSContactUpdate.
     *  @param userAddress The userAddress CTSUserAddress.
     *  @param bill        The bill CTSBill.
     *  @param returnURL   The returnURL NSString.
     *  @param custParams  The custParams NSDictionary.
     *  @param controller  The controller UIViewController.
     *  @param callback    The callback ASCitruspayCallback.
     */
- (void)requestChargePayment:(CTSPaymentDetailUpdate *)paymentInfo
                 withContact:(CTSContactUpdate *)contactInfo
                 withAddress:(CTSUserAddress *)userAddress
                        bill:(CTSBill *)bill
                setReturnURL:(NSString *)returnURL
                customParams:(NSDictionary *)custParams
        returnViewController:(UIViewController *)controller
       withCompletionHandler:(ASCitruspayCallback)callback;
    /**
     ***************************************************************************************************************
     DEPRECATED END
     ***************************************************************************************************************
     */
    
    
    /**
     ***************************************************************************************************************
     INTERNAL USAGE METHODS
     ***************************************************************************************************************
     */
    
    /**
     *   configureReqPayment.
     *
     *  @param paymentInfo       The paymentInfo CTSPaymentDetailUpdate.
     *  @param contact           The contact CTSContactUpdate.
     *  @param address           The address CTSUserAddress.
     *  @param amount            The amount NSString.
     *  @param returnUrl         The returnUrl NSString.
     *  @param notifyUrl         The notifyUrl NSString.
     *  @param signatureArg      The signatureArg NSString.
     *  @param txnId             The txnId NSString.
     *  @param merchantAccessKey The merchantAccessKey NSString.
     *  @param custParams        The custParams NSDictionary.
     *  @param origin            The origin NSString.
     *
     *  @return The CTSPaymentRequest Object.
     */
- (CTSPaymentRequest*)configureReqPayment:(CTSPaymentDetailUpdate*)paymentInfo
                                  contact:(CTSContactUpdate*)contact
                                  address:(CTSUserAddress*)address
                                   amount:(NSString*)amount
                                returnUrl:(NSString*)returnUrl
                                notifyUrl:(NSString*)notifyUrl
                                signature:(NSString*)signatureArg
                                    txnId:(NSString*)txnId
                           merchantAccess:(NSString *)merchantAccessKey
                           withCustParams:(NSDictionary *)custParams
                                   origin:(NSString *)origin;
    
    /**
     *   displayOverlay.
     *
     *  @param overlay The overlay HVDOverlay.
     *
     *  @return The HVDOverlay Object.
     */
-(HVDOverlay *)displayOverlay:(HVDOverlay *)overlay;
    
    /**
     *   cvvEncrypt.
     *
     *  @param response The response CTSCitrusCashRes.
     *  @param error    The error AmoNSErrorunt.
     */
-(void)cvvEncrypt:(CTSCitrusCashRes *)response error:(NSError *)error;
    
@end
