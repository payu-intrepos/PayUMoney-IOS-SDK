//
//  Luhn.h
//  payuSDK
//
//  Created by Honey Lakhani on 8/21/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Luhn : NSObject
+(BOOL)validate : (NSString *)number;
@end
