//
//  CTSLoadAndPayRes.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 09/02/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSAutoLoadSubResp.h"
#import "CitrusCashRes.h"
@interface CTSLoadAndPayRes : NSObject

@property(strong,atomic)CTSAutoLoadSubResp *autoLoadResp;
@property(strong,atomic)CTSCitrusCashRes *loadMoneyResponse;

@end
