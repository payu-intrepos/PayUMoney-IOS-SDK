//
//  PayUmoneySDKPayment.m
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 7/11/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import "PayUmoneySDKPayment.h"
#import "PayuMoneySDKRequestParams.h"
#import "PayuMoneySDKLoginViewController.h"
#import "PayuMoneySDKPaymentViewController.h"
#import "PayuMoneySDKAppConstant.h"

@implementation PayUmoneySDKPayment
@synthesize callBackController;

-(void)startSDK : (PayUConfigBO *)config withCallBack:(id)delegate
{
    if(config)
    {
        self.callBackController = delegate;
        [PayuMoneySDKRequestParams initWithDict : config];
        PayuMoneySDKRequestParams *paramsBO  = [PayuMoneySDKRequestParams sharedInstance];
        if (![paramsBO.hashValue isEqualToString:@""]) {
            [self checkForLogin];
        }
        else
        {
            ALERT(SDK_APP_TITLE, @"Hash not calculated");
        }
        
    }
    else{
        ALERT(SDK_APP_TITLE, @"Unable to proceed");
    }
}
-(void)checkForLogin
{
    PayuMoneySDKLoginService *loginService = [[PayuMoneySDKLoginService alloc]init];
    loginService.delegate = self;
    if (![[SDK_APP_CONSTANT.keyChain objectForKey:(__bridge id)kSecAttrAccount] isEqual:@""]&& ![[SDK_APP_CONSTANT.keyChain objectForKey:(__bridge id)kSecValueData] isEqual:@""])
    {
        if (SDK_APP_CONSTANT.isServerReachable) {
            [PayuMoneySDKAppConstant showLoader_OnView:self.callBackController.view];
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
        [PayuMoneySDKAppConstant showLoader_OnView:self.callBackController.view];
        [loginService hitLoginParamsApi];
    }
}

-(void)sendingMerchantParams:(NSArray *)merchantArr
{
    [PayuMoneySDKAppConstant hideLoader];
    UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PayuMoneySDKLoginViewController *loginVC = [sdkSB instantiateViewControllerWithIdentifier:@"loginVC"];
    
    loginVC.merchantParamsArr = merchantArr;
    [self.callBackController.navigationController pushViewController:loginVC animated:YES];
}
-(void)sendingResponseBack : (NSString *)msg
{
    [PayuMoneySDKAppConstant hideLoader];
    if ([msg isEqual:@"success"]) {
        UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
        PayuMoneySDKPaymentViewController *paymentVC = [sdkSB instantiateViewControllerWithIdentifier:@"payVC"];
        
        [self.callBackController.navigationController pushViewController:paymentVC animated:YES];
    }
    else
    {
        
        
        [SDK_APP_CONSTANT.keyChain resetKeychainItem];
        UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        PayuMoneySDKLoginViewController *loginVC = [sdkSB instantiateViewControllerWithIdentifier:@"loginVC"];
        [self.callBackController.navigationController pushViewController:loginVC animated:YES];
        
    }
}


@end
