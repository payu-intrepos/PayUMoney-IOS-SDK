//
//  UIUtility.h
//  SDKSandbox
//
//  Created by Mukesh Patil on 24/09/14.
//  Copyright (c) 2014 CitrusPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIUtility : NSObject <UITextFieldDelegate>
/**
 *  show alertView with activity
 *
 *  @param message alertView message
 *  @param activity show activity if YES
 */
+(void)didPresentLoadingAlertView:(NSString *)message withActivity:(BOOL)activity;

/**
 *  dismiss alertView with activity
 *
 *  @param activity shdismissow activity if YES
 */
+(void)dismissLoadingAlertView:(BOOL)activity;

/**
 *  dismiss alertView with error
 *
 *  @param error alertView error
 */
+ (void)didPresentErrorAlertView:(NSError*)error;

/**
 *  dismiss alertView with message
 *
 *  @param message alertView message
 */
+ (void)didPresentInfoAlertView:(NSString*)message;

/**
 *  move and animate textField while tapping
 *
 *  @param textField for textField
 *  @param  up animate if YES
 *  @param toView move to UIView
 */
+ (void)animateTextField:(UITextField*)textField up:(BOOL)up toView:(UIView*)toView;


+(void)toastMessageOnScreen:(NSString *)string;
@end
