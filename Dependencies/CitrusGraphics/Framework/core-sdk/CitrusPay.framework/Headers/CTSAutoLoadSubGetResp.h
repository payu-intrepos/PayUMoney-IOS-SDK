//
//  CTSAutoLoadSubGetResp.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 11/19/15.
//  Copyright © 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CTSAutoLoadSubResp.h"

@interface CTSAutoLoadSubGetResp : JSONModel
@property (nonatomic,strong)NSMutableArray <CTSAutoLoadSubResp> *subcriptions;
@end
