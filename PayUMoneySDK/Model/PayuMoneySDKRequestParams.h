//
//  RequestParams.h
//  payuSDK
//
//  Created by Honey Lakhani on 8/12/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayuMoneySDKRequestParams : NSObject
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *firstname;
@property (nonatomic,strong) NSString *productinfo;
@property (nonatomic,strong) NSString *txnid;
@property (nonatomic,strong) NSString *merchantid;
@property (nonatomic,strong) NSString *surl;
@property (nonatomic,strong) NSString *furl;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *hashValue,*udf1,*udf2,*udf3,*udf4,*udf5,*key;
@property (nonatomic,strong) NSDictionary *response;
+(void)initWithDict:(NSDictionary *)dict;
+(PayuMoneySDKRequestParams *)sharedInstance;


@end
