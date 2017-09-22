//
//  PUMSaveCardBO.h
//  PayUmoneyiOS_SDK
//
//  Created by Imran Khan on 8/1/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUMSaveCardBO : NSObject

@property NSString *cardId;
@property NSString *cardName;
@property NSString *cardToken;
@property NSString *cardType;
@property NSString *ccnum;
@property NSString *oneclickcheckout;
@property NSString *pg;
@property NSString *rewardType;
@property NSString *cvv;

-(PUMSaveCardBO *)initWithResponse : (id)response ;

@end
