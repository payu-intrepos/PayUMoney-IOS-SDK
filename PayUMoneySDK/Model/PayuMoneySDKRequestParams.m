//
//  RequestParams.m
//  payuSDK
//
//  Created by Honey Lakhani on 8/12/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//


#import "PayuMoneySDKRequestParams.h"
#include <CommonCrypto/CommonDigest.h>
#import "PayuMoneySDKServiceParameters.h"
#import "PayuMoneySDKRequestManager.h"
@implementation PayuMoneySDKRequestParams


+(void )initWithDict:(NSDictionary *)dict
{
    PayuMoneySDKRequestParams *sharedInstance = [PayuMoneySDKRequestParams sharedInstance];
    if (dict) {
        sharedInstance.firstname = [sharedInstance checkNullValue:[dict valueForKey:SDK_firstName]];
        sharedInstance.merchantid = [sharedInstance checkNullValue:[dict valueForKey:SDK_merchantId]];
        sharedInstance.amount = [sharedInstance checkNullValue:[dict valueForKey:SDK_amount]];
        sharedInstance.key = [sharedInstance checkNullValue:[dict valueForKey:SDK_key]];
        //            sharedInstance.txnid = [sharedInstance checkNullValue:[dict valueForKey:@"txnId"]];
        sharedInstance.txnid = [NSString stringWithFormat:@"%@%@",[dict valueForKey:SDK_txnId],[sharedInstance getRandomString:2]];
        sharedInstance.phone = [sharedInstance checkNullValue:[dict valueForKey:SDK_phone]];
        sharedInstance.email = [sharedInstance checkNullValue:[dict valueForKey:SDK_email]];
        sharedInstance.surl = [sharedInstance checkNullValue:[dict valueForKey:SDK_surl]];
        sharedInstance.furl = [sharedInstance checkNullValue:[dict valueForKey:SDK_furl]];
        sharedInstance.productinfo = [sharedInstance checkNullValue:[dict valueForKey:SDK_productinfo]];
        sharedInstance.udf1 = @"";
        sharedInstance.udf2 = @"";
        sharedInstance.udf3 = @"";
        sharedInstance.udf4 = @"";
        sharedInstance.udf5 = @"";
        NSString *hashSequence = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@||||||%@",sharedInstance.key,sharedInstance.txnid,sharedInstance.amount,sharedInstance.productinfo,sharedInstance.firstname,sharedInstance.email,[sharedInstance checkNullValue:[dict valueForKey:SDK_salt]]];
        
        sharedInstance.hashValue= [sharedInstance createSHA512:hashSequence];
        
        
    }
}



+ (PayuMoneySDKRequestParams *)sharedInstance
{
    static PayuMoneySDKRequestParams *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PayuMoneySDKRequestParams alloc] init];
                // Do any other initialisation stuff here
    });
    return sharedInstance;
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

-(NSString *)getRandomString:(NSInteger)length
{
    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
    
    NSString *numbers = @"0123456789";
    
    // First number cannot be 0
    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
    
    for (int i = 1; i < length; i++)
    {
        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
    }
    
    return returnString;
}
- (NSString *) createSHA512:(NSString *)source {
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    
    CC_SHA512(keyData.bytes, keyData.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    NSLog(@"out --------- %@",output);
  
    return [[[[output description] stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
}
-(void)calculateHashFromServer
{
    PayuMoneySDKRequestParams *params = [PayuMoneySDKRequestParams sharedInstance];
    NSString *requestBody = [PayuMoneySDKServiceParameters prepareBodyForHash : params];
    //requestBody = [requestBody encodeString:NSUTF8StringEncoding];
    PayuMoneySDKRequestManager *request = [[PayuMoneySDKRequestManager alloc]init];
    [request hitWebServiceForURLWithPostBlock:YES isAccessTokenRequired:NO webServiceURL:SDK_Hash_Url withBody:requestBody andTag:SDK_REQUEST_HASH completionHandler:^(id object,SDK_REQUEST_TYPE tag, NSError *err)
     {
         if (err == nil) {
             if([object isKindOfClass:[NSDictionary class]])
             {
                 params.hashValue = [self checkNullValue:[object valueForKey:SDK_result]];
                
                 }
                 else
                 {
                    
                 }
                 
             }
         
     }];
}

@end
