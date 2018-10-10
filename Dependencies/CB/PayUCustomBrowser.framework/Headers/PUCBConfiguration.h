//
//  PUCBSharedDataManager.h
//  PayUNonSeamlessTestApp
//
//  Created by Sharad Goyal on 10/03/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CBConstant.h"
#import "PUCBReviewOrderConfig.h"

/*!
 * This class is used to store some data that is available for all classes.
 */
@interface PUCBConfiguration : NSObject

/*!
 * This method returns singleton object. Use this to configure features provided by CB
 * @return obj The singleton sintance of PUCBConfiguration class
 */
+(instancetype)getSingletonInstance;

+(instancetype) alloc ATTRIBUTE_ALLOC;
-(instancetype) init  ATTRIBUTE_INIT;
+(instancetype) new   ATTRIBUTE_NEW;
+(instancetype) copy  ATTRIBUTE_INIT;

@property (nonatomic, strong) NSString *merchantKey;
@property (nonatomic, strong) NSString *transactionId;
@property (nonatomic, assign) BOOL isMagicRetry;
@property (nonatomic, assign) BOOL isAutoOTPSelect;
@property (nonatomic, assign) BOOL shouldShowPayULoader;
@property (nonatomic, assign) BOOL enableWKWebView;
@property (nonatomic, assign) PUCBBankSimulator bankSimulatorType;
@property (nonatomic, strong) PUCBReviewOrderConfig *reviewOrderConfig;
@property (nonatomic, assign) NSUInteger surePayCount;
@property (nonatomic, strong) NSString *paymentURL, *paymentPostParam;

@property (nonatomic, strong) NSString *htmlData;
@property (nonatomic, assign) NSTimeInterval merchantResponseTimeout; //Default timeout is 5 seconds.

@end

