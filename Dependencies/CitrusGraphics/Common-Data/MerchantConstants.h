//
//  MerchantConstants.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 13/08/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//


#ifndef CTS_iOS_Sdk_MerchantConstants_h
#define CTS_iOS_Sdk_MerchantConstants_h

#warning "set your own oauth keys and urls to see testing results"

/*
 set oauth keys
*/

// Sandbox
#define SignInId_Sandbox @"9hh5re3r5q-signin"
#define SignInSecretKey_Sandbox @"ffcfaaf6e6e78c2f654791d9d6cb7f09"
#define SubscriptionId_Sandbox @"9hh5re3r5q-signup"
#define SubscriptionSecretKey_Sandbox @"3be4d7bf59c109e76a3619a33c1da9a8"

#define VanityUrl_Sandbox @"nativeSDK"
#define BillUrl_Sandbox @"https://salty-plateau-1529.herokuapp.com/billGenerator.sandbox.php"
#define ReturnUrl_Sandbox @"https://salty-plateau-1529.herokuapp.com/redirectURL.sandbox.php"

// Production
#define SignInId_Production @"set your own production key"
#define SignInSecretKey_Production @"set your own production key"
#define SubscriptionId_Production @"set your own production key"
#define SubscriptionSecretKey_Production @"set your own production key"

#define VanityUrl_Production @"set your own vanity url"
#define BillUrl_Production @"set your own bill url"
#define ReturnUrl_Production @"set your own return url"

#endif
