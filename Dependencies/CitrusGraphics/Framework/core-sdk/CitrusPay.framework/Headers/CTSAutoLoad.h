//
//  CTSAutoLoad.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 09/02/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 Autoload amount data class
 */
@interface CTSAutoLoad : NSObject
@property (atomic,strong)NSString *autoLoadAmt;
@property (atomic,strong)NSString *thresholdAmount;
@end
