

//
//  LoginService.m
//  PayU SDK
//
//  Created by Honey Lakhani on 10/26/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import "PayuMoneySDKLoginService.h"

@implementation PayuMoneySDKLoginService
PayuMoneySDKSession *ssession;
+(BOOL)checkInKeychain
{
    if ([SDK_APP_CONSTANT.keyChain objectForKey:(__bridge id)kSecAttrAccount] && [SDK_APP_CONSTANT.keyChain objectForKey:(__bridge id)kSecValueData]) {
        //[self hitLoginApi:[APP_DELEGATE.keyChain objectForKey:(__bridge id)kSecAttrAccount] :[APP_DELEGATE.keyChain objectForKey:(__bridge id)kSecValueData]];
        return YES;
    }
    else
    {
        return NO;
    }

}


-(void)hitLoginApi : (NSString *)email : (NSString *)password
{
    ssession = [PayuMoneySDKSession sharedSession];
    ssession.delegate = self;
    [ssession fetchResponsefrom:Login_URL isPost:YES body:[PayuMoneySDKServiceParameters preparePostBodyForLogin : email withPassword:password] tag:SDK_REQUEST_LOGIN isAccessTokenRequired:NO];
}

-(void)sendResponse:(NSDictionary *)responseDict tag:(SDK_REQUEST_TYPE)tag error:(NSError *)err
{
    ssession.delegate = nil;
    ssession = nil;
    [PayuMoneySDKAppConstant hideLoader];
    if (tag == SDK_REQUEST_PARAMS)
    {
        //  LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        NSArray *merchantParamsArr;
        if ([[responseDict valueForKey:@"status"]isEqual:[NSNumber numberWithLong:0]])
        {
            
            NSLog(@"%@",responseDict);
            NSArray *loginArr= [responseDict valueForKey:@"result"];
            NSString *gc, *otp;
            for (int i =0; i < loginArr.count; i++) {
                if([[[loginArr objectAtIndex:i]valueForKey:@"paramKey"] isEqual:MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT_VALUE])
                {
                    gc =[[loginArr objectAtIndex:i]valueForKey:@"paramValue"];
                }
                else if ([[[loginArr objectAtIndex:i]valueForKey:@"paramKey"] isEqual:OTP_LOGIN])
                {
                    otp = [[loginArr objectAtIndex:i]valueForKey:@"paramValue"];
                }
            }
            
            if ((gc != nil && ![gc isEqual: @""]) || (otp != nil && ![otp isEqual:@""])) {
                if ([gc isEqual:MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT]) {
                    merchantParamsArr = [NSArray arrayWithObjects:@"Guest Login",@"Login With Password", nil];
                }
                else if ([gc isEqual:MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT_ONLY])
                {
                    merchantParamsArr = [NSArray arrayWithObjects:@"Guest Login", nil];
                }
                else if ([otp isEqual:@"1"])
                {
                    merchantParamsArr = [NSArray arrayWithObjects:@"Login With OTP",@"Login With Password", nil];
                }
                else
                    merchantParamsArr = [NSArray arrayWithObject:@"Login With Password"];
            }
            else
                merchantParamsArr = [NSArray arrayWithObject:@"Login With Password"];
            //  [self.navigationController pushViewController:loginVC animated:YES];
            
        }
        else
        {
            merchantParamsArr = [NSArray arrayWithObject:@"Login With Password"];
            
        }
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(sendingMerchantParams:)])
        {
            [self.delegate sendingMerchantParams:merchantParamsArr];
        }
        
    }

  else  if (err)
    {
        //        NSLog(@"%@",err.localizedDescription);
        //        if ([err.localizedDescription isEqualToString:@"The operation couldn’t be completed."])
        //        {
        ALERT(@"Server Timed Out", @"Try again");
        //}
    }
  
    else if (tag == SDK_REQUEST_LOGIN)
    {
        if ([responseDict valueForKey:@"access_token"]) {
            
            
            [[PayuMoneySDKAppConstant sharedInstance] setAccessToken:[responseDict objectForKey:@"access_token"]];
            NSLog(@"Access Token = %@",[[PayuMoneySDKAppConstant sharedInstance] accessToken]);
            [self performSelectorOnMainThread:@selector(getUserProfile) withObject:nil waitUntilDone:YES];
        }
        else if([[responseDict valueForKey:@"status"]isEqual:[NSNumber numberWithInt:-1]])
        {
            if ([[responseDict valueForKey:@"message"]isEqual:@"Verification code has expired - Please generate a new verification code"])
            {
                if ([self.str isEqualToString:@"fromViewController"]) {
                    [self hitLoginParamsApi];
                }
                else
                ALERT(@"Invalid Credentials", @"");
//                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(sendingResponseBack:)]) {
//                    [self.delegate sendingResponseBack:@"failure"];
//                }
                //[self hitLoginParamsApi];
            }
            else if([[responseDict valueForKey:@"message"]isEqual:@"Please generate the verification code"])
            {
                [self hitLoginParamsApi];
            }
            else
                ALERT(@"Something Went Wrong", @"Please try again");
        }
        else if ([[responseDict valueForKey:@"error"]isEqualToString:@"invalid_grant"])
        {
            if ([[responseDict valueForKey:@"error_description"]isEqualToString:@"User is disabled"]) {
//                [self.delegate sendingResponseBack:@"failure"];
                [self hitLoginParamsApi];
            }
            else
            {
                ALERT(@"Bad Credentials", @"Enter proper credentials");
                
            }
        }
        
    }
    else if (tag == SDK_REQUEST_GET_PROFILE)
    {
        if ([[responseDict valueForKey:@"status"]isEqual:[NSNumber numberWithLong:0]]) {
//            [APP_DELEGATE.keyChain setObject:self.emailTextField.text forKey:(__bridge id)kSecAttrAccount];
//            [APP_DELEGATE.keyChain setObject:activeTextField.text forKey:(__bridge id)kSecValueData];
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(sendingResponseBack:)]) {
                
                [self.delegate sendingResponseBack:@"success"];
            }
        }
        else
        {
//            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(sendingResponseBack:)]) {
//                [self.delegate sendingResponseBack:@"failure"];
//            }
            if ([self.str isEqualToString:@"fromViewController"]) {
                
            
            [self hitLoginParamsApi];
            }
            else
            {
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(sendingResponseBack:)])
                {
                                    [self.delegate sendingResponseBack:@"failure"];
                                }
            }
        }
    }
  
    
}
-(void)getUserProfile{
    
    ssession = [PayuMoneySDKSession sharedSession];
    ssession.delegate = self;
    // NSDictionary  *header =   [[NSDictionary  alloc]initWithObjects:[NSArray arrayWithObject:[NSString stringWithFormat:@"Bearer %@",[AppConstant sharedInstance].accessToken]] forKeys:[NSArray arrayWithObject:@"Authorization"]];
    [ssession fetchResponsefrom:Auth_URL isPost:NO body:nil tag:SDK_REQUEST_GET_PROFILE isAccessTokenRequired:YES];
    
    
}

-(void)hitLoginParamsApi
{
   

    ssession = [PayuMoneySDKSession sharedSession];
    ssession.delegate = self;
     [ssession fetchResponsefrom:Login_Params_URL isPost:NO body:nil tag:SDK_REQUEST_PARAMS isAccessTokenRequired:NO];
}
@end
