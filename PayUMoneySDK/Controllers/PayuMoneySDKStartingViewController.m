//
//  PayuMoneySDKStartingViewController.m
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 7/7/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import "PayuMoneySDKStartingViewController.h"
#import "PayuMoneySDKRequestParams.h"
#import "PayuMoneySDKLoginService.h"
#import "PayuMoneySDKLoginViewController.h"
#import "PayuMoneySDKPaymentViewController.h"
@interface PayuMoneySDKStartingViewController ()<LoginServiceDelegate>

@end

@implementation PayuMoneySDKStartingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)startSDK : (NSDictionary *)dict
{
    if(dict)
    {
        [PayuMoneySDKRequestParams initWithDict : (NSDictionary *)dict];
        PayuMoneySDKRequestParams *paramsBO  = [PayuMoneySDKRequestParams sharedInstance];
        if (![paramsBO.hashValue isEqualToString:@""]) {
            [self checkForLogin];
        }
        else
        {
            ALERT(SDK_APP_TITLE, @"Hash not calculated");
        }
        
    }
}
-(void)checkForLogin
{
    PayuMoneySDKLoginService *loginService = [[PayuMoneySDKLoginService alloc]init];
    loginService.delegate = self;
    if (![[SDK_APP_CONSTANT.keyChain objectForKey:(__bridge id)kSecAttrAccount] isEqual:@""]&& ![[SDK_APP_CONSTANT.keyChain objectForKey:(__bridge id)kSecValueData] isEqual:@""])
    {
        if (SDK_APP_CONSTANT.isServerReachable) {
            [PayuMoneySDKAppConstant showLoader_OnView:self.view];
            loginService.str = @"fromViewController";
            [loginService hitLoginApi:[SDK_APP_CONSTANT.keyChain objectForKey:(__bridge id)kSecAttrAccount] :[SDK_APP_CONSTANT.keyChain objectForKey:(__bridge id)kSecValueData]];
            
        }
        else
        {
            ALERT(@"Internet not connected", @"Please connnect");
            return;
        }
    }
    else
    {
        [PayuMoneySDKAppConstant showLoader_OnView:self.view];
        [loginService hitLoginParamsApi];
    }
}

-(void)sendingMerchantParams:(NSArray *)merchantArr
{
    [PayuMoneySDKAppConstant hideLoader];
    UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PayuMoneySDKLoginViewController *loginVC = [sdkSB instantiateViewControllerWithIdentifier:@"loginVC"];
    
    loginVC.merchantParamsArr = merchantArr;
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)sendingResponseBack : (NSString *)msg
{
    [PayuMoneySDKAppConstant hideLoader];
    if ([msg isEqual:@"success"]) {
        UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
        PayuMoneySDKPaymentViewController *paymentVC = [sdkSB instantiateViewControllerWithIdentifier:@"payVC"];
        
        [self.navigationController pushViewController:paymentVC animated:YES];
    }
    else
    {
        
        
        [SDK_APP_CONSTANT.keyChain resetKeychainItem];
        UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        PayuMoneySDKLoginViewController *loginVC = [sdkSB instantiateViewControllerWithIdentifier:@"loginVC"];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
