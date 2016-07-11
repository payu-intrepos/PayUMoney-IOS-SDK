//
//  SetUpCardDetails.h
//  payuSDK
//
//  Created by Honey Lakhani on 8/21/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayuMoneySDKSetUpCardDetails : NSObject
+(NSString *)findIssuer : (NSString *)number : (NSString *)cardMode;
+(UIImage *)getCardDrawable : (NSString *)number;

@end
