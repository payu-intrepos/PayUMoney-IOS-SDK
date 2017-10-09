//
//  PlugAndPlayPayment.h
//  PlugNPlay
//
//  Created by Yadnesh Wankhede on 9/19/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlugAndPlayPayment : NSObject
@property (strong) id billUrlOrCTSBillObject;
@property (strong) NSString *payAmount;
@property (strong) NSString *loadMoneyUrl;

@end
