//
//  ResetPasswordViewController.m
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "SignInViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resetButton.layer.cornerRadius = 4;
    self.userNameTextField.text = self.userName;
    self.indicatorView.hidden = TRUE;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard:)];
    [self.view addGestureRecognizer:tapRecognizer];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods
-(IBAction)setPassword:(id)sender{
    
    [self.view endEditing:YES];
    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];
    
    [[CTSAuthLayer fetchSharedAuthLayer] requestSetPassword:self.resetTextField.text userName:self.userNameTextField.text completionHandler:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
        });
        if (error) {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
        else{
//            [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Password is now set"]];
            dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Password is successfully set" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
           
            [alert show];
            });
        }
    }];
    
}

#pragma mark - StoryView Delegate Methods
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
   if ([segue.identifier isEqualToString:@"SignInIdentifier"]){
        
        SignInViewController *viewController = (SignInViewController *)segue.destinationViewController;
        viewController.userName = self.userNameTextField.text;
    }
    
}

- (void)resignKeyboard:(UITapGestureRecognizer *)sender{
    
    [self.view endEditing:YES];
}

#pragma mark - AlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [self performSegueWithIdentifier:@"SignInIdentifier" sender:self];
        
    }
}


#pragma mark - Dealloc Methods
- (void) dealloc{
    
    self.userNameTextField = nil;
    self.resetTextField = nil;
    self.resetTextField = nil;
    self.indicatorView = nil;
}

@end
