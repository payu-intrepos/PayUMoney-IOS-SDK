//
//  CTSPaymentToken.h
//  RestFulltester
//
//  Created by Raji Nair on 24/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class CTSPaymentMode;


/**
 Internal dta structure for the payment request
 */
@interface CTSPaymentToken : JSONModel
@property(strong) CTSPaymentMode<Optional>* paymentMode;
@property(strong) NSString<Optional>* type;
@property(strong) NSString<Optional>* id;
@property(strong) NSString<Optional>* cvv;

@end
