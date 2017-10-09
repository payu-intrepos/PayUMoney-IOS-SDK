//
//  CTSUserAddress.h
//  RestFulltester
//
//  Created by Raji Nair on 24/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>



/**
 Data class for user's address
 */
@interface CTSUserAddress : JSONModel
@property(strong) NSString<Optional>* city;
@property(strong) NSString<Optional>* country;
@property(strong) NSString<Optional>* state;
@property(strong) NSString<Optional>* street1;
@property(strong) NSString<Optional>* street2;
@property(strong) NSString<Optional>* zip;
-(void)substituteDefaults;
-(instancetype)initDefault;
@end
