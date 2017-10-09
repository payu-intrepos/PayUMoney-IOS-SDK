//
//  CTSSimpliChargeDistribution.h
//  CitrusPay
//
//  Created by Mukesh Patil on 5/13/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 *   The CTSSimpliChargeDistribution class.
 */
@interface CTSSimpliChargeDistribution : JSONModel
/**
 *   The CTSSimpliChargeDistribution class' mvcAmount object.
 */
@property (strong) NSString <Optional> * mvcAmount;
/**
 *   The CTSSimpliChargeDistribution class' cashAmount object.
 */
@property (strong) NSString <Optional> * cashAmount;
/**
 *   The CTSSimpliChargeDistribution class' remainingAmount object.
 */
@property (strong) NSString <Optional> * remainingAmount;
/**
 *   The CTSSimpliChargeDistribution class' totalAmount object.
 */
@property (strong) NSString <Optional> * totalAmount;
/**
 *   The CTSSimpliChargeDistribution class' useMVC object.
 */
@property (assign) BOOL useMVC;
/**
 *   The CTSSimpliChargeDistribution class' useCash object.
 */
@property (assign) BOOL useCash;
/**
 *   The CTSSimpliChargeDistribution class' enoughMVCAndCash object.
 */
@property (assign) BOOL enoughMVCAndCash;
@end
