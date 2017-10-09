//
//  CTSDyPValidateRuleReq.h
//  CTS iOS Sdk
//
//  Created by Yadnesh on 7/27/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CTSAmount.h"
#import "CTSDyPPaymentInfo.h"



/**
 Dynamic pricing Rule validate data
 */
@interface CTSDyPValidateRuleReq : JSONModel
@property(nonatomic,strong)NSString<Optional>* ruleName,*signature,*merchantTransactionId,*merchantAccessKey,*phone,*userType;
@property(nonatomic,strong)NSString<Optional> *email;
@property(nonatomic,strong)NSMutableDictionary<Optional> *extraParams;
@property(nonatomic,strong)CTSAmount<Optional> *originalAmount,*alteredAmount;
@property(nonatomic,strong)CTSDyPPaymentInfo* paymentInfo;

@end
