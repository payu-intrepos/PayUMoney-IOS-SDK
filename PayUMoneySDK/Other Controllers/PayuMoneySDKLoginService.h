//
//  LoginService.h
//  PayU SDK
//
//  Created by Honey Lakhani on 10/26/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LoginServiceDelegate <NSObject>
@optional
-(void)sendingResponseBack : (NSString *)msg;
-(void)sendingMerchantParams : (NSArray *)merchantParamsArr;
@end
@interface PayuMoneySDKLoginService : NSObject < SendingResponseDelegate>
+(BOOL)checkInKeychain;
-(void)hitLoginParamsApi;
-(void)hitLoginApi : (NSString *)email : (NSString *)password;
@property NSString *str;
@property id<LoginServiceDelegate> delegate;
@end
