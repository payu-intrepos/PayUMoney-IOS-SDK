//
//  NetBanking.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/16/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayuSDKTextField.h"
@protocol NetBankingDelegate <NSObject>
-(void)goToPayment : ( NSDictionary *)data : (NSString *)mode;
-(void)changeTableContentOffset : (CGFloat)value;

@end
@interface PayuMoneySDKNetBanking : UIView
@property (weak, nonatomic) IBOutlet PayuSDKTextField *selectBankTextField;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property PayuMoneySDKNetBanking *nbView;
@property int loc;
- (IBAction)payNowBtnClicked:(UIButton *)sender;
-(PayuMoneySDKNetBanking *)initWithList : (NSArray *)bankDetails withFrame : (CGRect)frame;
@property id<NetBankingDelegate> nbDelegate;
@end
