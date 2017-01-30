//
//  Utils.h
//  frameworkIntegration
//
//  Created by Honey Lakhani on 1/16/17.
//  Copyright © 2017 com.payu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
- (NSString *)getRandomString:(NSInteger)length;
- (NSString *) createSHA512:(NSString *)source;
@end

