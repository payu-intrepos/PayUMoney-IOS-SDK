//
//  CTSSaveCardResponse.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 1/7/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSSaveCardResponse : JSONModel
@property (strong)NSString *fingerPrint;
@property (strong)NSString *token;

@end
