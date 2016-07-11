//
//  PaymentBreakdown.h
//  payuSDK
//
//  Created by Honey Lakhani on 8/18/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayuMoneySDKPaymentBreakdown : UIView
@property (weak, nonatomic) IBOutlet UILabel *paymentDetailsLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderAmount;
@property (weak, nonatomic) IBOutlet UILabel *convenienceAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
//@property (weak, nonatomic) IBOutlet UILabel *discount;
//@property (weak, nonatomic) IBOutlet UILabel *points;
//@property (weak, nonatomic) IBOutlet UILabel *netAmount;
//@property (weak, nonatomic) IBOutlet UILabel *couponDisLbl;
//@property (weak, nonatomic) IBOutlet UILabel *couponDisValue;
//@property (weak, nonatomic) IBOutlet UILabel *discountLbl;
//@property (weak, nonatomic) IBOutlet UILabel *walletLbl;
//@property (weak, nonatomic) IBOutlet UILabel *walletVal;
@property PayuMoneySDKPaymentBreakdown *payDetails;
- (IBAction)okBtnClicked:(UIButton *)sender;
-(PayuMoneySDKPaymentBreakdown *)initWithFrame : (CGRect)frame withAmount : (NSString *)amt withConvenienceAmt : (NSString *)convenience withTotalAmt : (NSString *)totalAmt withPoints : (NSString *)points withDiscount : (NSString *)discount withCouponDiscount : (NSString *)couponDis withNetAmount : (NSString *)netAmt withWallet : (NSString *)walletBal withCashBack : (NSString *)cashback;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end
