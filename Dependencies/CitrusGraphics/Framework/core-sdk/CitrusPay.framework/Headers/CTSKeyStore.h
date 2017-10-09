//
//  CTSKeyStore.h
//  CTS iOS Sdk
//
//  Created by Yadnesh on 8/26/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSKeyStore : NSObject
@property(strong)NSString *signinId,*signUpId,*signinSecret,*signUpSecret,*vanity;
@end
