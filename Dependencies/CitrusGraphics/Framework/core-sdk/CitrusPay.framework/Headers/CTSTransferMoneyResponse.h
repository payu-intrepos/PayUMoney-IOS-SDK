//
//  CTSTransferMoneyResponse.h
//  CTS iOS Sdk
//
//  Created by Yadnesh on 8/6/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class CTSAmount;

@interface CTSTransferMoneyResponse : JSONModel
@property(strong,atomic)NSString<Optional>* type,*date,*operation,*status,*narrative,*reason,*ref;
@property(strong,atomic)CTSAmount<Optional>* amount,*balance;

@end
