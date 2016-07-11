//
//  PayuRequestManager.m
//  PayuMoney
//
//  Created by Imran Khan on 10/5/15.
//  Copyright © 2015 PayuMoney. All rights reserved.
//

#import "PayuMoneySDKRequestManager.h"

#define REQUEST_TIMEOUT 60.0

@implementation PayuMoneySDKRequestManager

    
-(void)hitWebServiceForURLWithPostBlock:(BOOL)isPost isAccessTokenRequired:(BOOL)tokenRequired webServiceURL:(NSString *)apiURL withBody:(NSString *)requestBody andTag:(SDK_REQUEST_TYPE)tag completionHandler:(void (^)(id, SDK_REQUEST_TYPE, NSError *))callback
{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSString *strMainURL;
    if (tag != SDK_REQUEST_HASH && tag != SDK_REQUEST_CARD_ONE_CLICK ) {
       strMainURL = SDK_BASE_URL(apiURL);
    }
    else
    {
        strMainURL = apiURL;
    
    }
    
    if(requestBody){
        if ([apiURL isEqual:Cancel_Transaction_URL]) {
    strMainURL = [NSString stringWithFormat:@"%@?%@",strMainURL,requestBody];
        }
        else
        {
            if (tag!=SDK_REQUEST_HASH) {
            
            NSString *additionalNewParams = [NSString stringWithFormat:@"&isMobile=1&platform=iOS&appVersionCode=%@&deviceId=%@",[PayuMoneySDKAppConstant appVersionNew],[[PayuMoneySDKAppConstant sharedInstance] appUniqueID]];

        requestBody = [requestBody stringByAppendingString:additionalNewParams];

        if([apiURL isEqual:Get_Payment_Merchant_URL]){
            strMainURL = [NSString stringWithFormat:@"%@/%@",strMainURL,requestBody];
        }
//        else{
//    strMainURL = [NSString stringWithFormat:@"%@?%@",BASE_URL(apiURL),requestBody];
//        }
    }
        }
        
    }
    
    strMainURL = [strMainURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"SERVICE URL = %@",strMainURL);

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL
                                                                            URLWithString:strMainURL]];
    [urlRequest setHTTPMethod:isPost?@"POST":@"GET"];
    
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"PayUMoneyiOSAPP" forHTTPHeaderField:@"User-Agent"];
    

    if (isPost) {
        
        
        [urlRequest setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if(tokenRequired)
    {
        NSString *accessTokenForAuthorization = [NSString stringWithFormat:@"Bearer %@",[[PayuMoneySDKAppConstant sharedInstance] accessToken]];
        // TODO
        // dummy authorization for now 
        if ([[PayuMoneySDKAppConstant sharedInstance] accessToken] == nil) {
            accessTokenForAuthorization =@"Bearer 5e873489-ad9e-44c5-b6c2-27678f0b8078";
        }
        [urlRequest setValue:accessTokenForAuthorization forHTTPHeaderField:@"Authorization"];
        
        
    }
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSHTTPURLResponse *httpResponse  = (NSHTTPURLResponse*)response;
                                                           
                                                           NSLog(@"SERVER RESPONSE = %@",httpResponse.description);

                                                           if(error ==  nil){
                                                               NSError *parserError = nil;
                                                               id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parserError];
                                                               NSLog(@"Response:%@", object);

                                                               if(parserError == nil){
                                                                   callback(object,tag,error);
                                                               }
                                                               else{
                                                                   NSLog(@"Parser Error:%@", parserError.localizedDescription);

                                                                   callback(nil,tag,parserError);
                                                               }
                                                           }
                                                           else{
                                                               NSLog(@"Server Error:%@", error.localizedDescription);
                                                               callback(nil,tag,error);
                                                           }

                                                       }];
    [dataTask resume];
    
}

@end
