
//
//  BaseViewController.m
//  CubeDemo
//
//  Created by Vikas Singh on 8/25/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import "BaseViewController.h"
#import "TestParams.h"
#import "MerchantConstants.h"

@interface BaseViewController () {
    NSString *billingUrl;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTestData];
    _billUrl = [[NSString alloc] init];
    _returnUrl = [[NSString alloc] init];
    
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    NSString *server = [defautls valueForKey:@"EnvironmentTo"];
    if (server == nil) {
        [defautls setValue:@"0" forKey:@"EnvironmentTo"];
    }
    
    
//#warning "set your required environment to see testing results"
//#ifdef PRODUCTION_MODE
//    [CitrusPaymentSDK initializeWithKeyStore:keyStore environment:CTSEnvProduction];
//#else
//    [CitrusPaymentSDK initializeWithKeyStore:keyStore environment:CTSEnvSandbox];
//#endif
    if ([server integerValue] == 0) {
        self.billUrl = BillUrl_Sandbox;
        self.returnUrl = ReturnUrl_Sandbox;
    }
    else if ([server integerValue] == 1){
        self.billUrl = BillUrl_Production;
        self.returnUrl = ReturnUrl_Production;
    }
}

// Initialize the SDK layer viz CTSAuthLayer/CTSProfileLayer/CTSPaymentLayer
- (void)changeEnvironment:(NSUInteger)newIndex {
        NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];

#warning "set your required environment to see testing results"
        NSLog(@"segmentedControl did select index %lu (via block handler)", (unsigned long)newIndex);
        if (newIndex == 0) {
            NSLog(@"setupWorkingEnvironmentTo CTSEnvSandbox");
            // initialize the SDK by setting it up with ClientIds
            [CitrusPaymentSDK initWithSignInID:SignInId_Sandbox
                                  signInSecret:SignInSecretKey_Sandbox
                                      signUpID:SubscriptionId_Sandbox
                                  signUpSecret:SubscriptionSecretKey_Sandbox
                                     vanityUrl:VanityUrl_Sandbox
                                   environment:CTSEnvSandbox];
            self.billUrl = BillUrl_Sandbox;
            self.returnUrl = ReturnUrl_Sandbox;
            
            [CitrusPaymentSDK setLogLevel:CTSLogLevelVerbose];
            [defautls setValue:@"0" forKey:@"EnvironmentTo"];
        }
        else {
            NSLog(@"setupWorkingEnvironmentTo CTSEnvProduction");
            // initialize the SDK by setting it up with ClientIds
            [CitrusPaymentSDK initWithSignInID:SignInId_Production
                                  signInSecret:SignInSecretKey_Production
                                      signUpID:SubscriptionId_Production
                                  signUpSecret:SubscriptionSecretKey_Production
                                     vanityUrl:VanityUrl_Production
                                   environment:CTSEnvProduction];
            self.billUrl = BillUrl_Production;
            self.returnUrl = ReturnUrl_Production;
            
            [CitrusPaymentSDK setLogLevel:CTSLogLevelVerbose];

            [defautls setValue:@"1" forKey:@"EnvironmentTo"];
        }
        [CitrusPaymentSDK enableLoader];
        [CitrusPaymentSDK setLoaderColor:[UIColor orangeColor]];
}


- (void)setTestData {
    _contactInfo = [[CTSContactUpdate alloc] init];
    _contactInfo.firstName = TEST_FIRST_NAME;
    _contactInfo.lastName = TEST_LAST_NAME;
    _contactInfo.email = TEST_EMAIL;
    _contactInfo.mobile = TEST_MOBILE;
    
    _addressInfo = [[CTSUserAddress alloc] init];
    _addressInfo.city = TEST_CITY;
    _addressInfo.country = TEST_COUNTRY;
    _addressInfo.state = TEST_STATE;
    _addressInfo.street1 = TEST_STREET1;
    _addressInfo.street2 = TEST_STREET2;
    _addressInfo.zip = TEST_ZIP;
    
    _customParams = @{
                      @"USERDATA2":@"MOB_RC|9988776655",
                      @"USERDATA10":@"test",
                      @"USERDATA4":@"MOB_RC|test@gmail.com",
                      @"USERDATA3":@"MOB_RC|4111XXXXXXXX1111",
                      };
}

@end
