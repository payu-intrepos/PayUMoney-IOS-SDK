//
//  LPProductSkuDetails.h
//  CitrusPay
//
//  Created by Mukesh Patil on 5/26/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "LPProductSkuJSON.h"

/**
 *   LPProductSkuDetails Class.
 */
@interface LPProductSkuDetails : JSONModel
/**
 *   The LPProductSkuDetails class' productSkuDetails object.
 */
@property (strong) NSMutableArray <LPProductSkuJSON *> <Optional> * productSkuDetails;
@end
