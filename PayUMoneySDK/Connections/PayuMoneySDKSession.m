//
//  Session.m
//  payuSDK
//
//  Created by Honey Lakhani on 7/23/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKSession.h"

@interface PayuMoneySDKSession()
{
    double wallet_points;
}
@end
@implementation PayuMoneySDKSession

static PayuMoneySDKSession *session = nil;

+(PayuMoneySDKSession *)sharedSession
{
    if(!session)
    {
        session = [[PayuMoneySDKSession alloc]init];
    }
       return session;
}



-(void)startPaymentProcess  :(NSDictionary *)params
{
    //NSLog(@"josn dict before -------------------------> %@",params);
    NSException *exception;

    PayuMoneySDKRequestParams *requestParams = [PayuMoneySDKRequestParams sharedInstance];
    if (![params valueForKey:@"fromPayuMoneyApp"]) {
        
    
        if([[params valueForKey:@"txnid"] isEqual: @""])
        {
            [params setValue:@"0nf7" forKey:@"TxnId"];
            requestParams.txnid = @"0nf7";
        
        }
        if(![params valueForKey:@"phone"])
        {
            exception = [NSException exceptionWithName:@"Phone No Missing" reason:@"contact no not found" userInfo:nil];
            @throw exception;
        }
        
    if([[params valueForKey:@"firstname" ] isEqual:@""])
        {
           [params setValue:@"piyush" forKey:@"firstName"];
            requestParams.firstname = @"honeylakhani@gmail.com";
        }
        if([[params valueForKey:@"merchnatid"]isEqual:@""])
        {
            [params setValue:@"4825489" forKey:@"MerchantId"];
            requestParams.merchantid = @"4825489";
            
        }

        if([[params valueForKey:@"surl"] isEqual:@""])
        {
            [params setValue:@"https://test.payumoney.com/mobileapp/payumoney/success.php" forKey:@"SURL"];
        requestParams.surl = @"https://test.payumoney.com/mobileapp/payumoney/success.php";
         //   params.surl = @"https://payu.herokuapp.com/ios_success";
        }
        if([[params valueForKey:@"furl"] isEqual:@""])
        {
            [params setValue:@"https://test.payumoney.com/mobileapp/payumoney/failure.php" forKey:@"FURL"];
            requestParams.furl = @"https://test.payumoney.com/mobileapp/payumoney/failure.php";
           // params.furl = @"https://payu.herokuapp.com/ios_failure";
            
        }
        if([[params valueForKey:@"email"] isEqual:@""])
        {
            [params setValue:@"piyush.jain@payu.in" forKey:@"email"];
            requestParams.email = @"honeylakhani@gmail.com";
        }
        if([[params valueForKey:@"productinfo"] isEqual:@""])
        {
            [params setValue:@"product_name" forKey:@"productinfo"];
            requestParams.productinfo = @"product_name";
        }
  
    //[self fetchMerchantParams:params.merchantid];
    //NSLog(@"dict -------> %@",params);
    }
    else
    {
        requestParams.response = [params valueForKey:@"fromPayuMoneyApp"];
    }
    
}

-(void)createPayment
{
    [self fetchResponsefrom:Payment_URL isPost:YES body:[PayuMoneySDKServiceParameters prepareBodyForCreatePayment] tag:SDK_REQUEST_PAYMENT isAccessTokenRequired:YES];
}



-(void)fetchResponsefrom : (NSString *)strURL isPost : (BOOL)type body : (NSString *)strBody  tag : (SDK_REQUEST_TYPE)tag isAccessTokenRequired : (BOOL)tokenRequired
{
//    [session addConnectionManager];
//
//    if([type isEqualToString:@"post"])
//        [connection sendRequestWithURL:strURL withBody:strBody withHeaderData:header withTag:tag];
//    else
//        [connection sendGetRequestWithURL:strURL withHeaderData:header withTag:tag];
    if (SDK_APP_CONSTANT.isServerReachable) {
        
    
    PayuMoneySDKRequestManager *requestManager = [[PayuMoneySDKRequestManager alloc]init];
    [requestManager hitWebServiceForURLWithPostBlock:type isAccessTokenRequired:tokenRequired webServiceURL:strURL withBody:strBody andTag:tag completionHandler:^(id object, SDK_REQUEST_TYPE tag, NSError *error) {
       // if(error == nil){
//            if([object isKindOfClass:[NSDictionary class]]){
//                [[AppSettings sharedInstance] setAccessToken:[object objectForKey:@"access_token"]];
//                //NSLog(@"Access Token = %@",[[AppSettings sharedInstance] accessToken]);
//                [self performSelectorOnMainThread:@selector(getUserProfile) withObject:nil waitUntilDone:YES];
//            }
            if(self.delegate != nil && [self.delegate respondsToSelector:@selector(sendResponse:tag:error:)])
                [self.delegate sendResponse:object tag:tag error:error];

            
       // }
//        else
//        {
//            
//        }
    }
     ];
    }
    else
    {
         ALERT(@"Internet not connected", @"Please connect");
    }
}

-(void)sendToPayUWithWallet : (NSDictionary *)details : (NSString *)mode : (NSDictionary *)cardData : (double)userPoints : (double)vault : (NSDictionary *)coupon : (double)convenienceCharges
{
    wallet_points = vault;
    [self sendToPayU:details :mode :cardData :userPoints : coupon :convenienceCharges];
}

-(void)sendToPayU :(NSDictionary *)details : (NSString *)mode : (NSDictionary *)cardData : (double)userPoints1 : (NSDictionary *)coupon: (double)convenienceCharges
{
  

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    float userPoints = (float)userPoints1;
       double Dis_amt = 0.0;
     NSMutableDictionary *sourceAmountMap;
    if(coupon)
    {
        [params setValue:[coupon valueForKey:@"couponString"] forKey:@"couponUsed"];
        Dis_amt = [[coupon valueForKey:@"couponAmount"]doubleValue];
    }
    else
        Dis_amt = [[[[[details valueForKey:@"result"] valueForKey:@"merchant"] valueForKey:@"offer"]valueForKey:@"offerType"] isEqualToString:@"Discount"]?[[[[[details valueForKey:@"result"] valueForKey:@"merchant"] valueForKey:@"offer"]valueForKey:@"offerAmount"] doubleValue] : 0.00;//this should be discount
    if(userPoints == 0.00f)
    {
        double payUAmt = [[[[details valueForKey:@"result"] valueForKey:@"payment"] valueForKey:@"orderAmount"] doubleValue] + convenienceCharges - Dis_amt;
       
        if(wallet_points > 0.0)
        {
            payUAmt -= wallet_points;
//            NSMutableDictionary *sourceAmountMap = [[NSMutableDictionary alloc]init];
//            [sourceAmountMap setValue:[NSNumber numberWithDouble:payUAmt] forKey:@"PAYU"];
         sourceAmountMap = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithDouble:payUAmt],[NSNumber numberWithDouble:Dis_amt],[NSNumber numberWithDouble: wallet_points], nil] forKeys:[NSArray arrayWithObjects:@"PAYU",@"DISCOUNT",@"WALLET", nil]];
            
        }
        else
        {
         sourceAmountMap = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithDouble:payUAmt],[NSNumber numberWithDouble:Dis_amt], nil] forKeys:[NSArray arrayWithObjects:@"PAYU",@"DISCOUNT",nil]];
        }
    }
    else if ([mode isEqual:@"wallet"])//Points+Wallet OR Just Wallet Payments
    {
        if(wallet_points == 0.0)//pure wallet
        {
            sourceAmountMap = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithFloat:userPoints],[NSNumber numberWithDouble:0],[NSNumber numberWithDouble: Dis_amt], nil] forKeys:[NSArray arrayWithObjects:@"WALLET",@"PAYU",@"DISCOUNT", nil]];
        }
        else
        {
           sourceAmountMap = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithFloat : userPoints],[NSNumber numberWithDouble:wallet_points],[NSNumber numberWithDouble: 0],[NSNumber numberWithDouble : Dis_amt], nil] forKeys:[NSArray arrayWithObjects:@"WALLET",@"CASHBACK",@"PAYU",@"DISCOUNT", nil]];
        }
    }
    else if ([mode isEqual:@"points"])//Have PayUPoints and has selected to pay via payupoints

    {
        sourceAmountMap = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithFloat:userPoints],[NSNumber numberWithDouble:0],[NSNumber numberWithDouble:Dis_amt], nil] forKeys:[NSArray arrayWithObjects:@"CASHBACK",@"PAYU",@"DISCOUNT", nil]];
        
    }
    else //Has PayUPoints but opted not to pay via payupoints
    {
      double payUAmt = [[[[details valueForKey:@"result"] valueForKey:@"payment"] valueForKey:@"orderAmount"] doubleValue] + convenienceCharges - Dis_amt - userPoints;
        if(wallet_points > 0.0)
        {
            payUAmt -= wallet_points;
        }
        sourceAmountMap = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithFloat:userPoints],[NSNumber numberWithDouble:payUAmt],[NSNumber numberWithDouble:Dis_amt],[NSNumber numberWithDouble:wallet_points], nil] forKeys:[NSArray arrayWithObjects:@"CASHBACK",@"PAYU",@"DISCOUNT",@"WALLET", nil]];
    }
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sourceAmountMap options:NSJSONWritingPrettyPrinted error:&err];
    NSString *stt = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    [params setValue:stt forKey:@"sourceAmountMap"];
    
    wallet_points = 0.0;
    if([mode isEqual:@"points"] || [mode isEqual:@"wallet"])
    {
        [params setValue:@"WALLET" forKey:@"PG"];
    }
    else // Pure points/wallet - > CC, Pure Credit Card -> CC Debit Card -> DC Net banking -> NB
    {
        [params setValue:mode forKey:@"PG"];
        if([cardData valueForKey:@"bankcode"])
        {
            [params setValue:[cardData valueForKey:@"bankcode"] forKey:@"bankCode"];
        }
        else
        {
            [params setValue:mode forKey:@"bankCode"];
        }
    }
    
//if(![mode isEqual:@"points"] && ![mode isEqual:@"wallet"])
//{
//  
//}

    if([cardData valueForKey:@"store_card"])
    {
        [params setValue:[cardData valueForKey:@"store_card"] forKey:@"storeCardId"];
    }
    [params setValue:@"0" forKey:@"revisedCashbackReceivedStatus"];
 //postFetch("/payment/app/customer/getPaymentMerchant/" + details.getJSONObject(Constants.PAYMENT).getString(Constants.PAYMENT_ID)
//     NSString *body = [NSString stringWithFormat:@"%@",params];
//    NSArray *keys = [params allKeys];
//    //NSLog(@"%@",body);
//    NSMutableString *string = [[NSMutableString alloc]init];
//    for(int i =0 ;i<keys.count;i++)
//    {
//        [string appendString:[NSString stringWithFormat:@"%@=%@",keys[i],[params valueForKey:keys[i]]]];
//        if(i!=keys.count - 1)
//            [string appendString:@"&"];
//    }
 //   NSString *str = [NSString stringWithFormat:@"PG=%@&bankCode=%@&revisedCashbackReceivedStatus=%@&sourceAmountMap=%@",[params valueForKey:@"PG"],[params valueForKey:@"bankCode"],[params valueForKey:@"revisedCashbackReceivedStatus"],stt];
//    NSDictionary *header =   [[NSDictionary  alloc]initWithObjects:[NSArray arrayWithObject:[NSString stringWithFormat:@"Bearer %@",APP_DELEGATE.token] ] forKeys:[NSArray arrayWithObject:@"Authorization"]];
//
   // NSString *strURL = [NSString stringWithFormat:@"%@/payment/app/customer/getPaymentMerchant/%@?%@",Main_URl,[[details valueForKey:@"result"] valueForKey:@"paymentId"],string];
  //  //NSLog(@"URL ------------------- %@",strURL);
    if (SDK_APP_CONSTANT.isServerReachable) {
        
        NSString *requestBody = [PayuMoneySDKServiceParameters PrepareBodyForGetPaymentMerchant:[[details valueForKey:@"result"] valueForKey:@"paymentId"] :params];
    [self fetchResponsefrom:Get_Payment_Merchant_URL isPost:NO body:requestBody tag:SDK_REQUEST_GET_PAYMENT_MERCHANT isAccessTokenRequired:YES];
    }
    else
    {
         ALERT(@"Internet not connected", @"Please connect");
    }
   // [self fetchResponsefrom:strURL type:@"get" body : nil header:header tag:120];
}
-(void)fetchPaymentStatus : (NSString *)paymentID
{
    [self fetchResponsefrom:Post_Payment_URL isPost:YES body:[PayuMoneySDKServiceParameters prepareBodyForPostPayment:paymentID] tag:SDK_REQUEST_POST_PAYMENT isAccessTokenRequired:YES];
}

-(void)enableOneclickTransaction : (NSString *)enable
{
    if (SDK_APP_CONSTANT.isServerReachable) {
        
    
    [self fetchResponsefrom:One_CLick_Transaction_URL isPost:YES body:[PayuMoneySDKServiceParameters prepareBodyForOneClick:enable] tag:SDK_REQUEST_ONE_CLICK isAccessTokenRequired:YES];
    }
    else
    {
        [SDK_APP_CONSTANT noInternetConnectionAvailable];
    }
}

@end
