//
//  CashoutBankAccount.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 24/04/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>


/**
 Bank data for cashout from the wallet
 */
@interface CTSCashoutBankAccount : JSONModel
@property(strong) NSString<Optional>* owner;
@property(strong) NSString<Optional>* branch;
@property(strong) NSString<Optional>* number;
@end
