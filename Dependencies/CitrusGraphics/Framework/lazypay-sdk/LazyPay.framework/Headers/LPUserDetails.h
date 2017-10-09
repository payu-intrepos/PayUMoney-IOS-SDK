//
//  LPUserDetails.h
//  CitrusPay
//
//  Created by Mukesh Patil on 5/26/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 *   LPUserDetails Class.
 */
@interface LPUserDetails : JSONModel
/**
 *   The LPUserDetails class' email object.
 */
@property (strong)  NSString <Optional> * email;
/**
 *   The LPUserDetails class' mobile object.
 */
@property (strong)  NSString <Optional> * mobile;
@end
