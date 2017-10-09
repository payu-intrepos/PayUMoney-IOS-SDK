//
//  LPChekEligibility.h
//  CitrusPay
//
//  Created by Mukesh Patil on 5/26/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 *   LPChekEligibility Class.
 */
@interface LPChekEligibility : JSONModel
/**
 *   The LPChekEligibility class' reason object.
 */
@property (strong) NSString * reason;
/**
 *   The LPChekEligibility class' code object.
 */
@property (strong) NSString * code;
/**
 *   The LPChekEligibility class' txnEligibility object.
 */
@property (assign) BOOL txnEligibility;
/**
 *   The LPChekEligibility class' userEligibility object.
 */
@property (assign) BOOL userEligibility;
/**
 *   The LPChekEligibility class' emailRequired object.
 */
@property (assign) BOOL emailRequired;
/**
 *   The LPChekEligibility class' autoDebit object.
 */
@property (assign) BOOL autoDebit;
/**
 *   The LPChekEligibility class' signUpModes object.
 */
@property (strong) NSArray * signUpModes;
/**
 *   The LPChekEligibility class' merchantLogo object.
 */
@property (strong) NSString * merchantLogo;

@end
