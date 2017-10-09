//
//  LeftRightStrip.h
//  DemoLayout
//
//  Created by Yadnesh Wankhede on 15/06/16.
//  Copyright © 2016 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftRightStrip : UIView

@property(nonatomic ,strong)UILabel *LBL_LEFT;
@property(nonatomic ,strong)UILabel *LBL_RIGHT;
@property(nonatomic ,strong)UIImageView *ImgeViewSelected;
@property(nonatomic ,strong)UIButton *button;
@property BOOL isButtonRequired;

-(id)initWithLeftString:(NSString*)leftString
         andRightString:(NSString*)rightString;
-(void)toggleSelection;
-(void)select;
-(void)unselect;
-(void)active:(BOOL)isActive;
@end
