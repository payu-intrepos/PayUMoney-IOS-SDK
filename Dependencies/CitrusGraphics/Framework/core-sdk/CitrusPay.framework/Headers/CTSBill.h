//
//  CTSBill.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 21/11/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "CTSAmount.h"

@interface CTSBill : JSONModel
@property(strong)NSString *merchantTxnId;
@property(strong)CTSAmount *amount;
@property(strong)NSString *requestSignature;
@property(strong)NSString *merchantAccessKey;
@property(strong)NSString <Optional>*returnUrl;
@property(strong)NSString <Optional>*notifyUrl;
@property(strong)NSString <Optional>*dpSignature;
@property(strong)NSDictionary <Optional>*customParameters;

@end
