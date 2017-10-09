//
//  CTSMasterLinkRes.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 25/02/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSProfileContactNewRes.h"
#import "CTSCitrusLinkRes.h"
#import "CTSResponse.h"
@interface CTSMasterLinkRes : NSObject
@property(strong)NSString *userMessage;
@property(strong)CTSProfileContactNewRes *user;
@property(assign)CitrusSiginType siginType;

-(instancetype)initWithResponse:(CTSResponse *)response;

@end
