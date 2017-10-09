//
//  CTSEotpVerSigninResp.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 11/5/15.
//  Copyright © 2015 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSOauthTokenRes.h"
#import "CTSProfileContactNewRes.h"
@interface CTSEotpVerSigninResp : JSONModel
@property(strong) CTSOauthTokenRes *oAuth2AccessToken;
@property(strong) CTSProfileContactNewRes *profileData;
@end
