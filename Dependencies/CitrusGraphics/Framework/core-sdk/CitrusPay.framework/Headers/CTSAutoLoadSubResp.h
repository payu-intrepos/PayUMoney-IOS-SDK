//
//  CTSAutoLoadSubResp.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 11/19/15.
//  Copyright © 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CTSAutoLoadSubResp;
@interface CTSAutoLoadSubResp : JSONModel
/*{
 "subscriptionId": "string",
 "thresholdAmount": 0,
 "loadAmount": 0,
 "status": "string",
 "card": "string",
 "expiry": "string",
 "holder": "string"
 }*/

@property(strong) NSString<Optional> *subscriptionId;
@property(strong) NSString<Optional> *thresholdAmount;
@property(strong) NSString<Optional> *loadAmount;
@property(strong) NSString<Optional> *card;
@property(strong) NSString<Optional> *status;
@property(strong) NSString<Optional> *expiry;
@property(strong) NSString<Optional> *holder;
@end
