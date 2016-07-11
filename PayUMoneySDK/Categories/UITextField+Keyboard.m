//
//  UITextField+Keyboard.m
//  PayU SDK
//
//  Created by Honey Lakhani on 10/9/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import "UITextField+Keyboard.h"


@implementation UITextField (Keyboard)
CGFloat distance;
-(CGFloat)checkForKeyboard : (CGFloat)yPos  withTextFieldHeight : (CGFloat)height  withNotification : (NSNotification *)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat scrheight = [UIScreen mainScreen].bounds.size.height;
CGFloat originKeyboard = scrheight - kbSize.size.height;
   
//    if (yPos + height >= kbSize.origin.y  - kbSize.size.height) {
        if (yPos + height >=  originKeyboard ) {

      //return yPos + height - (kbSize.origin.y - kbSize.size.height);
        return yPos + height - originKeyboard;
    }
    return 0.0f;
}
-(void)checkForKeyboardwithTextField  :(UITextField *)activeField withView : (UIView *)view withNotification:  (NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //NSLog(@"%@",info);
    //271 is height and 414 is width of keyboard
    //NSLog(@"%f and %f",keyboardSize.height,keyboardSize.width);
    
    
    //    UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height , 0.0);
    //    self.scrollView.contentInset = insets;
    //    self.scrollView.scrollIndicatorInsets = insets;
    CGRect aRect = view.frame;
    //NSLog(@"arect ---> %f",aRect.size.height);
    aRect.size.height += view.frame.origin.y;
    aRect.size.height = aRect.size.height - keyboardSize.height ;
    if(!CGRectContainsPoint(aRect, CGPointMake(activeField.frame.origin.x, activeField.frame.origin.y + activeField.frame.size.height + view.frame.origin.y)))
    {
        //NSLog(@"inside if");
        distance = aRect.size.height - activeField.frame.origin.y ;
        [self animateTextField:activeField up:YES :distance : view];
        // [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}
-(void)checkForKeyboardwithTextFieldForSuperView  :(UITextField *)activeField withView : (UIView *)view withNotification:  (NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    //NSLog(@"%@",info);
    //271 is height and 414 is width of keyboard
    //NSLog(@"%f and %f",keyboardSize.size.height,keyboardSize.size.width);
    
    
    //    UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height , 0.0);
    //    self.scrollView.contentInset = insets;
    //    self.scrollView.scrollIndicatorInsets = insets;
  CGRect aRect = CGRectMake(view.frame.origin.x, view.superview.frame.origin.y + view.frame.origin.y, view.frame.size.width, view.superview.frame.size.height);
   // CGRect aRect = view.superview.bounds;
   // aRect.size.height = view.frame.size.height + view.superview.frame.origin.y + view.frame.origin.y;
    //NSLog(@"arect ---> %f",aRect.size.height);
    aRect.size.height = aRect.size.height - keyboardSize.size.height ;
    CGPoint textFieldOrigin = CGPointMake(activeField.frame.origin.x, activeField.frame.origin.y + view.frame.origin.y + view.superview.frame.origin.y + activeField.frame.size.height );
//    if(CGRectContainsPoint(aRect, CGPointMake(keyboardSize.origin.x, keyboardSize.origin.y - keyboardSize.size.height)))
//    {
       // aRect.size.height = aRect.size.height - (
    if(!CGRectContainsPoint(aRect, textFieldOrigin))
    {
        //NSLog(@"inside if");
        distance = aRect.size.height - textFieldOrigin.y + 64;
        [self animateTextField:activeField up:NO :distance : view];
        // [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
  //  }
}
- (void)keyboardHideWithTextField:(UITextField *)activeField withNotification:(NSNotification *)notification withView : (UIView *)view
{
    [self animateTextField:activeField up:YES :distance : view];
   
    distance = 0;
    
}
- (void) animateTextField: (UITextField*) textField up: (BOOL) up : (CGFloat)movementDistance : (UIView *)view
{
    //const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
   view.frame = CGRectOffset(view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)keyboardHideWithTextFieldwithView:(UITextField *)activeField withNotification:(NSNotification *)notification withView : (UIView *)view
{
    [self animateTextField:activeField up:NO :distance : view];
    
    distance = 0;
    

}
-(void)checkForKeyboardForSavedCardwithTextField  :(UITextField *)activeField withView : (UIView *)view withNotification:  (NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //NSLog(@"%@",info);
    //271 is height and 414 is width of keyboard
    //NSLog(@"%f and %f",keyboardSize.height,keyboardSize.width);
    
    
    //    UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height , 0.0);
    //    self.scrollView.contentInset = insets;
    //    self.scrollView.scrollIndicatorInsets = insets;
    CGRect aRect = view.superview.frame;
    //NSLog(@"arect ---> %f",aRect.size.height);
  //aRect.size.height += view.frame.origin.y;
    aRect.size.height = aRect.size.height - keyboardSize.height ;
   // if(activeField.frame.origin.y + activeField.frame.size.height + view.frame.origin.y >= keyboardSize.height)
    if (!CGRectContainsPoint(aRect, CGPointMake(activeField.frame.origin.x, activeField.frame.origin.y + view.frame.origin.y + activeField.frame.size.height + 20)))
    {
        
    

        //NSLog(@"inside if");
        //distance = aRect.size.height - activeField.frame.origin.y ;
        distance =  keyboardSize.height -  (activeField.frame.origin.y + activeField.frame.size.height + view.frame.origin.y);
        [self animateTextField:activeField up:YES :distance : view];
        // [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}
@end
