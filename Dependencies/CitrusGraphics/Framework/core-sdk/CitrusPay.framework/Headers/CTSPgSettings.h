//
//  CTSPgSettings.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 09/07/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSPgSettings : JSONModel
@property (strong) NSMutableArray* creditCard;
@property (strong) NSMutableArray* debitCard;
@property (strong) NSMutableArray* netBanking;
@property (assign) BOOL prepaid;
@property (assign) BOOL lazyPayEnabled;
@property (assign) BOOL mcpEnabled;
@end
