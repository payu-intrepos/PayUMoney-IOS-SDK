//
//  CTSUserProfile.h
//  CitrusPay-iOS-SDK
//
//  Created by Vikas Singh on 23/10/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSUserProfile : JSONModel
@property (strong) NSString <Optional> * email, * mobile, * firstName, * lastName, * uuid;
@property (assign) int emailVerified;
@property (assign) NSNumber <Optional> * emailVerifiedDate;
@property (assign) int mobileVerified;
@property (assign) NSNumber <Optional> * mobileVerifiedDate;
@end
