//
//  ServiceParameters.m
//  PayU SDK
//
//  Created by Honey Lakhani on 10/13/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import "PayuMoneySDKServiceParameters.h"
#import "PayuMoneySDKRequestParams.h"

@implementation PayuMoneySDKServiceParameters
+(NSString *)preparePostBodyForLogin : (NSString *)username withPassword : (NSString *)password
{
    NSString *strBody = [NSString stringWithFormat:@"password=%@&username=%@&client_id=10182&grant_type=password",password,username];
    return strBody;
}

+(NSString *)prepareBodyForCreatePayment
{
    NSString *strBody;
    NSError *err;
    PayuMoneySDKRequestParams *params = [PayuMoneySDKRequestParams sharedInstance];
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:params.surl,params.furl, nil] forKeys:[NSArray arrayWithObjects:@"surl",@"furl", nil]];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted
                                                         error:&err];
    NSString *stt = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSLog(@"url json ==== %@     %@",[jsonData description],stt);
    
    strBody = [NSString stringWithFormat:@"key=%@&amount=%@&txnid=%@&email=%@&firstname=%@&udf1=%@&udf2=%@&udf3=%@&udf4=%@&udf5=%@&hash=%@&deviceId=%@&paymentParts=%@&paymentIdentifiers=%@&purchaseFrom=%@&txnDetails=%@&productinfo=%@",params.key,params.amount,params.txnid,params.email,params.firstname,params.udf1,params.udf2,params.udf3,params.udf4,params.udf5,params.hashValue,@"deviceid",@"[]",@"[]",@"merchant-app",stt,params.productinfo];
    return strBody;
}

+(NSString *)PrepareBodyForGetPaymentMerchant : (NSString *)paymentId : (NSDictionary *)params
{
    NSArray *keys = [params allKeys];
   
    NSMutableString *string = [[NSMutableString alloc]init];
    for(int i =0 ;i<keys.count;i++)
    {
        [string appendString:[NSString stringWithFormat:@"%@=%@",keys[i],[params valueForKey:keys[i]]]];
        if(i!=keys.count - 1)
            [string appendString:@"&"];
    }
    
    NSString *strBody = [NSString stringWithFormat:@"%@?%@",paymentId,string];
    return strBody;
}
+(NSString *)preparebodyForSignUp : (NSString *)email withPhone : (NSString *)phone withPassword : (NSString *)password
{
    NSString *strBody = [ NSString stringWithFormat:@"userType=customer&username=%@&phone=%@&password=%@&source=%@&name=%@&pageSource=%@",email,phone,password,@"payumoney app",email,@"sign up"];
    return strBody;
}

+(NSString *)prepareBodyForOTP : (NSString *)email
{
    return [NSString stringWithFormat:@"requestType=login&userName=%@",email];
}
+(NSString *)prepareBodyForForgotPassword : (NSString *)email
{
    return [NSString stringWithFormat:@"userName=%@",email];
}

+(NSString *)prepareBodyForCancelTransactionWithPaymentId : (NSString *)paymentId withStatus : (NSString *)cancelled
{
    return  [NSString stringWithFormat:@"paymentId=%@&cancelled=%@",paymentId,cancelled];
}
+(NSString *)prepareBodyForPostPayment : (NSString *)paymentID
{
    return [NSString stringWithFormat:@"paymentId=%@",paymentID];
}
+(NSString *)prepareBodyForOneClick : (NSString *)enable
{
    return [NSString stringWithFormat:@"oneClickTxn=%@",enable];
}
+(NSString *)prepareBodyForHash : (PayuMoneySDKRequestParams *)params
{
    return [NSString stringWithFormat:@"key=%@&merchantId=%@&amount=%@&txnid=%@&SURL=%@&FURL=%@&productinfo=%@&email=%@&firstname=%@&phone=%@&udf1=%@&udf2=%@&udf3=%@&udf4=%@&udf5=%@",params.key,params.merchantid,params.amount,params.txnid,params.surl,params.furl,params.productinfo,params.email,params.firstname,params.phone,params.udf1,params.udf2,params.udf3,params.udf4,params.udf5];
}
+(NSString *)prepareBodyForCardHashWithHash : (NSString *)hash withPaymentId : (NSString *)pid withUserId : (NSString *)uid
{
    return [NSString stringWithFormat:@"hash=%@&uid=%@&pid=%@&did=%@",hash,uid,pid,[[PayuMoneySDKAppConstant sharedInstance] appUniqueID]];
}
@end
