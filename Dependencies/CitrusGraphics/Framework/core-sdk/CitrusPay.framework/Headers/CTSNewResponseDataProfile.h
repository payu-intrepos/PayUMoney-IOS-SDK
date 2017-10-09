//
//  CTSNewResponseDataProfile.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "CTSProfileContactNewRes.h"

@interface CTSNewResponseDataProfile : JSONModel
@property(strong)CTSProfileContactNewRes <Optional>* profileByEmail;
@property(strong)CTSProfileContactNewRes <Optional>* profileByMobile;
@end
