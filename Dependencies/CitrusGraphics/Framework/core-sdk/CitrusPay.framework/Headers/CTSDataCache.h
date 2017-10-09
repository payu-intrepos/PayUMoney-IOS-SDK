//
//  CTSDataCache.h
//  CTS iOS Sdk
//
//  Created by Yadnesh on 8/31/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const CACHE_KEY_KEY_STORE;
extern NSString * const CACHE_KEY_ENV;
extern NSString * const BASE_URL;
extern NSString * const DP_BASE_URL;
extern NSString * const NEW_PAYMENT_BASE_URL;
extern NSString * const BANK_LOGO_KEY;
extern NSString * const BANK_LOGO_WITH_BANK_NAME_KEY;
extern NSString * const SCHEME_LOGO_KEY;
extern NSString * const CACHE_KEY_DP_BILL;
extern NSString * const CACHE_KEY_DP_RESPONSE;
extern NSString * const CACHE_KEY_DP_PAYMENT_INFO;
extern NSString * const CACHE_KEY_DP_USER_INFO;
extern NSString * const CACHE_KEY_DP_BILL;
extern NSString * const CACHE_KEY_CITRUS_LINK;
extern NSString * const CACHE_KEY_ONE_TAP_PAYMENT;
extern NSString * const CACHE_KEY_PUSH_VIEW_CONTROLLER;
extern NSString * const CACHE_KEY_LOADER_OVERLAY;
extern NSString * const CACHE_KEY_LOADER_COLOR;
extern NSString * const CACHE_KEY_SAVED_PAYMENT_OPTIONS;
extern NSString * const CACHE_KEY_PG_SETTINGS;
extern NSString * const CACHE_KEY_MASTER_CITRUS_LINK;
extern NSString * const CACHE_KEY_LOAD_PG_SETTINGS;
extern NSString * const CACHE_KEY_IS_AUTO_LOAD_TX;
extern NSString * const CACHE_KEY_PREPAID_BILL;
extern NSString * const ISSUER_CODES_TO_BANK_NAMES;
extern NSString * const IFSC_CODE_TO_ISSUER_CODE;

//Plug And Play Cache
extern NSString *const PNP_CACHE_KEY_USER;
extern NSString *const PNP_CACHE_KEY_PAYMENT_DISTRIBUTION;
extern NSString *const PNP_SELECTED_BANK_CODE;
extern NSString *const PNP_SELECTED_PAY_TYPE;
extern NSString *const PNP_MERCHANT_PG_SETTINGS;
extern NSString *const PNP_WALLET_PROFILE;

extern NSString *const PNP_TOP_BAR_COLOR;
extern NSString *const PNP_TOP_TEXT_COLOR;
extern NSString *const PNP_BUTTON_COLOR;
extern NSString *const PNP_BUTTON_TEXT_COLOR;
extern NSString *const PNP_INDICATOR_TINT_COLOR;

extern NSString *const PNP_MERCHANT_DISPLAY_NAME;
extern NSString *const PNP_PAYMENT_RESPONSE;
extern NSString *const PNP_PAYMENT_PROPERTIES;
extern NSString *const PNP_PAYMENT_COMPLETION;
extern NSString *const PNP_RETURNVC;
extern NSString *const PNP_DISABLE_COMPLETION_SCREEN;
extern NSString *const PNP_PAYMENT_RESPONSE_ERROR;
extern NSString *const PNP_SHOULD_RELOAD_WALLET;
extern NSString *const PNP_SHOULD_RELOAD_AUTOLOAD;
extern NSString *const PNP_SHOULD_RELOAD_WITHDRAWMONEY;
extern NSString *const PNP_AUTO_LOAD_CONSUMER_DETAILS;
extern NSString *const PNP_AUTOLOAD_SUBSCRIPTION;

extern NSString *const PNP_DISABLE_WALLET;
extern NSString *const PNP_DISABLE_CARDS;
extern NSString *const PNP_DISABLE_NETBANK;
extern NSString *const PNP_LOAD_RETURN_URL;

extern NSString *const PNP_LOADMONEY_CUSTOM_PARAMS;








//End Plug And Play Cache




extern NSString * const CACHE_KEY_BLAZECARD_PAYMENT;
extern NSString * const CACHE_KEY_BLAZENET_PAYMENT;


@interface CTSDataCache : NSObject
@property(strong)NSMutableDictionary *cache;
+ (id)sharedCache;
+(id)fetchFromSharedCache:(NSString *)key;
- (void)cacheData:(id)object key:(NSString *)index;
- (id)fetchCachedDataForKey:(NSString *)index ;
- (id)fetchAndRemovedCachedDataForKey:(NSString *)index;
@end
