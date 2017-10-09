//
//  LazyPayConfig.h
//  CitrusLazyPay
//
//  Created by Mukesh Patil on 8/8/16.
//  Copyright © 2016 Citrus Payment Solutions Private Limited. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "LPProductSkuDetails.h"
#import "LPUserDetails.h"
#import "LPUserAddress.h"

@interface NSArray (LazyPayConfig)
/**
 *  toLPProductSkuDetail.
 *
 *  @return The LPProductSkuDetails Value.
 */
- (LPProductSkuDetails *)toLPProductSkuDetail;
/**
 *  isValidJSON.
 *
 *  @return The NSError Value.
 */
- (NSError *)isValidJSON;
@end
/**
 *   LazyPayConfig Class.
 */
@interface LazyPayConfig : JSONModel
/**
 *   The LazyPayConfig class' amount object.
 */
@property (nonatomic) float amount;
/**
 *   The LazyPayConfig class' billUrl object.
 */
@property (strong) NSString * billUrl;
/**
 *   The LazyPayConfig class' productSkuDetails object.
 */
@property (strong) NSMutableArray <LPProductSkuDetails *> <Optional> * productSkuDetails;
/**
 *   The LazyPayConfig class' userDetails object.
 */
@property (strong) LPUserDetails * userDetails;
/**
 *   The LazyPayConfig class' userAddress object.
 */
@property (strong) LPUserAddress <Optional> * userAddress;
/**
 *  lazyPayConfig The Configure LazyPay Request
 *
 *  @param amount  The Transaction Amount
 *  @param billUrl  The Bill Url
 *  @param productSkuDetails The productSkuDetails
 *  @param userDetails  The User Details
 *  @param userAddress  The User Address
 */
+ (LazyPayConfig *)lazyPayConfig:(float)amount
                         billUrl:(NSString *)billUrl
               productSkuDetails:(NSArray <LPProductSkuDetails *> <Optional> *)productSkuDetails
                            user:(LPUserDetails *)userDetails
                         address:(LPUserAddress *)userAddress;
@end
