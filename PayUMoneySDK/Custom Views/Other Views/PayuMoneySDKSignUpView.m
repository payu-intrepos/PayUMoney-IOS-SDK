//
//  SignUpView.m
//  PayU SDK
//
//  Created by Honey Lakhani on 10/14/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import "PayuMoneySDKSignUpView.h"
#import "PayuMoneySDKValidations.h"
#import "UITextField+Keyboard.h"
#import "PayuMoneySDKLoginService.h"
@interface PayuMoneySDKSignUpView()<UITextFieldDelegate,SendingResponseDelegate,LoginServiceDelegate>
{
//    Session *session
    UITextField *activeTextField;
    PayuMoneySDKLoginService *loginService;
}
@end
@implementation PayuMoneySDKSignUpView

-(PayuMoneySDKSignUpView *)initWithFrame : (CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.signUp = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKSignUpView" owner:self options:nil]firstObject];
        self.signUp.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        if (CGRectIsEmpty(frame)) {
            self.bounds = self.signUp.bounds;
        }

        [self addSubview:self.signUp];
               // [self registerForKeyboardNotifications];
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        self.phoneTextField.inputAccessoryView = numberToolbar;
    }
    return self;
}
-(void)cancelNumberPad{
    [self.phoneTextField resignFirstResponder];
    self.phoneTextField.text = @"";
}

-(void)doneWithNumberPad{
    
    [self.phoneTextField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  // [self.scrollView setContentOffset:CGPointZero
                             //animated:YES];

    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeTextField = textField;
   // [textField checkForKeyboardwithTextField:textField withView:self withNotification:<#(NSNotification *)#>]
}




-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTextField) {
        
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return (newString.length <= 10);
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    if (textField == self.emailTextField) {
//        if (![Validations matchRegex:EMAIL_REGEX :textField.text]) {
//            ALERT(@"invalid email", @"please enter valid email address");
//        }
//    }
//    if (textField == self.phoneTextField) {
//        if (![Validations matchRegex:PHONE_REGEX :textField.text]) {
//            ALERT(@"invalid no", @"please enter valid phone no");
//        }
//    }
//    if (textField == self.passwordTextField) {
//        if (![Validations matchRegex:PASSWORD_REGEX :textField.text]) {
//            ALERT(@"invalid password", @"Password should be minimum 6 character with atleast 1 letter and 1 number");
//        }
//    }
}
-(void)registerForKeyboardNotifications
{
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)keyboardShown : (NSNotification *)notification
{

    [activeTextField checkForKeyboardwithTextFieldForSuperView:activeTextField withView:self withNotification:notification];
}
-(void)keyboardHide : (NSNotification *)notification
{
    [activeTextField keyboardHideWithTextField:activeTextField withNotification:notification withView:self];
}
- (IBAction)signUpBtnClicked:(UIButton *)sender {
    if ([self.emailTextField hasText] && [self.phoneTextField hasText] && [self.passwordTextField hasText]) {
        if(![PayuMoneySDKValidations matchRegex:EMAIL_REGEX :self.emailTextField.text])
        {
            ALERT(@"Invalid Email", @"please enter valid email address");
        }
       else if(![PayuMoneySDKValidations matchRegex:PHONE_REGEX :self.phoneTextField.text])
       {
            ALERT(@"Invalid number", @"please enter valid phone number");
       }
       else if(![PayuMoneySDKValidations matchRegex:PASSWORD_REGEX :self.passwordTextField.text])
       {
            ALERT(@"Invalid password", @"please enter valid password");
       }
        else
        {
        PayuMoneySDKSession *session = [PayuMoneySDKSession sharedSession];
        session.delegate = self;
        [PayuMoneySDKAppConstant showLoader_OnView:self];
        [session fetchResponsefrom:Sign_Up_URL isPost:YES body:[PayuMoneySDKServiceParameters preparebodyForSignUp:self.emailTextField.text withPhone:self.phoneTextField.text withPassword:self.passwordTextField.text] tag:SDK_REQUEST_SIGNUP isAccessTokenRequired:NO];
        }
    }
    else
        ALERT(@"some field is missing", @"Please enter all the fields");
}
-(void)sendResponse:(NSDictionary *)object tag:(SDK_REQUEST_TYPE)tag error:(NSError *)err
{
    [PayuMoneySDKAppConstant hideLoader];
     if (tag == SDK_REQUEST_SIGNUP)
    {
        if ([[object valueForKey:@"status"]isEqualToNumber:[NSNumber numberWithInt:-1]] && [object valueForKey:@"msg"]) {
            ALERT([object valueForKey:@"msg"], @"try again");
        }
        else if([[object valueForKey:@"status"]isEqualToNumber:[NSNumber numberWithInt:1]])
        {
           loginService = [[PayuMoneySDKLoginService alloc]init];
            loginService.delegate = self;
            [loginService hitLoginApi:self.emailTextField.text :self.passwordTextField.text];
        }
        else
            ALERT(@"An error occurred while trying to sign you up",@"Please try again later");
    }
}
-(void)sendingResponseBack : (NSString *)msg
{
    loginService.delegate = nil;
    loginService = nil;

    if ([msg isEqualToString:@"success"]) {
        [SDK_APP_CONSTANT.keyChain setObject:self.emailTextField.text forKey:(__bridge id)kSecAttrAccount];
        [SDK_APP_CONSTANT.keyChain setObject:self.passwordTextField.text forKey:(__bridge id)kSecValueData];

                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(sendingDataBackToController)]) {
        
                        [self.delegate sendingDataBackToController];
                    }
        

    }
    else if ([msg isEqualToString:@"failure"])
    {
        ALERT(@"Signed up successfully", @"Please login");
    }
}
@end
