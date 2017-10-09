//
//  CTSNewContactProfile.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "CTSNewResponseDataProfile.h"

@interface CTSNewContactProfile : JSONModel
@property(strong)NSString<Optional>* responseCode;
@property(strong)NSString<Optional>* responseMessage;
@property(strong)CTSNewResponseDataProfile <Optional>* responseData;
@end
