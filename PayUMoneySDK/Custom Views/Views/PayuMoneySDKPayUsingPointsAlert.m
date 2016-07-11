//
//  PayUsingPointsAlert.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKPayUsingPointsAlert.h"
//#import "PayUsingPointsViewController.h"

@implementation PayuMoneySDKPayUsingPointsAlert

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(PayuMoneySDKPayUsingPointsAlert *)initWithFrame : (CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.alertView = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKPayUsingPointsAlert" owner:self options:nil]firstObject];
        self.alertView.frame = CGRectMake(0, 0, frame.size.width, 300);
        if(CGRectIsEmpty(frame))
                self.bounds = self.alertView.bounds;
        self.LblPayUsingPoints.font = SDK_FONT_BOLD(17.0);
        [self.btnChooseOtherMode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnChooseOtherMode.layer.cornerRadius = 3.0;
        [self.btnOk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnOk.layer.cornerRadius = 3.0;
        [self addSubview:self.alertView];
    }
    return self;
}

- (IBAction)chooseOtherModeBtnClicked:(UIButton *)sender {
//    UITableView *tableView = (UITableView *)self.superview.superview;
//    [tableView setScrollEnabled:YES];

    [self.superview removeFromSuperview];
    [self removeFromSuperview];
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(presentSameControllerWithData)])
    {
        [self.delegate presentSameControllerWithData];
    }
}


- (IBAction)okBtnClicked:(UIButton *)sender {
//    
//    [self.alertView removeFromSuperview];
//    UITableView *tableView = (UITableView *)self.superview.superview;
//    [tableView setScrollEnabled:YES];

    
  if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(presentOtherControllerWithData)])
  {
      [self.delegate presentOtherControllerWithData];
  }
}
@end
