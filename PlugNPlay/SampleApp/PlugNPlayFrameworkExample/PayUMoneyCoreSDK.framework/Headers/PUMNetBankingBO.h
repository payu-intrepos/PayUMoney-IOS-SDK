//
//  PUMNetBankingBO.h
//  PayUmoneyiOS_SDK
//
//  Created by Imran Khan on 7/14/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUMNetBankingBO : NSObject

@property NSString *name;
@property int pt_priority;
@property NSString *title;
@property NSString *pgId;
@property NSString *show_form;
@property NSString *bankCode;

-(PUMNetBankingBO *)initWithResponse : (id)response withKey:(NSString*)keyName;

@end
