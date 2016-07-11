//
//  CouponView.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/2/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CouponViewDelegate <NSObject>
-(void)sendSelectedCoupon : (NSDictionary *)couponDict;
@end
@interface PayuMoneySDKCouponView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *availableCouponLbl;
@property (weak, nonatomic) IBOutlet UITableView *couponTableView;
@property id<CouponViewDelegate> couponDelegate;
@property PayuMoneySDKCouponView *couponView;
- (IBAction)cancelBtnClicked:(UIButton *)sender;
- (IBAction)okBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBTn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
-(PayuMoneySDKCouponView *)initWithFrame : (CGRect)frame withArray : (NSArray *)arr;
@end
