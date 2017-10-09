//
//  CTSResponse.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 21/05/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSResponse : JSONModel
@property(strong)NSString *responseCode;
@property(strong)NSString *responseMessage;
@property(strong)NSDictionary *responseData;

-(BOOL)isError;
-(int)errorCode;
-(int)apiResponseCode;
@end
