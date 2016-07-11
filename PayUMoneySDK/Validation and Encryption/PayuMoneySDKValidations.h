//
//  Validations.h
//  payuSDK
//
//  Created by Honey Lakhani on 10/6/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayuMoneySDKValidations : NSObject
+(BOOL)validateAmount : (double)amt;
+(BOOL)matchRegex : (NSString *)regex : (NSString *)number;
@end
