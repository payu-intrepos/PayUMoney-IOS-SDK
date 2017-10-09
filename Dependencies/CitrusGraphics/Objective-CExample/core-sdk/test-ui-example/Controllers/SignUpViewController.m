//
//  SignUpViewController.m
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import "SignUpViewController.h"
#import "ResetPasswordViewController.h"
#import "SignInViewController.h"

@interface SignUpViewController (){

    CitrusSiginType signInType;
    NSString *responseMessage;
    CTSWalletScope scopeType;
}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indicatorView.hidden = TRUE;
    self.signupButton.layer.cornerRadius = 4;

    
    [self.limitedScopeRadioButton setBackgroundImage:[UIImage imageNamed:@"RadioButton-Unselected.png"] forState:UIControlStateNormal];
    [self.limitedScopeRadioButton setBackgroundImage:[UIImage imageNamed:@"RadioButton-Selected.png"] forState:UIControlStateSelected];
    [self.limitedScopeRadioButton addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.fullScopeRadioButton setBackgroundImage:[UIImage imageNamed:@"RadioButton-Unselected.png"] forState:UIControlStateNormal];
    [self.fullScopeRadioButton setBackgroundImage:[UIImage imageNamed:@"RadioButton-Selected.png"] forState:UIControlStateSelected];
    [self.fullScopeRadioButton addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
/*    switch (self.loginType) {
        case 0:{
            self.userNameTextField.hidden = FALSE;
            self.mobileTextField.hidden = FALSE;
        }
            break;
        case 1:{
            self.userNameTextField.hidden = TRUE;
            self.mobileTextField.hidden = FALSE;
        }
            break;
        case 2:{
            self.userNameTextField.hidden = FALSE;
            self.mobileTextField.hidden = FALSE;
        }
            break;
            
        default:
            break;
    }
*/
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    if ([CTSAuthLayer fetchSharedAuthLayer].requestSignInOauthToken.length != 0) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:nil];
            return;
        }];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

-(void)radiobuttonSelected:(id)sender{
    switch ([sender tag]) {
            
        case 1000:
            if([self.limitedScopeRadioButton isSelected]==YES)
            {
                [self.limitedScopeRadioButton setSelected:NO];
                [self.fullScopeRadioButton setSelected:YES];
                scopeType = CTSWalletScopeFull;
            }
            else{
                [self.limitedScopeRadioButton setSelected:YES];
                [self.fullScopeRadioButton setSelected:NO];
                scopeType = CTSWalletScopeLimited;
            }
            break;
            
        case 1001:
            if([self.fullScopeRadioButton isSelected]==YES)
            {
                [self.fullScopeRadioButton setSelected:NO];
                [self.limitedScopeRadioButton setSelected:YES];
                scopeType = CTSWalletScopeLimited;
            }
            else{
                [self.fullScopeRadioButton setSelected:YES];
                [self.limitedScopeRadioButton setSelected:NO];
                scopeType = CTSWalletScopeFull;
            }
            
            break;
        default:
            break;
    }
    
}


// New Link User method - which is OTP based

-(IBAction)linkUser:(UIButton *)button{
    
        [self.view endEditing:YES];
        self.indicatorView.hidden = FALSE;
        [self.indicatorView startAnimating];

    [[CTSAuthLayer fetchSharedAuthLayer] requestMasterLink:self.userNameTextField.text  mobile:self.mobileTextField.text scope:scopeType completionHandler:^(CTSMasterLinkRes *linkResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
           self.indicatorView.hidden = TRUE;
       });
        if (error) {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
       }
       else{
           
           [UIUtility toastMessageOnScreen:linkResponse.userMessage];

          if (linkResponse.siginType == CitrusSiginTypeLimited) {
              dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
                });
            }
            else{
                
               signInType = linkResponse.siginType;
                responseMessage = linkResponse.userMessage;
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"SignInScreenIdentifier" sender:self];
                });
            }
           
        }
    }];
    
    
//    [[CTSAuthLayer fetchSharedAuthLayer] requestCitrusLink:self.userNameTextField.text mobile:self.mobileTextField.text completion:^(CTSCitrusLinkRes *linkResponse, NSError *error) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.indicatorView stopAnimating];
//            self.indicatorView.hidden = TRUE;
//        });
//        if (error) {
//            [UIUtility toastMessageOnScreen:[error localizedDescription]];
//        }
//        else{
//            
//            [UIUtility toastMessageOnScreen:linkResponse.userMessage];
//            
//            if (linkResponse.siginType == CitrusSiginTypeLimited) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
//                });
//            }
//            else{
//                signInType = linkResponse.siginType;
//                responseMessage = linkResponse.userMessage;
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self performSegueWithIdentifier:@"SignInScreenIdentifier" sender:self];
//                });
//            }
//            
//        }
//
//    }];
   
 /*
    CTSUser *user = [[CTSUser alloc] init];
    user.email = self.userNameTextField.text;
    user.mobile = self.mobileTextField.text;
    [[CTSAuthLayer fetchSharedAuthLayer] requestMasterLink:self.userNameTextField.text  mobile:self.mobileTextField.text scope:scopeType completionHandler:^(CTSMasterLinkRes *linkResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
        });
        if (error) {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIUtility toastMessageOnScreen:linkResponse.userMessage];
                [self performSegueWithIdentifier:@"HomeScreenIdentifier" sender:self];
            });
        }
    }];
  */
  
}

-(void)didCompleteUserFind:(CTSMasterLinkRes *)linkResponse error:(NSError *)error{
    LogTrace(@"complted the link proccess");


}








- (void)resignKeyboard:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
}

#pragma mark - StoryView Delegate Methods

// ++++++ this delegate method will used for new link user api +++++++
 
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"SignInScreenIdentifier"]){
        
        SignInViewController *viewController = (SignInViewController *)segue.destinationViewController;
        viewController.userName = self.userNameTextField.text;
        viewController.mobileNumber = self.mobileTextField.text;
        viewController.signinType = signInType;
        viewController.scopeType = scopeType;
        viewController.messageString = responseMessage;
    }
    
}



#pragma mark - Dealloc Methods
- (void) dealloc{
    self.userNameTextField = nil;
    self.mobileTextField = nil;
    self.signupButton = nil;
    self.indicatorView = nil;
}


@end
