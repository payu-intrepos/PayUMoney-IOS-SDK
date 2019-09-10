//
//  PUMValidations.h
//  PayUmoney_SampleApp
//
//  Created by Vipin Aggarwal on 15/11/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUMValidations : NSObject

/*!
 * This method checks the if received object is a string which can be consumed by PayUmoney sdk
 */
+ (BOOL)isValidString:(id)content;

@end
