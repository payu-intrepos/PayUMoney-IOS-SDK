//
//  LPUserAddress.h
//  LazyPay
//
//  Created by Mukesh Patil on 8/12/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 *   LPUserAddress Class.
 */
@interface LPUserAddress : JSONModel
/**
 *   The LPUserAddress class' city object.
 */
@property (strong) NSString <Optional> * city;
/**
 *   The LPUserAddress class' country object.
 */
@property (strong) NSString <Optional> * country;
/**
 *   The LPUserAddress class' state object.
 */
@property (strong) NSString <Optional> * state;
/**
 *   The LPUserAddress class' street1 object.
 */
@property (strong) NSString <Optional> * street1;
/**
 *   The LPUserAddress class' street2 object.
 */
@property (strong) NSString <Optional> * street2;
/**
 *   The LPUserAddress class' zip object.
 */
@property (strong) NSString <Optional> * zip;
@end
