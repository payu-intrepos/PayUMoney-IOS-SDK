//
//  Validations.m
//  payuSDK
//
//  Created by Honey Lakhani on 10/6/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKValidations.h"

@implementation PayuMoneySDKValidations
+(BOOL)validateAmount : (double)amt
{
    
    return YES;
}

+(BOOL)matchRegex : (NSString *)regex  : (NSString *)text
{
    NSError *err = NULL;
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&err];
    
    NSRange rangeOfFirstMatch = [exp rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        if(rangeOfFirstMatch.length == text.length)
            return YES;
    }
    return NO;
    
}
@end
