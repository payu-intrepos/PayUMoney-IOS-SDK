//
//  CTSRestPluginBase.h
//  CTSRestKit
//
//  Created by Yadnesh Wankhede on 30/07/14.
//  Copyright (c) 2014 CitrusPay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTSRestCore.h"

@class CTSKeyStore, CTSDataCache;

#define toNSString(cts) [NSString stringWithFormat:@"%d", cts]
#define toLongNSString(cts) [NSString stringWithFormat:@"%ld", cts]

#define toSelector(cts) [NSValue valueWithPointer:@selector(cts)]

@interface CTSRestPluginBase : NSObject<CTSRestCoreDelegate> {
  NSDictionary* requestSelectorMap;
  NSMutableDictionary* dataCache;
  long cacheId;
  CTSRestCore* restCore;
  CTSKeyStore *keystore;
  CTSDataCache *ctsCache;
}
@property(strong) NSMutableDictionary* requestBlockCallbackMap;


- (instancetype)initWithRequestSelectorMapping:(NSDictionary*)mapping
                                       baseUrl:(NSString*)baseUrl
                                      keyStore:(CTSKeyStore *)keyStoreArg;
- (instancetype)initWithRequestSelectorMapping:(NSDictionary*)mapping
baseUrl:(NSString*)baseUrl;
- (void)addCallback:(id)callBack forRequestId:(int)reqId;
- (id)retrieveAndRemoveCallbackForReqId:(int)reqId;
- (id)retrieveCallbackForReqId:(int)reqId;
-(void)setKeyStore:(CTSKeyStore *)keyStoreArg;
- (void)cacheData:(id)object key:(NSString *)key;
- (id)fetchCachedDataForKey:(NSString *)key;
- (id)fetchAndRemovedCachedDataForKey:(NSString *)index;
- (NSString *)fetchBaseUrl;
//-(long)addDataToCacheAtAutoIndex:(id)object;
-(CTSKeyStore *)keyStore;
-(CTSKeyStore *)cachedKeyStore;

@end
