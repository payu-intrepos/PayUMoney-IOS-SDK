//
//  OauthStatus.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 14/08/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OauthStatus : NSObject
@property(strong) NSString* oauthToken;
@property(strong) NSError* error;

@end
