//
//  SubcriptionRes.h
//  RestFulltester
/// Users/yadnesh
//  Created by Yadnesh Wankhede on 14/05/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//
//{"access_token":"ec92161e-2660-4c22-b23a-dd1a475cc20c","token_type":"bearer","expires_in":8043960,"scope":"subscription"}

#import <JSONModel/JSONModel.h>

@interface CTSOauthTokenRes : JSONModel
@property(strong) NSString* accessToken;
@property(strong) NSString<Optional>* refreshToken;
@property(strong) NSString* tokenType;
@property(assign) long tokenExpiryTime;
@property(strong) NSString* scope;
@property(strong) NSDate<Ignore>* tokenSaveDate;
@property(strong) NSString<Optional>*clientType;
@property(strong) NSString<Optional>*outerToken;
@property(strong) CTSOauthTokenRes<Optional>* prepaidPayToken;
@end