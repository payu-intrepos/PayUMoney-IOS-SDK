//
//  PayUConfigBO.h
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 10/7/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayUConfigBO : NSObject


@property(nonatomic,strong) NSString *amount;
@property(nonatomic,strong) NSString *firstName;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *emailId;
@property(nonatomic,strong) NSString *productInfo;
@property(nonatomic,strong) NSString *transactionId;

@property(nonatomic,strong) NSString *merchantId;
@property(nonatomic,strong) NSString *merchantKey;
@property(nonatomic,strong) NSString *merchantSalt;
@property(nonatomic,strong) NSString *appSURL;
@property(nonatomic,strong) NSString *appFURL;
@property(nonatomic,strong) NSString *udf1;
@property(nonatomic,strong) NSString *udf2;
@property(nonatomic,strong) NSString *udf3;
@property(nonatomic,strong) NSString *udf4;
@property(nonatomic,strong) NSString *udf5;



@end
