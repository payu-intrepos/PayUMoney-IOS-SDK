//
//  CTSLoadAndSubscribe.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 09/02/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSPaymentDetailUpdate.h"
#import "CTSContactUpdate.h"
#import "CTSUserAddress.h"
#import "CTSPaymentOptions.h"


/**
 Load Money Data
 */
@interface CTSLoadMoney : NSObject
@property(strong,atomic)CTSPaymentOptions *paymentInfo;
@property(strong,atomic)CTSContactUpdate *contactInfo;
@property(strong,atomic)CTSUserAddress *userAddress;
@property(strong,atomic)NSString *amount;
@property(strong,atomic)NSString *returnUrl;
@property(strong,atomic)NSString *autoLoadAmt;
@property(strong,atomic)NSDictionary *custParams;
@property(strong,atomic)UIViewController *controller;

@end
