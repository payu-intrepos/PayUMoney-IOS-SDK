//
//  ConfigBO.m
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 5/3/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import "ConfigBO.h"

@implementation ConfigBO
-(ConfigBO *)initWithResponse : (id)response
{
    if ([response isKindOfClass:[NSDictionary class]]) {
        self.authorizationSalt = [self checkNullValue:[response valueForKey:@"authorizationSalt"]];
        self.oneClick = [self checkNullValue:[response valueForKey:@"oneClick"]];
        self.oneTap = [self checkNullValue:[response valueForKey:@"oneTap"]];
        self.userId = [self checkNullValue:[response valueForKey:@"userId"]];
        self.userToken = [self checkNullValue:[response valueForKey:@"userToken"]];
    }
    return self;
}

-(NSString*)checkNullValue:(id)text
{
    NSString *parsedText = @"";
    if([text isKindOfClass:[NSString class]])
    {
        if([text isEqualToString:@"<null>"])
            parsedText = @"";
        else{
            parsedText = text;
        }
    }
    else if ([text isKindOfClass:[NSNumber class]]){
        parsedText = [text stringValue];
    }
    return parsedText;
}

@end
