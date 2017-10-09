//
//  PnPWithdrawMoneyVerifyViewController.h
//  PlugNPlay
//
//  Created by Raji Nair on 22/11/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlugNPlay.h"
@class PnPWithdrawMoneyVerifyViewController;

@protocol PnPWithdrawMoneyVerifyViewControllerDelegate
@optional
- (void)dismissAndPresentVC3:(PnPWithdrawMoneyVerifyViewController*)withdrawMoneyVerify;

@end

@interface PnPWithdrawMoneyVerifyViewController : UIViewController <UITextFieldDelegate>{
    UIView *viewCvv;
    NSMutableArray *textFields;
}

@property (strong, nonatomic) IBOutlet UITextField *tfOtp1;
@property (strong, nonatomic) IBOutlet UITextField *tfOtp2;
@property (strong, nonatomic) IBOutlet UITextField *tfOtp3;
@property (strong, nonatomic) IBOutlet UITextField *tfOtp4;
@property (strong, nonatomic) IBOutlet UILabel *countDownTimer;
@property (strong, nonatomic) IBOutlet UIButton *resendButton;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) IBOutlet UILabel *staticOtpDesc;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) CTSAuthLayer *authLayer;
@property (strong, nonatomic) CTSPaymentLayer *paymentLayer;
@property (assign, nonatomic) BOOL countingDown;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSString *ownerName;
@property (strong, nonatomic) NSString *accountNumber;
@property (strong, nonatomic) NSString *ifscCode;
@property (strong, nonatomic) NSString *withdrawAmount;
@property (assign) int secondsLeft;


@property (assign, nonatomic) id <PnPWithdrawMoneyVerifyViewControllerDelegate> delegate;
- (IBAction)confirm:(id)sender;
- (IBAction)resend:(id)sender;
- (IBAction)cancel:(id)sender;
@end
