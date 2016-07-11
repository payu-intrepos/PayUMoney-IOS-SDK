//
//  PayUsingPointsViewController.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKPayUsingPointsViewController.h"
#import "PayuMoneySDKPaymentViewController.h"
#import "PayuMoneySDKWebViewViewController.h"
@interface PayuMoneySDKPayUsingPointsViewController ()<SendingResponseDelegate>

@end

@implementation PayuMoneySDKPayUsingPointsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.netAmountLabel.text = [NSString stringWithFormat:@"Net Amount : Rs.%@",self.netAmount];
    self.netAmountLabel.font = SDK_FONT_NORMAL(15.0);
    
    if (self.convenienceCharge != 0.00) {

        self.discountLabel.text = [NSString stringWithFormat:@"Convenience Fee : Rs.%0.2lf",self.convenienceCharge];
         self.discountLabel.font = SDK_FONT_NORMAL(15.0);
        if (self.type && self.discount) {
            self.convenienceChargeLabel.text = [NSString stringWithFormat:@"%@ : Rs.%@",self.type,self.discount];
            self.convenienceChargeLabel.font = SDK_FONT_NORMAL(15.0);

            self.totalAmountLabel.text = [NSString stringWithFormat:@"Order Amount : Rs.%@",self.amount];
            self.totalAmountLabel.font = SDK_FONT_NORMAL(15.0);

        }
        else
        {
            self.convenienceChargeLabel.text = [NSString stringWithFormat:@"Order Amount : Rs.%@",self.amount];
            self.convenienceChargeLabel.font = SDK_FONT_NORMAL(15.0);

        }
        
        
    }
  else
  {
      if (self.type && self.discount) {
          self.discountLabel.text = [NSString stringWithFormat:@"%@ : Rs.%@",self.type,self.discount];
          self.discountLabel.font = SDK_FONT_NORMAL(15.0);

          self.convenienceChargeLabel.text = [NSString stringWithFormat:@"Order Amount : Rs.%@",self.amount];
          self.convenienceChargeLabel.font = SDK_FONT_NORMAL(15.0);

      }
      else
      {
          self.discountLabel.text = [NSString stringWithFormat:@"Order Amount : Rs.%@",self.amount];
          self.discountLabel.font = SDK_FONT_NORMAL(15.0);

      }
  }
   
   

   self.totalPointsLabel.text = [NSString stringWithFormat:@"Available PayUMoney Points (in rs) : Rs.%@",self.totalPoints];
        self.totalPointsLabel.font = SDK_FONT_NORMAL(15.0);
   
    //self.navigationItem.hidesBackButton = NO;
    [self.payNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.payNowBtn.layer.cornerRadius = 3.0;
    if (!self.fromApp) {
        
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClicked:)];
        self.navigationItem.leftBarButtonItem = leftBtn;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)popCurrentViewController
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to cancel the transaction" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}


-(void)backBtnClicked : (UIBarButtonItem *)sender
{
   // [self.navigationController popToRootViewControllerAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to cancel the transaction" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *requestBody = [PayuMoneySDKServiceParameters prepareBodyForCancelTransactionWithPaymentId:[[[self.responseDict objectForKey:@"result"]objectForKey:@"payment" ]  objectForKey:@"paymentId"] withStatus:@"1"];
        
        [SDK_APP_CONSTANT cancelTransactionManuallyWithRequestBody:requestBody];
        
        if(!self.fromApp)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
            [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationTxnCompleted object:kNotificationRejectTxn];
        
    }
}

-(void)sendResponse:(NSDictionary *)responseDict tag:(SDK_REQUEST_TYPE)tag error:(NSError *)err
{
    
    if(tag == SDK_REQUEST_GET_PAYMENT_MERCHANT)
    {
        if (![[[[responseDict objectForKey:@"result"]objectForKey:@"payment"] objectForKey:@"txnDetails"] isKindOfClass:[NSNull class]]) {
            
            // if (![[[[responseDict objectForKey:@"result"]objectForKey:@"cashbackAccumulated" ] objectForKey:@"paymentId"]isEqualToString:@"<null>"]) {
            NSString *paymentID = [NSString stringWithFormat:@"%@",[[[[responseDict objectForKey:@"result"]objectForKey:@"payment"]objectForKey:@"txnDetails" ]  objectForKey:@"paymentId"]];
            [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:[NSString stringWithFormat:@"%@",paymentID] forKey:KEY_PAYMENT_ID];
        }
        
        NSString *mID = [[[responseDict objectForKey:@"result"] objectForKey:@"payment"] objectForKey:@"merchantId"];
        [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:[NSString stringWithFormat:@"%@",mID] forKey:KEY_MERCHANT_ID];
        

//        id paymentID = [NSString stringWithFormat:@"%@",[[[responseDict objectForKey:@"result"]objectForKey:@"cashbackAccumulated" ]  objectForKey:@"paymentId"]];
//        
//        if([paymentID isKindOfClass:[NSString class]]){
//            [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:paymentID forKey:KEY_PAYMENT_ID];
//        }
//        else if ([paymentID isKindOfClass:[NSNumber class]]){
//            [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:[paymentID stringValue] forKey:KEY_MERCHANT_ID];
//        }
//
//        
//        id mID = [[[responseDict objectForKey:@"result"] objectForKey:@"merchant"] objectForKey:@"merchantId"];
//        if([mID isKindOfClass:[NSString class]]){
//            [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:mID forKey:KEY_MERCHANT_ID];
//        }
//        else if ([mID isKindOfClass:[NSNumber class]]){
//            [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:[mID stringValue] forKey:KEY_MERCHANT_ID];
//        }
        PayuMoneySDKSession *session = [PayuMoneySDKSession sharedSession];
        session.delegate = self;
        [session fetchPaymentStatus:[[[responseDict valueForKey:@"result"]valueForKey:@"payment"]valueForKey:@"paymentId"]];

//        UIStoryboard *sdkSB = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
//        PayuMoneySDKWebViewViewController *webView = [sdkSB instantiateViewControllerWithIdentifier:@"webVC"];
//        
//        webView.bodyParams = [NSString stringWithFormat:@"paymentId=%@",[[[responseDict valueForKey:@"result"] valueForKey:@"payment"] valueForKey:@"paymentId"]];
//        webView.type = @"get";
//        webView.paymentId = [[[self.responseDict objectForKey:@"result"]objectForKey:@"payment" ]  objectForKey:@"paymentId"];
//        webView.urlString = SDK_BASE_URL(@"payment/postBackParam.do?");
        
        
       // [self.navigationController pushViewController:webView animated:YES ];

    }
    else if (responseDict && tag == SDK_REQUEST_POST_PAYMENT)
    {
        [PayuMoneySDKActivityView removeViewAnimated:YES];
        NSString *status = [self checkNullValue:[responseDict valueForKey:@"status"]];
        if (status == nil || [status isEqualToString:@"-1"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTxnCompleted object:kNotificationFailureTxn];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTxnCompleted object:kNotificationSuccessTxn];
        }
    }
}
-(NSString*)checkNullValue:(id)text
{
    NSString *parsedText = @"";
    if([text isKindOfClass:[NSString class]])
    {
        if([text isEqualToString:@"<null>"])
            parsedText = @"";
        else{
            parsedText = text;
        }
    }
    else if ([text isKindOfClass:[NSNumber class]]){
        parsedText = [text stringValue];
    }
    return parsedText;
}
- (IBAction)payNowBtnClicked:(id)sender {
      PayuMoneySDKSession *session = [PayuMoneySDKSession sharedSession];
    session.delegate = self;
       if (SDK_APP_CONSTANT.isServerReachable) {
           [PayuMoneySDKActivityView activityViewForView:self.view.window withLabel:LOADER_MESSAGE];
           
    [session sendToPayUWithWallet:self.responseDict :@"points" :nil :[self.netAmount doubleValue] :0.0 :self.couponApplied :self.convenienceCharge];
    }
    else
    {
        ALERT(@"Internet not connected", @"Please connect");
    }
}
@end
