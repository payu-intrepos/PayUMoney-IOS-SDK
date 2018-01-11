//
//  VerifyOTPVC.m
//  PayUMoneyExample
//
//  Created by Umang Arya on 11/21/17.
//  Copyright © 2017 PayU. All rights reserved.
//

#import "VerifyOTPVC.h"
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>
#import "iOSDefaultActivityIndicator.h"
#import "Constants.h"
#import "Utils.h"

@interface VerifyOTPVC ()
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *txtFldOTP;

@end

@implementation VerifyOTPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTappedSendOTP:(id)sender {
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    [[PayUMoneyCoreSDK sharedInstance] sendPaymentOTPforMobileOrEmail:[PUMHelperClass getUserNameFromFetchUserDataAPI] APIWithCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (error) {
            [Utils showMsgWithTitle:ERROR message:error.localizedDescription];
        }
        else{
            NSString *responseStr = [NSString stringWithFormat:@"OTP sent to - %@\n\nResponse of API - %@",[PUMHelperClass getUserNameFromFetchUserDataAPI],response];
            [Utils showMsgWithTitle:RESPONSE message:responseStr];
        }
    }];
}

- (IBAction)btnTappedVerifyOTP:(id)sender {
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    [[PayUMoneyCoreSDK sharedInstance] verifyOTPOrPassword:self.txtFldOTP.text forMobileOrEmail:[PUMHelperClass getUserNameFromFetchUserDataAPI] APIWithCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (error) {
            [Utils showMsgWithTitle:ERROR message:error.localizedDescription];
        }
        else{
            NSString *responseStr = [NSString stringWithFormat:@"OTP verfied for - %@\n\nResponse of API - %@",[PUMHelperClass getUserNameFromFetchUserDataAPI],response];
            [Utils showMsgWithTitle:RESPONSE message:responseStr];
        }
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
