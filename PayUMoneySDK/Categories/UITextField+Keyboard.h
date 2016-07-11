//
//  UITextField+Keyboard.h
//  PayU SDK
//
//  Created by Honey Lakhani on 10/9/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Keyboard)<UITextFieldDelegate>
-(CGFloat)checkForKeyboard : (CGFloat)yPos withTextFieldHeight : (CGFloat)height  withNotification : (NSNotification *)aNotification;
-(void)checkForKeyboardwithTextField:(UITextField *)activeField withView : (UIView *)view withNotification:  (NSNotification *)notification;
- (void)keyboardHideWithTextField:(UITextField *)activeField withNotification:(NSNotification *)notification withView : (UIView *)view;
-(void)checkForKeyboardwithTextFieldForSuperView  :(UITextField *)activeField withView : (UIView *)view withNotification:  (NSNotification *)notification;
-(void)keyboardHideWithTextFieldwithView:(UITextField *)activeField withNotification:(NSNotification *)notification withView : (UIView *)view;
-(void)checkForKeyboardForSavedCardwithTextField  :(UITextField *)activeField withView : (UIView *)view withNotification:  (NSNotification *)notification;

@end
