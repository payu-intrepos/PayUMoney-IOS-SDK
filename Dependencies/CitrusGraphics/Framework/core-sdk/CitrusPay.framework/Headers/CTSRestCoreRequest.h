//
//  CTSRestRequest.h
//  CTSRestKit
//
//  Created by Yadnesh Wankhede on 30/07/14.
//  Copyright (c) 2014 CitrusPay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RestLayerConstants.h"

@interface CTSRestCoreRequest : NSObject
@property(strong) NSString* requestJson, *urlPath;
@property(strong) NSMutableDictionary* parameters, *headers;
@property(assign) int requestId;
@property(assign) HTTPMethod httpMethod;
@property(assign) long index;
@property(assign) BOOL isAlternatePath;

- (instancetype)initWithPath:(NSString*)path
                   requestId:(int)reqId
                     headers:(NSDictionary*)reqHeaders
                  parameters:(NSDictionary*)params
                        json:(NSString*)json
                  httpMethod:(HTTPMethod)method;

- (instancetype)initWithPath:(NSString*)path
                   requestId:(int)reqId
                     headers:(NSDictionary*)reqHeaders
                  parameters:(NSDictionary*)params
                        json:(NSString*)json
                  httpMethod:(HTTPMethod)method
                   dataIndex:(long)index;

@end
