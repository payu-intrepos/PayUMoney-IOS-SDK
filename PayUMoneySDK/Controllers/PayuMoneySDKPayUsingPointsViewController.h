//
//  PayUsingPointsViewController.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseViewController.h"
@interface PayuMoneySDKPayUsingPointsViewController :UIViewController

 @property   NSString *amount, *discount,*netAmount,*totalPoints;
@property double convenienceCharge;
@property (weak, nonatomic) IBOutlet UILabel *netAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *convenienceChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property BOOL fromApp;
- (IBAction)payNowBtnClicked:(id)sender;
@property NSString *type;
@property NSDictionary *responseDict,*couponApplied;
@property (weak, nonatomic) IBOutlet UIButton *payNowBtn;

@end
