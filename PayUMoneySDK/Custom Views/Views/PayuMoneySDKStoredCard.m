//
//  StoredCard.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/24/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKStoredCard.h"
@interface PayuMoneySDKStoredCard()<UITextFieldDelegate>

@end
@implementation PayuMoneySDKStoredCard

-(PayuMoneySDKStoredCard *)initWithFrame : (CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.storedCard = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKStoredCard" owner:self options:nil]firstObject];
        self.storedCard.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
       // [self.storedCard setBackgroundColor:[UIColor blackColor]];
        if(CGRectIsEmpty(frame))
        {
            self.bounds = self.storedCard.bounds;
        }
      //  self.cvvTextField.delegate = self;
       // [self registerForKeyboardNotifications];
        [self addSubview:self.storedCard];
    }
    return self;
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
//}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
////    if(self.storedCardDelegate != nil && [self.storedCardDelegate respondsToSelector:@selector(changeTableContentOffset)])
////    {
////        [self.storedCardDelegate changeTableContentOffset];
////    }
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification object:nil];
//    
//  
//}
//
////- (void)registerForKeyboardNotifications
////{
////    
////    [[NSNotificationCenter defaultCenter] addObserver:self
////                                             selector:@selector(keyboardWasShown:)
////                                                 name:UIKeyboardDidShowNotification object:nil];
////    
////    [[NSNotificationCenter defaultCenter] addObserver:self
////                                             selector:@selector(keyboardWillBeHidden:)
////                                                 name:UIKeyboardWillHideNotification object:nil];
////    
////}
//
//// Called when the UIKeyboardDidShowNotification is sent.
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    NSDictionary* info = [aNotification userInfo];
//    CGRect kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    
////    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
////    scrollView.contentInset = contentInsets;
////    scrollView.scrollIndicatorInsets = contentInsets;
//    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your app might not need or want this behavior.
////    CGRect aRect = self.storedCard.frame;
////    aRect.origin.y = self.j;
////    aRect.size.height += self.j;
////    if(aRect.size.height >= kbSize.size.height)
////    {
////    aRect.size.height -= kbSize.size.height;
//    CGPoint pt = self.cvvTextField.frame.origin;
//    //NSLog(@"==================== %ld",(long)self.j);
//    pt.y += self.j;
//    if (pt.y + self.cvvTextField.frame.size.height >= kbSize.origin.y  - kbSize.size.height) {
//        if(self.storedCardDelegate != nil && [self.storedCardDelegate respondsToSelector:@selector(changeTableContentOffset)])
//        {
//            [self.storedCardDelegate changeTableContentOffset];
//        }
//   }
//   // }
//    
//}
//
//// Called when the UIKeyboardWillHideNotification is sent
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification
//{
////    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
////    scrollView.contentInset = contentInsets;
////    scrollView.scrollIndicatorInsets = contentInsets;
//}
@end
