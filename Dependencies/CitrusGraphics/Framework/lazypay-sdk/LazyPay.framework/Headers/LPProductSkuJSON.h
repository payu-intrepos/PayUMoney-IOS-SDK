//
//  LPProductSkuJSON.h
//  CitrusPay
//
//  Created by Mukesh Patil on 6/23/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "LPProductAttributes.h"
#import "LPProductSkus.h"

/**
 *   LPProductSkuJSON Class.
 */
@interface LPProductSkuJSON : JSONModel
/**
 *   The LPProductSkuJSON class' productId object.
 */
@property (strong) NSString <Optional> * productId;
/**
 *   The LPProductSkuJSON class' _description object.
 */
@property (strong) NSString <Optional> * _description;
/**
 *   The LPProductSkuJSON class' imageUrl object.
 */
@property (strong) NSString <Optional> * imageUrl;
/**
 *   The LPProductSkuJSON class' shippable object.
 */
@property (strong) NSString <Optional> * shippable;
/**
 *   The LPProductSkuJSON class' attributes object.
 */
@property (strong) LPProductAttributes< Optional> * attributes;
/**
 *   The LPProductSkuJSON class' skus object.
 */
@property (strong) NSMutableArray <LPProductSkus *> * skus;
@end
