//
//  CTSDyPPaymentInfo.h
//  CTS iOS Sdk
//
//  Created by Yadnesh on 7/27/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#define NETBANKING_MODE @"NET_BANKING"
#define CREDIT_CARD_MODE @"CREDIT_CARD"
#define DEBIT_CARD_MODE @"DEBIT_CARD"
#define CITRUS_WALLET @"PREPAID_CARD"
#define OPTION_SAVED_MODE @"CITRUS_WALLET"



/**
 Dynamic pricing payment info
 Class is used to select the dynamic pricng payment type
 */
@interface CTSDyPPaymentInfo : JSONModel
@property(nonatomic,strong)NSString<Optional>* cardNo,*cardType,*issuerId,*paymentMode,*paymentToken;



- (instancetype)initNetbankMode;
- (instancetype)initCreditCardMode;
- (instancetype)initDebitCardMode;
- (instancetype)initCitrusWalletMode;
- (instancetype)initSavedOptionMode;
@end
