//
//  PayUConfigBO.m
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 10/7/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import "PayUConfigBO.h"

@implementation PayUConfigBO

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.amount = @"";
        self.firstName= @"";
        self.phone= @"";
        self.emailId= @"";
        self.productInfo= @"";
        self.transactionId= @"";
        self.merchantId= @"";
        self.merchantKey= @"";
        self.merchantSalt= @"";
        self.appSURL= @"";
        self.appFURL= @"";
        self.udf1= @"";
        self.udf2= @"";
        self.udf3= @"";
        self.udf4= @"";
        self.udf5= @"";
        
    }
    return self;
}

@end
