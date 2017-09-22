//
//  ActivityView.h
//  PayuMoneyApp
//
//  Created by Honey Lakhani on 7/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PUMActivityView : UIView
@property(nonatomic,strong,readonly) UIView *borderView;
@property(nonatomic,strong,readonly) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic,strong,readonly) UILabel *activityLabel;
@property(nonatomic) NSUInteger labelWidth;
@property(nonatomic) BOOL showNetworkActivityIndicator;

+(PUMActivityView *)currentActivityView;

+ (PUMActivityView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText;

+ (PUMActivityView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText width:(NSUInteger)aLabelWidth;

- (PUMActivityView *)initForView:(UIView *)addToView withLabel:(NSString *)labelText width:(NSUInteger)aLabelWidth;

+ (void)showLoader;
+ (void)showLoaderWithTitle:(NSString*)title;

+ (void)removeView;
+ (void)removeViewAnimated:(BOOL)animated;

@end
