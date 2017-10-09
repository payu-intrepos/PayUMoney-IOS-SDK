//
//  CTSContactUpdate.h
//  RestFulltester
//
//  Created by Yadnesh Wankhede on 12/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class CTSProfileContactRes;



/**
 CTSContactUpdate
 
 Contact update for user
 */
@interface CTSContactUpdate : JSONModel
@property(  strong) NSString* firstName, *lastName;
@property(  strong) NSString* type;
@property(  strong) NSString<Optional>* email;
@property(  strong) NSString<Optional>* mobile;
@property(  strong) NSString<Optional>* password;


/**
 User defaults substitution
 */
-(void)substituteDefaults;


/**
 initializer

 @return Instance
 */
-(instancetype)initDefault;


/**
 Substitute the default

 @param profile profile of the user
 */
-(void)substituteFromProfile:(CTSProfileContactRes *)profile;
@end
