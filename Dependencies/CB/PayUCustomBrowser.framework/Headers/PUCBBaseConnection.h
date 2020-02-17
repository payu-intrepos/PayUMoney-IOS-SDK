//
//  PUCBBaseConnection.h
//  PayUNonSeamlessTestApp
//
//  Created by Sharad Goyal on 09/06/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PayUCBWebViewResponseDelegate.h"
#import "CBConstant.h"
#import "PUCBConfiguration.h"

@interface PUCBBaseConnection : NSObject

/*!
 * calling init on this class is not allowed
 */
- (instancetype) init ATTRIBUTE_INIT;
- (instancetype) new ATTRIBUTE_NEW;

@property (nonatomic, copy) NSString *txnID;
@property (nonatomic, copy) NSString *merchantKey;
@property (weak, nonatomic) id <PayUCBWebViewResponseDelegate> cbWebViewResponseDelegate;
@property (nonatomic, assign) BOOL isAutoOTPSelect;
@property (nonatomic, strong) PUCBConfiguration *cbConfig;

/*!
 * This method is called from Merchant's App to initialize CB.
 */
-(instancetype)init:(UIView *)view webView:(id)webView;

/*!
 * This method initializes the required properties of CBConnection and setUp the CB to run.
 */
- (void)initialSetup;

/*!
 * This method is used to show the payUActivityIndicator.
 */
- (void)payUActivityIndicator;

/*
 * These methods helps in minimizing / maximizing CB screen on WebView
 */

- (void)minimizeCB;
- (void)maximizeCB;

@end
