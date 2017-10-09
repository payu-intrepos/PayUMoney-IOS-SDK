//
//  LPProductAttributes.h
//  CitrusPay
//
//  Created by Mukesh Patil on 5/26/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 *   LPProductAttributes Class.
 */
@interface LPProductAttributes : JSONModel
/**
 *   The LPProductAttributes class' size object.
 */
@property (strong) NSString <Optional> * size;
/**
 *   The LPProductAttributes class' color object.
 */
@property (strong) NSString <Optional> * color;
@end
