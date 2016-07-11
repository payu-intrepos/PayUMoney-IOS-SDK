//
//  ConfigBO.h
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 5/3/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigBO : NSObject
@property NSString *authorizationSalt;
@property NSString *oneClick;
@property NSString *oneTap;
@property NSString *userId;
@property NSString *userToken;
-(ConfigBO *)initWithResponse : (id)response;
@end
