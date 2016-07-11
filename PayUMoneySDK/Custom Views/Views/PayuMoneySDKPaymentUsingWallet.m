//
//  PaymentUsingWallet.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/21/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKPaymentUsingWallet.h"
#import "PayuMoneySDKWebViewViewController.h"
#import "PayuMoneySDKReachability.h"
@interface PayuMoneySDKPaymentUsingWallet()<SendingResponseDelegate>
{
    NSDictionary *details,*couponDict;
    float walletUsed,convenienceFee;
    NSString *pointsUsed;
    
}
@end
@implementation PayuMoneySDKPaymentUsingWallet

-(PayuMoneySDKPaymentUsingWallet *)initWithFrame : (CGRect)frame withResponse : (NSDictionary *)response withCoupon : (NSDictionary *)  coupon   withWalletUsage : (float)walletUsage withConvenienceFee:(float)fee withPoints : (NSString *)points
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.payWallet = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKPaymentUsingWallet" owner:self options:nil]firstObject];
        self.payWallet.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        if(CGRectIsEmpty(frame))
            self.bounds = self.payWallet.bounds;
        [self addSubview:self.payWallet];
    }
    self.LblPayUsingWallet.font = SDK_FONT_BOLD(20.0);
    details = response;
    couponDict = coupon;
    walletUsed = walletUsage;
    pointsUsed = points;
    convenienceFee = fee;
    
    
    
//    self.orderAmountLbl.text = [NSString stringWithFormat:@"Order Amount : Rs.%0.2lf",[[[[details valueForKey:@"result"]valueForKey:@"payment"]valueForKey:@"orderAmount"]doubleValue]];
//    self.convenienceFeeLbl.text = [NSString stringWithFormat:@"Convenience Fee : Rs.%0.2f",fee];
//    NSString *points = [[[details valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"points"];
//    
//    if (points== nil || [points isKindOfClass:[NSNull class]] || [points isEqual:@"<null>"]) {
//        self.pointsLbl.text = @"0.0";
//    }
//    else{
        //self.pointsLbl.text = [NSString stringWithFormat:@"PayU Points Used : Rs.%@",points];
   // }
    
    //self.pointsLbl.text = [NSString stringWithFormat:@"%0.2f",[[[[[details valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"points"] valueForKey:@"amount"] doubleValue]];
    
//    if(coupon)
//    self.discountLbl.text = [NSString stringWithFormat:@"Discount : Rs.%0.2f",[[coupon valueForKey:@"couponAmount"]doubleValue]];
//    else
//        self.discountLbl.text =  [[[[[details valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerType" ] isEqualToString:@"Discount"] ? [NSString stringWithFormat:@"Discount : Rs.%0.2f",[[[[[details valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerAmount"]doubleValue]]: @"Discount : Rs.0.00";
    self.walletMoneyUsedLbl.text =[NSString stringWithFormat:@"Wallet Money Used : Rs.%0.2f",walletUsage];
    [self.walletMoneyUsedLbl setFont:SDK_FONT_NORMAL(16.0)];
    //[self.walletMoneyUsedLbl setFont:[UIFont systemFontOfSize:16.0]];
    self.reaminingWalletMoneyLbl.text = [NSString stringWithFormat:@"Remaining Money in Wallet : Rs.%0.2f",[[[[[details valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"wallet"] valueForKey:@"amount"] doubleValue] - walletUsage];
        [self.reaminingWalletMoneyLbl setFont:SDK_FONT_NORMAL(16.0)];
    CGSize lblsize = [self.reaminingWalletMoneyLbl.text sizeWithAttributes:@{NSFontAttributeName: SDK_FONT_NORMAL(16.0)}];
    if (lblsize.width > self.reaminingWalletMoneyLbl.frame.size.width) {
        self.reaminingWalletMoneyLbl.numberOfLines = 0;
    }
    [self.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.okBtn.layer.cornerRadius = 3.0;
    return self;
}

- (IBAction)okBtnClicked:(UIButton *)sender {
    if (SDK_APP_CONSTANT.isServerReachable) {
        
    
    PayuMoneySDKSession *session = [PayuMoneySDKSession sharedSession];
    session.delegate = self;
    [PayuMoneySDKActivityView activityViewForView:self.superview.window withLabel:LOADER_MESSAGE];
    
    [session sendToPayUWithWallet:details :@"wallet" :nil :walletUsed :[pointsUsed doubleValue] :couponDict :convenienceFee];
    }
    else
    {
         ALERT(@"Internet not connected", @"Please connect");
    }
}
-(void)sendResponse:(NSDictionary *)responseDict tag:(SDK_REQUEST_TYPE)tag error:(NSError *)err
{
    
    //
    
    if(responseDict && tag == SDK_REQUEST_GET_PAYMENT_MERCHANT)
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

        [session fetchPaymentStatus : [[[responseDict valueForKey:@"result"]valueForKey:@"payment"]valueForKey:@"paymentId"]];

//        UIStoryboard *sdkSB = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
//        PayuMoneySDKWebViewViewController *webView = [sdkSB instantiateViewControllerWithIdentifier:@"webVC"];
//        
//        webView.bodyParams = [NSString stringWithFormat:@"paymentId=%@",[[[responseDict valueForKey:@"result"] valueForKey:@"payment"] valueForKey:@"paymentId"]];
//        webView.type = @"get";
//        webView.paymentId = [[[details objectForKey:@"result"]objectForKey:@"payment" ]  objectForKey:@"paymentId"];
//        webView.urlString = SDK_BASE_URL(@"payment/postBackParam.do?");
////         @"https://mobiletest.payumoney.com/payment/postBackParam.do?";
//       
//        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(backToPaymentContollerWithWebView :)])
//        {
//            [self.delegate backToPaymentContollerWithWebView:webView];
//        }
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

@end
