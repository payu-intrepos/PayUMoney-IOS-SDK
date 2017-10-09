//
//  CTSPaymentReceipt.h
//  CitrusPay
//
//  Created by Mukesh Patil on 1/29/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 *   CTSPaymentReceipt Class.
 */
@interface CTSPaymentReceipt : JSONModel
/**
 *   The CTSPaymentReceipt class' toDictionary object.
 */
@property (strong) NSMutableDictionary *toDictionary;
-(BOOL)isSuccess;
-(NSString *)transactionStatus;
-(NSString *)transactionId;
-(NSString *)transactionMessage;
-(NSString *)transactionRefNumber;
@end
