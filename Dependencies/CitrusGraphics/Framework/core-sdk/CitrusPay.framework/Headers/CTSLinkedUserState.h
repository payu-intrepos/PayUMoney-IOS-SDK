//
//  CTSLinkedUserState.h
//  CitrusPay
//
//  Created by Yadnesh Wankhede on 23/06/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSAuthLayerConstants.h"
#import "CTSProfileContactNewRes.h"
@interface CTSLinkedUserState : NSObject
@property (strong)NSString *email,*mobile,*uuid,*firstName,*lastName;
@property CTSWalletScope loggedInScope;

- (instancetype)initLimited:(CTSProfileContactNewRes*)profileRes;
- (instancetype)initFull:(CTSProfileContactNewRes *)profileRes;
@end
