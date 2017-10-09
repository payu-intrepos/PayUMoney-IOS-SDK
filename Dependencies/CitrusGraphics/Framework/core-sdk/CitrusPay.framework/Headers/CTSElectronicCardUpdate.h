//
//  CTSElectronicCard.h
//  RestFulltester
//
//  Created by Yadnesh Wankhede on 19/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTSObject.h"

@interface CTSElectronicCardUpdate : CTSObject
@property(strong, readonly) NSString* type;
@property(strong) NSString* name, *ownerName, *number, *expiryDate,
    *scheme, *cvv, *token, *bankcode;

/**
 *  to init credit card always use this method
 *
 *  @return initiated object with predifined properties for credti card
 */
- (instancetype)initCreditCard;

/**
 *  to init debit card always use this method
 *
 *  @return initiated object with predifined properties for debit card
 */
- (instancetype)initDebitCard;

/**
 *  validates whether card proper number,expierydate format
 *
 *  @return error code
 */
@end
