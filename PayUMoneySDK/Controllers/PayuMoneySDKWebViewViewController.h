//
//  WebViewViewController.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/9/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"
//#import "BaseViewController.h"
@interface PayuMoneySDKWebViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property NSString *urlString,*bodyParams,*type;
@property WebViewJavascriptBridge* PayU;
@property BOOL fromApp;
@property NSString *paymentId;





@end