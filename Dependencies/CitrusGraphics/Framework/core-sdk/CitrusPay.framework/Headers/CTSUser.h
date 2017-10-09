//
//  CTSUser.h
//  CTS iOS Sdk
//
//  Created by Yadnesh on 9/1/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSUserAddress.h"
#import "CTSContactUpdate.h"




/**
 Data Class for User information
 */
@interface CTSUser : NSObject
@property (strong )NSString *firstName,*lastName, *email,*mobile;
@property (strong )CTSUserAddress * address;


/**
 convinience method to onvert data to CTSContactUpdate class object

 @return CTSContactUpdate object
 */
-(CTSContactUpdate *)contact;

@end
