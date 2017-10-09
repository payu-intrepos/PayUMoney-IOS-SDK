//
//  CTSCashoutToBankRes.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 24/04/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CTSAmount.h"


/**
 Cashout bank informations
 */
@interface CTSCashoutToBankRes : JSONModel
@property(strong) NSString<Optional>* id;
@property(strong) NSString<Optional>* cutsomer;
@property(strong) NSString<Optional>* merchant;
@property(strong) NSString<Optional>* type;
@property(strong) NSString<Optional>* date;
@property(strong) CTSAmount<Optional>* amount;
@property(strong) NSString<Optional>* status;
@property(strong) NSString<Optional>* reason;
@property(strong) CTSAmount<Optional>* balance;
@property(strong) NSString<Optional>* ref;


@end
