//
//  CTSPrepaidBill.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 03/03/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CTSAmount.h"

@interface CTSPrepaidBill : JSONModel
@property( strong) NSString *merchantTransactionId;
@property( strong) NSString *merchant;
@property( strong) NSString *customer;
@property( strong) NSString *description;
@property( strong) NSString *signature;
@property( strong) NSString *merchantAccessKey;
@property( strong) NSString *returnUrl;
@property( strong) NSString *notifyUrl;
@property( strong) CTSAmount *amount;

@end
