//
//  PaymentUsingWallet.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/21/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayuMoneySDKWebViewViewController.h"
@protocol PaymentUsingWalletDelegate <NSObject>
-(void)backToPaymentContollerWithWebView : (PayuMoneySDKWebViewViewController *)webView;
@end
@interface PayuMoneySDKPaymentUsingWallet : UIView
@property (weak, nonatomic) IBOutlet UILabel *LblPayUsingWallet;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UILabel *reaminingWalletMoneyLbl;
- (IBAction)okBtnClicked:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UILabel *walletMoneyUsedLbl;
@property PayuMoneySDKPaymentUsingWallet *payWallet;

-(PayuMoneySDKPaymentUsingWallet *)initWithFrame : (CGRect)frame withResponse : (NSDictionary *)response withCoupon : (NSDictionary *)  coupon   withWalletUsage : (float)walletUse withConvenienceFee : (float)fee withPoints : (NSString *)points;
@property id<PaymentUsingWalletDelegate> delegate;
@end
