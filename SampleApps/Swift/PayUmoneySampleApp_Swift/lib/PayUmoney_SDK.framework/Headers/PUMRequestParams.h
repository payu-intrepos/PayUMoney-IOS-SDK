//
//  RequestParams.h
//  payuSDK
//
//  Created by Honey Lakhani on 8/12/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUMConstants.h"



@protocol TransactionCompeltionDelegate <NSObject>

@required;

/*!
 * Transaction Compeleted Successfully. Check Payment details in response. error shows any error
if api failed.
 */
-(void)transactionCompletedWithResponse:(NSDictionary*)response
                       errorDescription:(NSError* )error;

/*!
 * Transaction failure occured. Check Payment details in response. error shows any error
 if api failed.
 */
-(void)transactinFailedWithResponse:(NSDictionary* )response
                   errorDescription:(NSError* )error;

-(void)transactinExpiredWithResponse: (NSString *)msg;
/*!
 * Transaction cancelled by user.
 */
-(void)transactinCanceledByUser;

@end

@interface PUMRequestParams : NSObject

//For production, set ENVIRONMENT_PRODUCTION, for testing, set ENVIRONMENT_TEST
@property (nonatomic, assign) PUMEnvironment environment;
@property (nonatomic, weak) id delegate;

@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *logo_url;
@property (nonatomic,strong) NSString *firstname;
@property (nonatomic,strong) NSString *productinfo;
@property (nonatomic,strong) NSString *txnid;
@property (nonatomic,strong) NSString *merchantid;
@property (nonatomic,strong) NSString *merchant_display_name;
@property (nonatomic,strong) NSString *surl;
@property (nonatomic,strong) NSString *furl;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *payment_id;
@property (nonatomic,strong) NSString *payment_id_wallet;
@property (nonatomic,strong) NSString *public_key;

@property double total_amount_need_to_pay;
@property (nonatomic,strong) NSString *hashValue;
@property (nonatomic,strong) NSString *udf1,*udf2,*udf3,*udf4,*udf5,*udf6,*udf7,*udf8,*udf9,*udf10;
@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSMutableDictionary *response;
@property (nonatomic,strong) NSMutableDictionary *emiBanksDetails;
@property (nonatomic,strong) NSMutableDictionary *userConfigDTO;
@property (nonatomic,strong) NSMutableArray *responseNetBankingDetails;
@property (nonatomic,strong) NSMutableArray *userSaveCards;
@property (nonatomic,strong) NSArray *availableCreditCards;
@property (nonatomic,strong) NSArray *availableDebitCards;

@property(nonatomic) BOOL merchantTypeWalletOnly;
@property(nonatomic) BOOL isWalletEnabled;
@property(nonatomic) BOOL isLoadWalletEnabled;
@property(nonatomic) BOOL isMerchantIsHighRisk;
@property(nonatomic,strong) NSString *cardMerchantParam;

+(PUMRequestParams *)sharedParams;
+(void) resetPUMRequestParamsSharedInstance;

@end
