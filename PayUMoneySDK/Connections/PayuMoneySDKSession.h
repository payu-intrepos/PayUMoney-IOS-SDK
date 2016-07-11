//
//  Session.h
//  payuSDK
//
//  Created by Honey Lakhani on 7/23/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SendingResponseDelegate <NSObject>
@optional
-(void)sendResponse : (NSDictionary *)responseDict tag: (SDK_REQUEST_TYPE)tag error : (NSError *)err;
@end

@interface PayuMoneySDKSession : NSObject

+(PayuMoneySDKSession *)sharedSession;

@property (nonatomic,strong) id<SendingResponseDelegate> delegate;

-(void)startPaymentProcess  :(NSDictionary *)params;

-(void)createPayment;
-(void)fetchMerchantParams : (NSString *)merchantId;
-(void)fetchResponsefrom : (NSString *)strURL isPost : (BOOL)type body : (NSString *)strBody tag : (SDK_REQUEST_TYPE)tag isAccessTokenRequired : (BOOL)tokenRequired;
-(void)sendToPayUWithWallet : (NSDictionary *)details : (NSString *)mode : (NSDictionary *)cardData : (double)cashBack : (double)vault : (NSDictionary *)coupon : (double)convenienceCharges;
-(void)fetchPaymentStatus : (NSString *)paymentID;
-(void)enableOneclickTransaction : (NSString *)enable;
@end
