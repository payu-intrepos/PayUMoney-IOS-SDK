//
//  PaymentViewController.h
//  PayU SDK
//
//  Created by Honey Lakhani on 9/29/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseViewController.h"
@interface PayuMoneySDKPaymentViewController : UIViewController

    {
        UIControl *controlCvvBG;
        UIAlertView *alertCVV;
    }

@property (weak, nonatomic) IBOutlet UILabel *amountToPay;
@property (weak, nonatomic) IBOutlet UIButton *applyCoupon;
- (IBAction)applyCouponBtnClicked:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *useWalletLbl;
- (IBAction)useWalletCheckboxBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *useWalletBtn;
@property (weak, nonatomic) IBOutlet UILabel *initialBalLbl;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *paymentTableView;

@property (weak, nonatomic) IBOutlet UIView *paymentView;


- (IBAction)viewDetailsBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *viewDetailsBtn;
@property (weak, nonatomic) IBOutlet UILabel *savingsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgSecurity;
@property (weak, nonatomic) IBOutlet UIButton *btnOneTap;
- (IBAction)btnOneTapClicked:(id)sender;

@end
