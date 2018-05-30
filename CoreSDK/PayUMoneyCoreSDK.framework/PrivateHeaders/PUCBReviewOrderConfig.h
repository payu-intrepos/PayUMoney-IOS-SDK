//
//  PUCBReviewOrderConfig.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 11/18/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBConstant.h"

@interface PUCBReviewOrderConfig : NSObject


NS_ENUM(NSInteger)
{
    PUCBROArrForReviewOrderUndefined = 		101,
    PUCBROCustomReviewOrderUndefined = 		102
};

-(instancetype) init ATTRIBUTE_INIT;
+(instancetype) new ATTRIBUTE_NEW;

@property (nonatomic,readonly) NSArray <NSDictionary*> *arrForReviewOrder;
@property (nonatomic, readonly) UIView *vwCustomReviewOrder;

@property (nonatomic, strong) NSString *btnText;
@property (nonatomic, strong) UIColor *btnBGColor;
@property (nonatomic, strong) UIColor *btnTxtColor;

@property (nonatomic, strong) NSString *ReviewOrderHeaderForDefaultView;
-(instancetype)initWithArrForReviewOrder:( NSArray *) arrForReviewOrder
                                   error:(NSError **) error;

-(instancetype)initWithCustomView:(UIView *) vwCustomReviewOrder
                            error:(NSError **) error;
@end
