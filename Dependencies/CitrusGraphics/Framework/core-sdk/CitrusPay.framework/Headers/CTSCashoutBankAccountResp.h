//
//  CTSCashoutBankAccountResp.h
//  CTS iOS Sdk
//
//  Created by Mukesh Patil on 22/05/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CTSCashoutBankAccount.h"

@interface CTSCashoutBankAccountResp : JSONModel
@property(strong) NSString<Optional>* type;
@property(strong) NSString<Optional>* currency;
@property(strong) CTSCashoutBankAccount<Optional>* cashoutAccount;
@end