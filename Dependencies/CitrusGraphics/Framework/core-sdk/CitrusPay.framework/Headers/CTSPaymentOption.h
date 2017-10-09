//
//  CTSPaymentOption.h
//  RestFulltester
//
//  Created by Yadnesh Wankhede on 20/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "CTSError.h"
#import "CTSUtility.h"

@class CTSNetBankingUpdate, CTSElectronicCardUpdate, CTSTokenizedPayment, CTSPaymentToken;

typedef enum {
    MemberCard,
    MemberNetbank,
    TokenizedCard,
    TokenizedNetbank,
    CitrusPay,
    UndefinedPayment
} CTSPaymentType;

typedef enum {
    PGPayment,
    LoadMoneyPayment
} CTSPGType;
@protocol CTSPaymentOption;

@interface CTSPaymentOption : JSONModel
@property( strong) NSString<Optional>* type;
@property( strong) NSString<Optional>* name;
@property( strong) NSString<Optional>* owner;
@property( strong) NSString<Optional>* bank;
@property( strong) NSString<Optional>* number;
@property( strong) NSString<Optional>* expiryDate;
@property( strong) NSString<Optional>* scheme;
@property( strong) NSString<Optional>* token;
@property( strong) NSString<Optional>* mmid;
@property( strong) NSString<Optional>* impsRegisteredMobile;
@property( strong) NSString<Optional>* cvv;
@property( strong) NSString<Optional>* code;

-(instancetype)initCitrusPayWithEmail:(NSString *)email;
-(instancetype)initWithNetBanking:(CTSNetBankingUpdate*)bankDetails;
-(instancetype)initWithCard:(CTSElectronicCardUpdate*)eCard;
-(instancetype)initWithTokenized:(CTSTokenizedPayment*)tokenizedPayment;
-(CTSErrorCode)validate;
-(CTSPaymentType)fetchPaymentType;
-(CTSPaymentToken*)fetchPaymentToken;
-(BOOL)canDoOneTapPayment;
-(BOOL)isPaymentInstrumentAllowedFor:(CTSPGType)pgPaymentType;

@end
