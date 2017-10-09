//
//  CTSProfileContactRes.h
//  RestFulltester
//
//  Created by Yadnesh Wankhede on 13/06/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CTSProfileContactRes : JSONModel
@property( strong) NSString <Optional> *type;
@property( strong)  NSString <Optional> *firstName;
@property( strong)  NSString <Optional> *lastName;
@property( strong)  NSString <Optional>*email;
@property( strong)  NSString <Optional>*mobile;
@end
