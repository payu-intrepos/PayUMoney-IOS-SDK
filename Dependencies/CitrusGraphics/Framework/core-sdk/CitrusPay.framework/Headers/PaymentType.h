//
//  PaymentType.h
//  CitrusPay
//
//  Created by Mukesh Patil on 8/3/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTSPaymentOptions.h"

#import "CTSRuleInfo.h"
#import "CTSContactUpdate.h"
#import "CTSUserAddress.h"

/**
 *   PaymentType Class.
 */
@interface PaymentType : NSObject
/**
 *   The PaymentType class' amount object.
 */
@property (strong) NSString * amount;
/**
 *   The PaymentType class' URLOrCTSBill object.
 */
@property (strong) id URLOrCTSBill;
/**
 *   The PaymentType class' paymentOption object.
 */
@property (strong) CTSPaymentOptions <Optional> * paymentOption;
/**
 *   The PaymentType class' useMVC object.
 */
@property (assign) BOOL useMVC;
/**
 *   The PaymentType class' useCash object.
 */
@property (assign) BOOL useCash;
/**
 *   The PaymentType class' useDynamicPrice object.
 */
@property (assign) BOOL useDynamicPrice;
/**
*   The PaymentType class' ruleInfo object.
*/
@property (strong) CTSRuleInfo <Optional> * ruleInfo;
/**
 *   The PaymentType class' contactInfo object.
 */
@property (strong) CTSContactUpdate <Optional> * contactInfo;
/**
 *   The PaymentType class' addressInfo object.
 */
@property (strong) CTSUserAddress <Optional> * addressInfo;
/**
 *   The PaymentType class' extraParams object.
 */
@property (strong) NSDictionary <Optional> * extraParams;

//load money
/**
 *   The PaymentType class' returnURL object.
 */
@property (strong) NSString <Optional> * returnURL;
/**
 *   The PaymentType class' customParams object.
 */
@property (strong) NSDictionary <Optional> * customParams;


/**
 *   MVCPayment - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billUrl     The Bill Generator URL.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)mvcPayment:(NSString *)amount
                    billUrl:(NSString *)billUrl
                    contact:(CTSContactUpdate <Optional> *)userContact
                    address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The MVCPayment - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billObject  The CTSBill Object.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)mvcPayment:(NSString *)amount
                 billObject:(CTSBill *)billObject
                    contact:(CTSContactUpdate <Optional> *)userContact
                    address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The CitrusCashPayment - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billUrl     The Bill Generator URL.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)citrusCashPayment:(NSString *)amount
                           billUrl:(NSString *)billUrl
                           contact:(CTSContactUpdate <Optional> *)userContact
                           address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The CitrusCashPayment - Through Single Payment Interface
 *
 *  @param amount      The Transaction Amount.
 *  @param billObject  The CTSBill Object.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)citrusCashPayment:(NSString *)amount
                        billObject:(CTSBill *)billObject
                           contact:(CTSContactUpdate <Optional> *)userContact
                           address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The PGPayment - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billUrl     The Bill Generator URL.
 *  @param paymentOption The Payment Details.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)PGPayment:(NSString *)amount
                   billUrl:(NSString *)billUrl
             paymentOption:(CTSPaymentOptions *)paymentOption
                   contact:(CTSContactUpdate <Optional> *)userContact
                   address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The PGPayment - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billObject  The CTSBill Object.
 *  @param paymentOption The Payment Details.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)PGPayment:(NSString *)amount
                billObject:(CTSBill *)billObject
             paymentOption:(CTSPaymentOptions *)paymentOption
                   contact:(CTSContactUpdate <Optional> *)userContact
                   address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The PerformDynamicPricing - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billUrl     The Bill Generator URL.
 *  @param paymentOption The Payment Details.
 *  @param ruleInfo      The RuleInfo For Dynamic Pricing.
 *  @param extraParams   The ExtraParams.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)performDynamicPricing:(NSString *)amount
                               billUrl:(NSString *)billUrl
                         paymentOption:(CTSPaymentOptions *)paymentOption
                              ruleInfo:(CTSRuleInfo *)ruleInfo
                           extraParams:(NSDictionary <Optional> *)extraParams
                               contact:(CTSContactUpdate <Optional> *)userContact
                               address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The PerformDynamicPricing - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billObject  The CTSBill Object.
 *  @param paymentOption The Payment Details.
 *  @param ruleInfo      The RuleInfo For Dynamic Pricing.
 *  @param extraParams   The ExtraParams.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)performDynamicPricing:(NSString *)amount
                            billObject:(CTSBill *)billObject
                         paymentOption:(CTSPaymentOptions *)paymentOption
                              ruleInfo:(CTSRuleInfo *)ruleInfo
                           extraParams:(NSDictionary <Optional> *)extraParams
                               contact:(CTSContactUpdate <Optional> *)userContact
                               address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The SplitPayment - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billUrl     The Bill Generator URL.
 *  @param useMVC      The BOOL Object.
 *  @param useCash     The BOOL Object.
 *  @param paymentOption The Payment Details.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)splitPayment:(NSString *)amount
                      billUrl:(NSString *)billUrl
                       useMVC:(BOOL)useMVC
                      useCash:(BOOL)useCash
                paymentOption:(CTSPaymentOptions <Optional> *)paymentOption
                      contact:(CTSContactUpdate <Optional> *)userContact
                      address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The SplitPayment - Through Single Payment Interface.
 *
 *  @param amount      The Transaction Amount.
 *  @param billObject  The CTSBill Object.
 *  @param useMVC      The BOOL Object.
 *  @param useCash     The BOOL Object.
 *  @param paymentOption The Payment Details.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)splitPayment:(NSString *)amount
                   billObject:(CTSBill *)billObject
                       useMVC:(BOOL)useMVC
                      useCash:(BOOL)useCash
                paymentOption:(CTSPaymentOptions <Optional> *)paymentOption
                      contact:(CTSContactUpdate <Optional> *)userContact
                      address:(CTSUserAddress <Optional> *)userAddress;

/**
 *   The Load Money - (Single Payment Interface) into Citruspay account.
 *
 *  @param amount      The Transaction Amount.
 *  @param returnUrl     The Return URL.
 *  @param paymentOption The Payment Details.
 *  @param customParams  The CustomParams.
 *  @param userContact The User Contact.
 *  @param userAddress The User Address.
 *
 *  @return The PaymentType Object.
 */
+ (PaymentType *)loadMoney:(NSString *)amount
                 returnUrl:(NSString *)returnUrl
             paymentOption:(CTSPaymentOptions *)paymentOption
              customParams:(NSDictionary <Optional> *)customParams
                   contact:(CTSContactUpdate <Optional> *)userContact
                   address:(CTSUserAddress <Optional> *)userAddress;
@end