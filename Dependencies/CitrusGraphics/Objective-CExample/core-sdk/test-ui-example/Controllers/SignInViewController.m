//
//  SignInViewController.m
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import "SignInViewController.h"
#import "HomeViewController.h"

@interface SignInViewController (){
    
    NSString *currentUser;

}

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationItem setHidesBackButton:YES];
    // Added right Bar button
    
    
    self.signinButton.layer.cornerRadius = 4;
    self.setPasswordButton.layer.cornerRadius = 4;
    self.indicatorView.hidden = TRUE;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    UIButton * otpButton = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0, 75, self.otpTextField.frame.size.height)];
    [otpButton addTarget:self action:@selector(resendOTPAction:)
     forControlEvents:UIControlEventTouchDown];
    otpButton.layer.cornerRadius = 4;
    otpButton.backgroundColor = [UIColor orangeColor];
    otpButton.titleLabel.font = [UIFont fontWithName:@"Verdana" size:11.0f];
    [otpButton setTitle:@"Resend OTP" forState:UIControlStateNormal];
    self.otpTextField.rightViewMode = UITextFieldViewModeAlways;
    self.otpTextField.rightView = otpButton;
    
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.userNameTextField.text = self.userName;
    self.mobileTextField.text = self.mobileNumber;
    self.messageLabel.text = self.messageString;
    
    self.otpTextField.text = @"";
    self.passwordTextField.text = @"";
    
    self.passwordView.hidden = FALSE;
    self.orTextLabel.hidden = FALSE;
    self.setPasswordButton.hidden = TRUE;
    switch (self.signinType) {
            
        case CitrusSiginTypeMOtpOrPassword:
        {
            self.otpTextField.placeholder = @"Mobile OTP";
            
            // Show Mobile otp and password sign in screen
        }
            break;
        case CitrusSiginTypeMOtp:
        {
            self.setPasswordButton.hidden = FALSE;
            self.orTextLabel.hidden = TRUE;
            self.passwordView.hidden = TRUE;
            self.otpTextField.placeholder = @"Mobile OTP";
            
        }
            // Show Mobile otp sign in screen
            break;
//        case CitrusSiginTypeEOtpOrPassword:
//        {
//            self.otpTextField.placeholder = @"Email OTP";
//        }
//            // Show Email otp and password sign in screen
//            break;
//        case CitrusSiginTypeEOtp:
//        {
//            self.passwordView.hidden = TRUE;
//            self.orTextLabel.hidden = TRUE;
//            self.otpTextField.placeholder = @"Email OTP";
//            
//        }
            // Show Email otp sign in screen
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

#pragma mark - Action Methods


//New Implementation

-(IBAction)signin{
    
    [self.view endEditing:YES];
    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];
    
    NSString *passwordString;
    PasswordType passwordType=-1;
    
    if (self.otpTextField.text.length>0) {
        passwordType = PasswordTypeOtp;
        passwordString = self.otpTextField.text;
    }
    else if (self.passwordTextField.text.length>0) {
        passwordType = PasswordTypePassword;
        passwordString = self.passwordTextField.text;
    }
    
    if (self.otpTextField.text.length==0 && self.passwordTextField.text.length==0) {
        [UIUtility toastMessageOnScreen:@"Please enter otp or password"];
        [self.indicatorView stopAnimating];
        self.indicatorView.hidden = TRUE;
    }
    else{
        
        [[CTSAuthLayer fetchSharedAuthLayer] requestMasterLinkSignInWithPassword:passwordString passwordType:passwordType completionHandler:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorView stopAnimating];
                self.indicatorView.hidden = TRUE;
            });
            if (error) {
                [UIUtility toastMessageOnScreen:[error localizedDescription]];
            }
            else{
                
                [CTSOauthManager readPasswordSigninOuthData];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
                }];
                
            }
        }];
        
        
        
        
        
//        if (self.signinType == CitrusSiginTypeMOtp && [[CTSAuthLayer fetchSharedAuthLayer] isUserSignedIn]) {
//            [[CTSAuthLayer fetchSharedAuthLayer] requestMasterLinkSignInWithPassword:passwordString passwordType:passwordType completionHandler:^(NSError *error) {
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.indicatorView stopAnimating];
//                    self.indicatorView.hidden = TRUE;
//                });
//                if (error) {
//                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
//                }
//                else {
//                    [CTSOauthManager readPasswordSigninOuthData];
//                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
//                    }];
//                }
//            }];
//        }
//        else {
//            NSLog(@"passwordString %@", passwordString);
//            NSLog(@"passwordType %u", passwordType);
//            
//            [[CTSAuthLayer fetchSharedAuthLayer] requestMasterLinkSignInWithPassword:passwordString passwordType:passwordType completionHandler:^(NSError *error) {
//                
//                if (error) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.indicatorView stopAnimating];
//                        self.indicatorView.hidden = TRUE;
//                    });
//
//                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
//                }
//                else {
//                    if (self.signinType == CitrusSiginTypeMOtpOrPassword || self.signinType == CitrusSiginTypeMOtp) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.indicatorView stopAnimating];
//                            self.indicatorView.hidden = TRUE;
//                        });
//
//                        [CTSOauthManager readPasswordSigninOuthData];
//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
//                        }];
//                    }
//                    else {
//                        [[CTSAuthLayer fetchSharedAuthLayer] requestMasterLink:self.userNameTextField.text  mobile:self.mobileTextField.text scope:self.scopeType completionHandler:^(CTSMasterLinkRes *linkResponse, NSError *error) {
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [self.indicatorView stopAnimating];
//                                self.indicatorView.hidden = TRUE;
//                            });
//                            if (error) {
//                                [UIUtility toastMessageOnScreen:[error localizedDescription]];
//                            }
//                            else{
//                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                                    self.userName = self.userNameTextField.text;
//                                    self.mobileNumber = self.mobileTextField.text;
//                                    self.signinType = CitrusSiginTypeMOtp;
//                                    self.messageString = @"Mobile verify code also sent. Verify And Signin";
//                                    [self viewWillAppear:YES];
//                                }];
//                            }
//                        }];
//                    }
//                }
//            }];
//        }

        
        
//        if (self.signinType == CitrusSiginTypeMOtp && [[CTSAuthLayer fetchSharedAuthLayer] isUserSignedIn]) {
//            [[CTSAuthLayer fetchSharedAuthLayer] requestCitrusLinkSignInWithPassoword:passwordString passwordType:passwordType completionHandler:^(NSError *error) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.indicatorView stopAnimating];
//                    self.indicatorView.hidden = TRUE;
//                });
//                if (error) {
//                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
//                }
//                else {
//                    [CTSOauthManager readPasswordSigninOuthData];
//                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
//                    }];
//                }
//            }];
//        }
//        else {
//            NSLog(@"passwordString %@", passwordString);
//            NSLog(@"passwordType %u", passwordType);
//            
//            [[CTSAuthLayer fetchSharedAuthLayer] requestCitrusLinkSignInWithPassoword:passwordString passwordType:passwordType completionHandler:^(NSError *error) {
//                if (error) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.indicatorView stopAnimating];
//                        self.indicatorView.hidden = TRUE;
//                    });
//
//                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
//                }
//                else {
//                    if (self.signinType == CitrusSiginTypeMOtpOrPassword || self.signinType == CitrusSiginTypeMOtp) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.indicatorView stopAnimating];
//                            self.indicatorView.hidden = TRUE;
//                        });
//
//                        [CTSOauthManager readPasswordSigninOuthData];
//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
//                        }];
//                    }
//                    else {
//                        
//                        [[CTSAuthLayer fetchSharedAuthLayer] requestCitrusLink:self.userNameTextField.text mobile:self.mobileTextField.text completion:^(CTSCitrusLinkRes *linkResponse, NSError *error) {
//                            
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [self.indicatorView stopAnimating];
//                                self.indicatorView.hidden = TRUE;
//                            });
//                            if (error) {
//                                [UIUtility toastMessageOnScreen:[error localizedDescription]];
//                            }
//                            else{
//                                
//                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                                    self.userName = self.userNameTextField.text;
//                                    self.mobileNumber = self.mobileTextField.text;
//                                    self.signinType = linkResponse.siginType;
//                                    self.messageString = linkResponse.userMessage;
//                                    [self viewWillAppear:YES];
//                                }];
//                            }
//                            
//                        }];
//
//                    }
//                }
//            }];
//        }

        
        
//        if (self.signinType == CitrusSiginTypeMOtp && [[CTSAuthLayer fetchSharedAuthLayer] isUserSignedIn]) {
//            [[CTSAuthLayer fetchSharedAuthLayer] requestMobileVerificationWithCode:passwordString completionHandler:^(BOOL isVerified, NSError *error) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.indicatorView stopAnimating];
//                    self.indicatorView.hidden = TRUE;
//                });
//                if (error) {
//                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
//                }
//                else {
//                    [CTSOauthManager readPasswordSigninOuthData];
//                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
//                    }];
//                }
//            }];
//        }
//        else {
//            NSLog(@"passwordString %@", passwordString);
//            NSLog(@"passwordType %u", passwordType);
//            
//            [[CTSAuthLayer fetchSharedAuthLayer] requestCitrusLinkSignInWithPassoword:passwordString passwordType:passwordType completionHandler:^(NSError *error) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.indicatorView stopAnimating];
//                    self.indicatorView.hidden = TRUE;
//                });
//                if (error) {
//                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
//                }
//                else {
//                    if (self.signinType == CitrusSiginTypeMOtpOrPassword || self.signinType == CitrusSiginTypeMOtp) {
//                        [CTSOauthManager readPasswordSigninOuthData];
//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
//                        }];
//                    }
//                    else {
//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            
//                            self.userName = self.userNameTextField.text;
//                            self.mobileNumber = self.mobileTextField.text;
//                            self.signinType = CitrusSiginTypeMOtp;
//                            self.messageString = @"Mobile verify code also sent. Verify And Signin";
//                            
//                            [self viewWillAppear:YES];
//                        }];
//                    }
//                }
//            }];
//        }
        
}
}


-(IBAction)resendOTPAction:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];
    
    sender.userInteractionEnabled = FALSE;
    
    [[CTSAuthLayer fetchSharedAuthLayer] requestResendOtp:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
            sender.userInteractionEnabled = TRUE;
        });
        if (error) {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
        else{
            [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"OTP sent"]];
        }
    }];

}

-(IBAction)forgotPassword:(id)sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Forgot Password?" message:@"Please enter your email address." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
        alert.tag = 1001;
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField * alertTextField = [alert textFieldAtIndex:0];
        alertTextField.keyboardType = UIKeyboardTypeEmailAddress;
        alertTextField.placeholder = @"Enter Email";
        [alert show];
    });
}

- (void)resignKeyboard:(UITapGestureRecognizer *)sender{
    
     [self.view endEditing:YES];
}

-(IBAction)setPasswordForMobile:(id)sender{

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Set Password?" message:@"Please enter new password." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
    alert.tag = 1002;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeEmailAddress;
    alertTextField.placeholder = @"Enter Password";
    [alert show];
}


#pragma mark - StoryBoard Delegate Methods
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"HomeScreenIdentifier"]) {
//        HomeViewController *viewController = (HomeViewController *)segue.destinationViewController;
//        viewController.userName = currentUser;
    }
    
}

#pragma mark - AlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
        });
    if (buttonIndex==1 && alertView.tag==1001) {
        self.indicatorView.hidden = FALSE;
        [self.indicatorView startAnimating];

        UITextField * alertTextField = [alertView textFieldAtIndex:0];

        [[CTSAuthLayer fetchSharedAuthLayer] requestResetPassword:alertTextField.text completionHandler:^(NSError *error) {
            LogTrace(@"error %d",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorView stopAnimating];
                self.indicatorView.hidden = TRUE;
            });

            NSString *message;
            if(error){
                message = [error localizedDescription];
            }
            else {
                message = @"Password Reset Link Sent to Your Email Id";
            }
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:nil
                                                  message:message
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Ok", @"Ok action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                       }];
            [alertController addAction:okAction];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }];

    }
    else if (buttonIndex==1 && alertView.tag==1002) {
        
        UITextField * alertTextField = [alertView textFieldAtIndex:0];
        
        [[CTSAuthLayer fetchSharedAuthLayer] requestSetPassowordMobileAccount:alertTextField.text completionHandler:^(NSError *error){
            
            [self.view endEditing:YES];
            if (error) {
                [UIUtility toastMessageOnScreen:[error localizedDescription]];
            }
            else{
                [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Password set succesfully"]];
            }
            
        }];
    }
    
}

#pragma mark - TextView Delegate Methods
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.userNameTextField) {
        if (textField.text.length==0) {
            [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Email Id field should not be empty."]];
        }
        else if (![CTSUtility validateEmail:textField.text]) {
            [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Email Id is not valid."]];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int length = (int)[currentString length];
    if (length > 4) {
        return NO;
    }
    return YES;
}

#pragma mark - Dealloc Methods
- (void) dealloc{
    
    self.userNameTextField = nil;
    self.passwordTextField = nil;
    self.signinButton = nil;
    self.indicatorView = nil;
}

@end
