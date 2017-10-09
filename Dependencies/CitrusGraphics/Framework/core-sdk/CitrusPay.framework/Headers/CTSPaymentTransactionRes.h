//
//  CTSPaymentTransactionRes.h
//  RestFulltester
//
//  Created by Raji Nair on 26/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSPaymentTransactionRes : JSONModel
@property( strong) NSString* redirectUrl;
@property( strong) NSString<Optional>* pgRespCode;
@property( strong) NSString<Optional>* txMsg;


@end
