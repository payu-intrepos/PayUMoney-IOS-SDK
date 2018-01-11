//
//  PUMTxnParam.h
//  PayUmoney_SDK
//
//  Created by Umang Arya on 5/10/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUMConstants.h"

@interface PUMTxnParam : NSObject

@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *merchantid;
@property (nonatomic,strong) NSString *txnID;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *firstname;
@property (nonatomic,strong) NSString *surl;
@property (nonatomic,strong) NSString *furl;
@property (nonatomic,strong) NSString *productInfo;

@property (nonatomic,assign) PUMEnvironment environment;

@property (nonatomic,strong) NSString *udf1;
@property (nonatomic,strong) NSString *udf2;
@property (nonatomic,strong) NSString *udf3;
@property (nonatomic,strong) NSString *udf4;
@property (nonatomic,strong) NSString *udf5;
@property (nonatomic,strong) NSString *udf6;
@property (nonatomic,strong) NSString *udf7;
@property (nonatomic,strong) NSString *udf8;
@property (nonatomic,strong) NSString *udf9;
@property (nonatomic,strong) NSString *udf10;

@property (nonatomic,strong) NSString *hashValue;

@end
