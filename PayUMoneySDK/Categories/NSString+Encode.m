//
//  NSString+Encode.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/10/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "NSString+Encode.h"

@implementation NSString (Encode)
- (NSString *)encodeString:(NSStringEncoding)encoding
{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                                                NULL, (CFStringRef)@";/?:@&=$+{}<>,",
                                                                CFStringConvertNSStringEncodingToEncoding(encoding)));
}
@end
