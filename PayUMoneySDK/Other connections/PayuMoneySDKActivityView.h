//
//  ActivityView.h
//  PayuMoneyApp
//
//  Created by Honey Lakhani on 7/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayuMoneySDKActivityView : UIView
@property(nonatomic,strong,readonly) UIView *borderView;
@property(nonatomic,strong,readonly) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic,strong,readonly) UILabel *activityLabel;
@property(nonatomic) NSUInteger labelWidth;
@property(nonatomic) BOOL showNetworkActivityIndicator;
+(PayuMoneySDKActivityView *)currentActivityView;
+ (PayuMoneySDKActivityView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText;


+ (PayuMoneySDKActivityView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText width:(NSUInteger)aLabelWidth;

- (PayuMoneySDKActivityView *)initForView:(UIView *)addToView withLabel:(NSString *)labelText width:(NSUInteger)aLabelWidth;

+ (void)removeView;
+ (void)removeViewAnimated:(BOOL)animated;


@end
