//
//  CTSDPMerchantQueryReq.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 10/20/15.
//  Copyright © 2015 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>



/**
 Dp merchant query request data
 */
@interface CTSDPMerchantQueryReq : JSONModel
@property(strong)NSString *merchantAccessKey,*signature;
@end
