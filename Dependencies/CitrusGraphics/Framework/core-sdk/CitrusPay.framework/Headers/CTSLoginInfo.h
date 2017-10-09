//
//  CTSLoginInfo.h
//  CitrusPay
//
//  Created by Yadnesh Wankhede on 24/05/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTSAuthLayerConstants.h"
@interface CTSLoginInfo : NSObject
@property(strong,atomic)NSString *password;
@property(atomic)PasswordType passwordType;

- (instancetype)initForPassword:(NSString *)password;
- (instancetype)initForOTP:(NSString *)otp;
@end
