//
//  CTSDPResponse.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 10/20/15.
//  Copyright © 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSDPResponse : JSONModel
@property(assign)int resultCode;
@property(strong)NSString<Optional> *resultMessage;
@property(strong)NSDictionary<Optional> *extraParams;
-(BOOL)isError;
@end
