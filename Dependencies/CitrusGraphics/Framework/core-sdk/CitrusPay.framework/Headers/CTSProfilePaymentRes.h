//
//  CTSProfilePaymentRes.h
//  RestFulltester
//
//  Created by Yadnesh Wankhede on 13/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSPaymentOption.h"

@interface CTSProfilePaymentRes : JSONModel
@property(  strong) NSString* type;
@property(  strong) NSString<Optional>* defaultOption;
@property(  strong) NSMutableArray<CTSPaymentOption>* paymentOptions;
- (void)getDefaultOptionOnTheTop;
- (NSArray *)getSavedNBPaymentOption;
- (NSArray *)getSavedCCPaymentOption;
- (NSArray *)getSavedDCPaymentOption;
- (CTSPaymentOption *)getDefaultOption;

-(CTSPaymentOption *)paymentOptionForToken:(NSString *)token;
-(NSDictionary *)convertPaymentOptions;
@end
