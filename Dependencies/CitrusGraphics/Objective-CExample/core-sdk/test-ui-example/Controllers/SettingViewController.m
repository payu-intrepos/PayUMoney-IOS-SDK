//
//  SettingViewController.m
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 11/3/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actionButton.layer.cornerRadius = 4;
    self.indicatorView.hidden = TRUE;
    
    if ([self.title isEqualToString:@"Update Profile"]) {
        self.firstNameTextField.placeholder = @"First Name";
        self.lastNameTextField.placeholder = @"Last Name";
//        self.mobileTextField.placeholder = @"Mobile Number";
        [self.actionButton setTitle:@"Update Profile" forState:UIControlStateNormal];
        //self.mobileTextField.keyboardType = UIKeyboardTypePhonePad;
        self.mobileTextField.hidden = TRUE;
    }
    else if ([self.title isEqualToString:@"Change Password"]){
        self.firstNameTextField.placeholder = @"Old Password";
        self.lastNameTextField.placeholder = @"New Password";
       
        self.firstNameTextField.secureTextEntry = TRUE;
        self.lastNameTextField.secureTextEntry = TRUE;
        [self.actionButton setTitle:@"Change Password" forState:UIControlStateNormal];
//        self.firstNameTextField.text = self.userEmailId;
        self.mobileTextField.hidden = TRUE;
    
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapRecognizer];
    // Do any additional setup after loading the view.
}


- (IBAction)manageProfileAction:(UIButton *)sender{

    
    if ([self.title isEqualToString:@"Update Profile"]) {
        
        CTSProfileUpdate *profile = [CTSProfileUpdate new];
        profile.firstName = self.firstNameTextField.text;
        profile.lastName = self.lastNameTextField.text;
//        profile.mobile = self.mobileTextField.text;
        if ([self.firstNameTextField.text isEqualToString:@""] || [self.lastNameTextField.text isEqualToString:@""] ) {
            [UIUtility toastMessageOnScreen:@"All fields are mandatory"];
        }
        else{
            [self.indicatorView startAnimating];
            self.indicatorView.hidden = FALSE;

            [[CTSProfileLayer fetchSharedProfileLayer] requestUpdateProfileInformation:profile withCompletionHandler:^(NSError *error){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.indicatorView stopAnimating];
                    self.indicatorView.hidden = TRUE;
                });
                
                if (error) {
                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self resetUI];
                        [UIUtility toastMessageOnScreen:@"Profile successfully updated "];
                    });
                    
                }
            }];
        
        }
    }
    else if ([self.title isEqualToString:@"Change Password"]){
        
        if ([self.firstNameTextField.text isEqualToString:@""] || [self.lastNameTextField.text isEqualToString:@""] ) {
            [UIUtility toastMessageOnScreen:@"All fields are mandatory"];
        }
        else{
            [self.indicatorView startAnimating];
            self.indicatorView.hidden = FALSE;

            [[CTSAuthLayer fetchSharedAuthLayer] requestChangePasswordUserName:self.mobileTextField.text oldPassword:self.firstNameTextField.text newPassword:self.lastNameTextField.text completionHandler:^(NSString *responseString, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.indicatorView stopAnimating];
                    self.indicatorView.hidden = TRUE;
                });

                if (error) {
                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self resetUI];
                        [UIUtility toastMessageOnScreen:[[CTSUtility toDict:responseString] objectForKey:@"responseMessage"]];
                    });
                }
            }];
        }
    }

}

-(void)hideKeyboard:(id)sender{
    
    [self.view endEditing:YES];
    
}
#pragma mark - Reset UI Methods
- (void) resetUI{
    self.firstNameTextField.text = @"";
    self.lastNameTextField.text = @"";
    self.mobileTextField.text = @"";
}

@end
