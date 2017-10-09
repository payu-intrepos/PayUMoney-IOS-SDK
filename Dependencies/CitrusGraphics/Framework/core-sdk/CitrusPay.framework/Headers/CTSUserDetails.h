//
//  CTSUserDetails.h
//  RestFulltester
//
//  Created by Raji Nair on 24/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//


#import <JSONModel/JSONModel.h>

#import "CTSUserAddress.h"
#import "CTSContactUpdate.h"


/**
 Data Class for Userdetails
 */
@interface CTSUserDetails : JSONModel
@property(strong) NSString<Optional>* email;
@property(strong) NSString<Optional>* firstName;
@property(strong) NSString<Optional>* lastName;
@property(strong) NSString<Optional>* mobileNo;
@property(strong) CTSUserAddress<Optional>* address;



/**
 Initilizer

 @param contact ContactObject
 @param address Adress Object

 */
- (instancetype)initWith:(CTSContactUpdate*)contact
                 address:(CTSUserAddress*)address;

@end
