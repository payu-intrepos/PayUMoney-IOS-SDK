//
//  PUMCCDC.h
//  PayUmoney_SDK
//
//  Created by Umang Arya on 5/10/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUMCCDC : NSObject

@property (strong, nonatomic) NSString * cardNumber;
@property (strong, nonatomic) NSString * expiryMonth;
@property (strong, nonatomic) NSString * expiryYear;
@property (strong, nonatomic) NSString * cvv;

@property (strong, nonatomic) NSString * cardType;
@property (strong, nonatomic) NSString * pg;

@property BOOL validateDetails;

@property BOOL shouldSave;

@property (strong, nonatomic) NSString *countryCode;

@end
