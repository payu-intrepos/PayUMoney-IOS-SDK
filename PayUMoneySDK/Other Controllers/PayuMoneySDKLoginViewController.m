//
//  LoginViewController.m
//  PayU SDK
//
//  Created by Honey Lakhani on 9/28/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import "PayuMoneySDKLoginViewController.h"
#import "PayuMoneySDKValidations.h"
#import "UITextField+Keyboard.h"
#import "PayuMoneySDKLoginView.h"
#import "PayuMoneySDKSignUpView.h"
#import "PayuMoneySDKPaymentViewController.h"
@interface PayuMoneySDKLoginViewController ()<SendingResponseDelegate,SignUpDelegate,LoginViewDelegate>
{
    PayuMoneySDKSession *session;
    UITextField *activeField;
    CGFloat distance;
    PayuMoneySDKLoginView *loginView;
    PayuMoneySDKSignUpView *signUpView;
   
}
@end

@implementation PayuMoneySDKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClicked:)];
    self.navigationItem.leftBarButtonItem = leftBtn;

}
-(void)backBtnClicked : (UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    signUpView.hidden = YES;
    loginView.hidden = NO;
    loginView.emailTextField.text = @"";
    [loginView.loginTableView reloadData];
    [loginView registerForKeyboardNotifications];
   // NSArray *viewControllers = [self.navigationController viewControllers];
   
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (loginView) {
        [loginView removeNotifications];
    }
    if (signUpView) {
        [signUpView removeNotifications];
    }
}
-(void)dealloc
{

}
- (IBAction)loginBtnClicked:(UIButton *)sender {
    if (signUpView) {
            signUpView.hidden = YES;
        [signUpView removeNotifications];
    }


        loginView = [[PayuMoneySDKLoginView alloc]initWithFrame:CGRectMake(0, 0, self.loginOrSignUpView.frame.size.width, self.loginOrSignUpView.frame.size.height) withArray:self.merchantParamsArr];
       

  
    loginView.logindelegate = self;
    [loginView registerForKeyboardNotifications];
    [self.loginOrSignUpView addSubview:loginView];
    }

- (IBAction)signUpBtnClicked:(UIButton *)sender {
    if (loginView) {
        
    
    loginView.hidden = YES;
        [loginView removeNotifications];
    }
    
     signUpView = [[PayuMoneySDKSignUpView alloc]initWithFrame:CGRectMake(0, 0, self.loginOrSignUpView.frame.size.width, self.loginOrSignUpView.frame.size.height)];
    signUpView.delegate = self;
    [signUpView registerForKeyboardNotifications];
    [self.loginOrSignUpView addSubview:signUpView];
}
-(void)sendingDataBackToController
{
    [self navigatingToPaymentController];
}
-(void)goBackToController:(NSString *)msg
{
    if ([msg isEqual:@"success"]) {
       
        [self navigatingToPaymentController];
    }
    else
    ALERT(@"Login Failed", @"Please try again");
}
-(void)navigatingToPaymentController
{
    UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
    PayuMoneySDKPaymentViewController *paymentVC = [sdkSB instantiateViewControllerWithIdentifier:@"payVC"];
   
    [self.navigationController pushViewController:paymentVC animated:YES];
}

@end
