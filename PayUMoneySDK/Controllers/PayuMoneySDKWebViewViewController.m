
//  WebViewViewController.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/9/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKWebViewViewController.h"
#import "PayuMoneySDKFinalViewController.h"

#define kSUCCESS_RESPONSE @"payumoney/success.php"
#define kFAILURE_RESPONSE @"payumoney/failure.php"


@interface PayuMoneySDKWebViewViewController () <UIWebViewDelegate,UIAlertViewDelegate>{
   }
//@property PayUMoney* PayU;

@end

@implementation PayuMoneySDKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    //self.navigationItem.hidesBackButton = YES;
    if (!self.fromApp) {
            UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClickedOnWebView:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    

    }

    // Do any additional setup after loading the view.
    //    //NSLog(@"url string ================ %@",self.urlString);
    if (SDK_APP_CONSTANT.isServerReachable) {
        
      //  [ActivityView activityViewForView:APP_DELEGATE.window withLabel:LOADER_MESSAGE];
        
        if([self.type isEqualToString:@"post"])
        {
            NSMutableURLRequest *url = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlString]];
            [url setHTTPMethod:@"POST"];
            [url setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [url setHTTPBody:[self.bodyParams dataUsingEncoding:NSUTF8StringEncoding]];
            //  if (APP_DELEGATE.isServerReachable) {
            
            [self.webView loadRequest:url];
            //  }
            //        else
            //        {
            //            ALERT(@"Internet not connected", @"Please connect");
            //        }
        }
        else if ([self.type isEqualToString:@"get"])
        {
            
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.urlString,self.bodyParams]]]];
            
        }
    }
    
    
    else
    {
        [SDK_APP_CONSTANT noInternetConnectionAvailable];
    }
    
}
- (void)popCurrentViewController
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to cancel the transaction" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
   // [self setUpImageBackButton];
    
//    _PayU = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback)
//             
//             {
//                 //NSLog(@"ObjC received message from JS: %@", data);
//                 if(data)
//                 {
//                     
//                     [[NSNotificationCenter defaultCenter] postNotificationName:@"passData" object:[NSMutableData dataWithData:data ]];
//                     responseCallback(@"Response for message from ObjC");
//                 }
//                 
//             }];
}

//
- (BOOL)webView:(UIWebView *)webView  shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {

    
    NSString *requestURL = [[request URL] absoluteString];

    //NSLog(@"REQUEST URL = %@",requestURL);
    
    // Fetch payment id
    
    if([requestURL containsString:@"mihpayid"]){
        
        NSString *query = [[request URL] query];
        NSLog(@"query = %@",query);
    }
    
    if([requestURL containsString:kSUCCESS_RESPONSE]){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTxnCompleted object:kNotificationSuccessTxn];
    }
    else if ([requestURL containsString:kFAILURE_RESPONSE]){
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTxnCompleted object:kNotificationFailureTxn];
    }
   
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
   // [ActivityView removeViewAnimated:YES];
}
-(void)backBtnClickedOnWebView : (UIBarButtonItem *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to cancel the transaction" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *requestBody = [PayuMoneySDKServiceParameters prepareBodyForCancelTransactionWithPaymentId:self.paymentId withStatus:@"1"];
        
        [SDK_APP_CONSTANT cancelTransactionManuallyWithRequestBody:requestBody];
        
        if (!self.fromApp) {
           [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTxnCompleted object:kNotificationRejectTxn];
            [self.webView stopLoading];
//            UIStoryboard *sdkSB = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
//            PayuMoneySDKFinalViewController *finalVC = [sdkSB instantiateViewControllerWithIdentifier:@"finalVC"];
//            finalVC.msg = @"Oops Payment Cancelled";
//            [self.navigationController pushViewController:finalVC animated:YES];

            
            //[self.navigationController popViewControllerAnimated:YES];
        }
        else
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationTxnCompleted object:kNotificationRejectTxn];
     }
}
@end
