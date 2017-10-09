//
//  LPProductSkus.h
//  CitrusPay
//
//  Created by Mukesh Patil on 5/26/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "LPProductAttributes.h"

/**
 *   LPProductSkus Class.
 */
@interface LPProductSkus : JSONModel
/**
 *   The LPProductSkus class' skuId object.
 */
@property (strong) NSString <Optional> * skuId;
/**
 *   The LPProductSkus class' price object.
 */
@property (strong) NSString <Optional> * price;
/**
 *   The LPProductSkus class' attributes object.
 */
@property (strong) LPProductAttributes <Optional> * attributes;
@end
