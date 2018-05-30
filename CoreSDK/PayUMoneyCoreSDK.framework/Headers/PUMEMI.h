//
//  PUMEMI.h
//  PayUMoneyCoreSDK
//
//  Created by Rajvinder Singh on 3/23/18.
//  Copyright © 2018 PayU Payments Private Limited. All rights reserved.
//

#import "PUMCCDC.h"

@interface PUMEMI : PUMCCDC

/// eg., AXIS, HDFC, SBI etc
@property (strong, nonatomic) NSString *bankCode;

/// eg., AXIS03, AXIS06, HDFC03, HDFC09 etc
@property (strong, nonatomic) NSString *emiType;

@property (assign, nonatomic) BOOL isCreditCard;

@end
