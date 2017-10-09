//
//  BaseViewController.h
//  CubeDemo
//
//  Created by Vikas Singh on 8/25/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantConstants.h"

#import <CitrusPay/CitrusPay.h>

@interface BaseViewController : UIViewController
@property (strong) CTSContactUpdate* contactInfo;
@property (strong) CTSUserAddress* addressInfo;
@property (strong) NSDictionary *customParams;
@property (strong) NSString *billUrl;
@property (strong) NSString *returnUrl;
- (void)changeEnvironment:(NSUInteger)newIndex;
@end
