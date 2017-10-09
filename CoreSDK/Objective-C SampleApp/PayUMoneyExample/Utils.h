//
//  Utils.h
//  PayUMoneyExample
//
//  Created by Umang Arya on 7/2/17.
//  Copyright © 2017 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>

@interface Utils : NSObject

+ (NSString *)getTxnID;

+ (NSString*)getHashForTxnParams:(PUMTxnParam*)txnParam salt:(NSString *)salt;

+ (void)showMsgWithTitle:(NSString *)title message:(NSString *)message;

@end
