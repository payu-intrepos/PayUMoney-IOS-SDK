//
//  AutoloadViewController.m
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 2/9/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import "AutoloadViewController.h"
#import "MerchantConstants.h"
#import "HomeViewController.h"

@interface AutoloadViewController ()

@end

@implementation AutoloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indicatorView.hidden = TRUE;
    self.containerView.layer.cornerRadius = 4;
    self.authenticateButton.layer.cornerRadius = 4;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard:)];
    [self.view addGestureRecognizer:tapRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resignKeyboard:(UITapGestureRecognizer *)sender{
    
    [self.view endEditing:YES];
}

-(IBAction)createSubscription:(id)sender{

    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];

    CTSLoadMoney *loadMoney = [[CTSLoadMoney alloc ] init];
    loadMoney.paymentInfo = self.cardInfo;
    loadMoney.contactInfo = nil;
    loadMoney.userAddress = nil;
    loadMoney.amount = @"1";
    loadMoney.returnUrl = self.returnUrl;
    loadMoney.custParams = nil;
    loadMoney.controller = self;
    
    CTSAutoLoad *autoload = [[CTSAutoLoad alloc]init];
    autoload.autoLoadAmt = self.topupTextField.text;
    autoload.thresholdAmount = self.thresholTextField.text;
    
    [[CTSPaymentLayer fetchSharedPaymentLayer] requestLoadAndSubscribe:loadMoney autoLoad:autoload withCompletionHandler:^(CTSLoadAndPayRes *loadAndSubscribe, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
        });
        if(error == nil){
            LogTrace(@"loadAndSubscribe %@",loadAndSubscribe.autoLoadResp);
            LogTrace(@"loadAndSubscribe %@",loadAndSubscribe.loadMoneyResponse);
           dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[self toReadableString:loadAndSubscribe.autoLoadResp] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
                alertView.tag = 10001;
                [alertView show];
           });
        }
        else {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
    }];
}

-(NSString *)toReadableString:(CTSAutoLoadSubResp *)load{
    NSString *string = [NSString stringWithFormat:@"subscriptionId: %@ \nthresholdAmount: %@ \nloadAmount: %@ \nstatus: %@ \nexpiry: %@\nholder: %@",load.subscriptionId,load.thresholdAmount,load.loadAmount,load.status,load.expiry,load.holder];
    return string;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.view endEditing:YES];
    if (alertView.tag ==10001){
        HomeViewController *controller = (HomeViewController *)[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count-3)];
        [self.navigationController popToViewController:controller animated:YES];
    }
}
@end
