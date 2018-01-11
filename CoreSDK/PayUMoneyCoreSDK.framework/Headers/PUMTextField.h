//
//  PUMTextField.h
//  PayUmoney_SampleApp
//
//  Created by Honey Lakhani on 11/4/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PUMTextField : UITextField
-(void)setBorderWithBorderWidth : (CGFloat)borderWidth borderColor :(UIColor *)color cornerRadius : (CGFloat)radius;
-(void)setLeftImageViewWithImageName : (NSString *)imgName;
-(void)setRightImageViewWithImageName : (NSString *)imgName isHidden : (BOOL)hidden;

@end
