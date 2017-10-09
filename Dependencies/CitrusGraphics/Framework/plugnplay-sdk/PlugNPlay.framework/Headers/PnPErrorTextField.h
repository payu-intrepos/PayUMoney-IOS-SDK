//
//  PnPErrorTextField.h
//  PlugNPlay
//
//  Created by Yadnesh Wankhede on 10/1/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CitrusPay/CitrusPay.h>

IB_DESIGNABLE
@interface PnPErrorTextField : UITextField

IBInspectable
@property(nonatomic,strong)UILabel *lblError;
IBInspectable
@property(nonatomic,strong)UIView *viewSepratorLine;

-(void)showErrorWithText:(NSString*)str;
-(void)hideError;
-(void)addBottomLineWithWidthConstarint:(CGFloat)widthPercentage;
@end
