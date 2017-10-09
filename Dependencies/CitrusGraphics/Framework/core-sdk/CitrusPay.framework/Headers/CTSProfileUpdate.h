//
//  CTSProfileUpdate.h
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 10/16/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSProfileUpdate : JSONModel

@property (strong) NSString <Optional> *firstName, *lastName, *email, *mobile;

@end
