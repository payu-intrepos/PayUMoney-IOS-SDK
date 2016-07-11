//
//  PayUsingPointsAlert.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/7/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PayUsingPointsDelegate <NSObject>
-(void)presentOtherControllerWithData;
-(void)presentSameControllerWithData;
@end

@interface PayuMoneySDKPayUsingPointsAlert : UIView
@property (weak, nonatomic) IBOutlet UILabel *LblPayUsingPoints;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseOtherMode;
@property PayuMoneySDKPayUsingPointsAlert *alertView;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;

- (IBAction)chooseOtherModeBtnClicked:(UIButton *)sender;



- (IBAction)okBtnClicked:(UIButton *)sender;
-(PayuMoneySDKPayUsingPointsAlert *)initWithFrame : (CGRect)frame;
@property id<PayUsingPointsDelegate> delegate;
@end
