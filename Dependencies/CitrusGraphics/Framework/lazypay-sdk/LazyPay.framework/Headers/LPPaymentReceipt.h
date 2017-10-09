//
//  LPPaymentReceipt.h
//  CitrusPay
//
//  Created by Mukesh Patil on 5/26/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 *   LPPaymentReceipt Class.
 */
@interface LPPaymentReceipt : JSONModel
/**
 *   The LPPaymentReceipt class' transactionId object.
 */
@property (strong) NSString <Optional> * transactionId;
/**
 *   The LPPaymentReceipt class' merchantOrderId object.
 */
@property (strong) NSString <Optional> * merchantOrderId;
/**
 *   The LPPaymentReceipt class' amount object.
 */
@property (strong) NSString <Optional> * amount;
/**
 *   The LPPaymentReceipt class' currency object.
 */
@property (strong) NSString <Optional> * currency;
/**
 *   The LPPaymentReceipt class' signature object.
 */
@property (strong) NSString <Optional> * signature;
/**
 *   The LPPaymentReceipt class' token object.
 */
@property (strong) NSDictionary <Optional> * token;
/**
 *   The LPPaymentReceipt class' responseData object.
 */
@property (strong) NSDictionary * responseData;
@end
