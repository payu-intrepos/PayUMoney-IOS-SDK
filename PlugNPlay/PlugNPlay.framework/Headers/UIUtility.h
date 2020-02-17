//
//  UIUtility.h
//  SDKSandbox
//
//  Created by Mukesh Patil on 24/09/14.
//  Copyright (c) 2014 CitrusPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIUtility : NSObject

/**
 *  move and animate textField while tapping
 *
 *  @param textField for textField
 *  @param  up animate if YES
 *  @param toView move to UIView
 */
+ (void)animateTextField:(UITextField*)textField up:(BOOL)up toView:(UIView*)toView;


+(void)toastMessageOnScreen:(NSString *)string fromViewController:(UIViewController *)viewController;

@end
