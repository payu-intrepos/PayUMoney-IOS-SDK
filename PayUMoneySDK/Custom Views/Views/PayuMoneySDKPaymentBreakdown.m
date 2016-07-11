//
//  PaymentBreakdown.m
//  payuSDK
//
//  Created by Honey Lakhani on 8/18/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "PayuMoneySDKPaymentBreakdown.h"

@implementation PayuMoneySDKPaymentBreakdown

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(PayuMoneySDKPaymentBreakdown *)initWithFrame:(CGRect)frame withAmount : (NSString *)amt withConvenienceAmt : (NSString *)convenience withTotalAmt : (NSString *)totalAmt withPoints:(NSString *)points withDiscount:(NSString *)discount withCouponDiscount:(NSString *)couponDis withNetAmount:(NSString *)netAmt withWallet:(NSString *)walletBal withCashBack : (NSString *)cashback
{
    self = [super initWithFrame:frame];
   
    if(self)
    {
        
        self.payDetails = [[[NSBundle mainBundle]loadNibNamed:@"PayuMoneySDKPaymentBreakdown" owner:self options:nil]firstObject];
        self.payDetails.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        if (CGRectIsEmpty(frame)) {
            self.payDetails.bounds = frame;
        }
        self.paymentDetailsLbl.font = SDK_FONT_BOLD(20.0);
        self.orderAmount.text = [NSString stringWithFormat:@"Order Amount : Rs.%@",amt];
        [self.orderAmount sizeToFit];
        [self.orderAmount setFont:[UIFont systemFontOfSize:17.0]];
        self.convenienceAmount.text = [NSString stringWithFormat:@"Convenience Fee : Rs.%@",convenience];
        [self.convenienceAmount setFont:[UIFont systemFontOfSize:17.0]];
        self.totalAmount.text = [NSString stringWithFormat:@"Total : Rs.%@",totalAmt];
        [self.totalAmount setFont:[UIFont systemFontOfSize:17.0]];
        [self.payDetails.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UILabel *lbl;
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(19, 140, 120, 21)];
        int index = 1;
        if (![convenience isEqualToString:@"0.00"])  {
            [self addLabels:index++ withTitle:@"Convenience Amount : Rs." withValue:convenience];
        }
        [self addLabels:index++ withTitle:@"Total Amount : Rs." withValue:totalAmt];
//        if (![cashback isEqualToString:@"0.00"]) {
//
//            
//            
//            [self addLabels:1 withTitle:@"Cashback : Rs." withValue:cashback];
//            if (![couponDis isEqualToString:@"0.00"])
//            {
//                [self addLabels:2 withTitle:@"Coupon Discount : Rs." withValue:couponDis];
//                 if (![points isEqualToString:@"@0.00"]) {
//                [self checkForPoints:points withIndex :3 withAmount:amt];
//                 }
//            }
//            else
//            {
//                 if (![points isEqualToString:@"@0.00"]) {
//            
//                [self checkForPoints:points withIndex:2 withAmount:amt];
//                 }
//            }
//        }
//       else if (![discount isEqualToString:@"0.00"])
//       {
//
//           if (![couponDis isEqualToString:@"0.00"])
//           {
//               [self addLabels:2 withTitle:@"Coupon Discount : Rs." withValue:couponDis];
//                if (![points isEqualToString:@"@0.00"]) {
//               [self checkForPoints:points withIndex :3 withAmount:amt];
//                }
//           }
//           else
//           { if (![points isEqualToString:@"@0.00"]) {
//               [self checkForPoints:points withIndex:2 withAmount:amt];
//           }
//           }
//       }
//        else
//        {
//        if (![couponDis isEqualToString:@"0.00"])
//        {
//
//            [self addLabels:1 withTitle:@"Coupon Discount : Rs." withValue:couponDis];
//             if (![points isEqualToString:@"@0.00"]) {
//            [self checkForPoints:points withIndex :2 withAmount:amt];
//             }
//
//        }
//        }
//
        
        if (![couponDis isEqualToString:@"0.00"]) {
            [self addLabels:index++ withTitle:@"Coupon Discount : Rs." withValue:couponDis];
        }
        else
        {
            if (![discount isEqualToString:@"0.00"])
            {
                [self addLabels:index++ withTitle:@"Discount : Rs." withValue:discount];
            }
        else if (![cashback isEqualToString:@"0.00"]) {
            [self addLabels:index++ withTitle:@"Cashback : Rs." withValue:cashback ];
        }
        
        }
        if (![points isEqualToString:@"0.00"]) {
            [self addLabels:index++ withTitle:@"PayUMoney points : Rs." withValue:points];
//            if ([amt doubleValue] - [couponDis doubleValue] >= [points doubleValue]) {
//                
//                
//                [self addLabels:index++ withTitle:@"Net Amount : Rs." withValue:[NSString stringWithFormat:@"%0.2lf",[amt doubleValue] - [points doubleValue] - [couponDis doubleValue]]];
//                
//            }
//            else
//            {
//                
//                [self addLabels:index++ withTitle:@"Net Amount : Rs." withValue:@"0.00"];
//            }
            
        }
        [self addLabels:index++ withTitle:@"Net Amount : Rs." withValue:netAmt];
        if (![walletBal isEqualToString:@"0.00"]) {
            [self addLabels:index++ withTitle:@"Wallet Usage : Rs." withValue:walletBal];
        }
       
   }
    [self.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.okBtn.layer.cornerRadius = 3.0;
     [self addSubview:self.payDetails];
    return self;
}
-(void)checkForPoints : (NSString *)points withIndex : (int)index withAmount : (NSString *)amt
{
    if (![points isEqualToString:@"@0.00"]) {
        [self addLabels:index withTitle:@"PayUMoney points : Rs." withValue:points];
        if ([amt doubleValue] >= [points doubleValue]) {
        
        
        [self addLabels:index + 1 withTitle:@"Net Amount : Rs." withValue:[NSString stringWithFormat:@"%0.2lf",[amt doubleValue] - [points doubleValue]]];
         
        }
        else
        {
            
            [self addLabels:index + 1 withTitle:@"Net Amount : Rs." withValue:@"0.00"];
        }
    }
}
-(void)addLabels : (int)index withTitle : (NSString *)title withValue : (NSString *)value
{
    UILabel *couponLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 21)];
    couponLbl.text = title;
    CGSize lblsize = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0]}];
    couponLbl.frame = CGRectMake(19, (index * 28) + self.orderAmount.frame.origin.y, lblsize.width, couponLbl.frame.size.height);

    UILabel *valLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 21)];
    valLbl.frame = CGRectMake(couponLbl.frame.origin.x + couponLbl.frame.size.width + 3, (index * 28) + self.orderAmount.frame.origin.y, valLbl.frame.size.width, valLbl.frame.size.height);
    valLbl.text = value;
    
    [self.payDetails addSubview:couponLbl];
    // [lbl setBackgroundColor:[UIColor blueColor]];
    [self.payDetails addSubview:valLbl];
}


- (IBAction)okBtnClicked:(UIButton *)sender {
//    UITableView *tableView = (UITableView *)self.superview.superview;
//    [tableView setScrollEnabled:YES];
    [self.superview removeFromSuperview];
    [self removeFromSuperview];
}
@end
