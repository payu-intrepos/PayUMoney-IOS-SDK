//
//  PnPCvvInputViewController.h
//  PlugNPlay
//
//  Created by Yadnesh Wankhede on 8/15/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PnPToolbar.h"
#import "PnPWalletPayConstants.h"
#import "PnPSavedCardView.h"

@class PnPSavedCardView, CTSLoaderButton;

@interface PnPCvvInputViewController : UIViewController<UITextFieldDelegate,PnPToolbarDelegate>{
    UIView *viewCvv;
    NSMutableArray *textFields ;
}
@property (strong, nonatomic) IBOutlet CTSLoaderButton *btnPayNow;
@property (strong, nonatomic) IBOutlet PnPSavedCardView *savedCard;
@property (strong, nonatomic) IBOutlet UITextField *tfCvv1;
@property (strong, nonatomic) IBOutlet UITextField *tfCvv3;
@property (strong, nonatomic) IBOutlet UITextField *tfCvv2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCardViewTop;


@property (assign, atomic) PNPTapType pnpTapType;
@property (strong, atomic) NSString *payAmount;
@property (assign, atomic) NSDictionary *cardDetails;
@property (strong, nonatomic) NSMutableArray *autoLoadSubArray;
@property (assign,atomic) BOOL isLoadMoney;
@property (assign, atomic) BOOL isWalletFlow;
@property (strong, nonatomic)NSString *thresholdAmount;
@property (strong, nonatomic)NSString *autoLoadAmount;
//@property (strong, nonatomic)NSMutableArray *autoLoadSubscriptionArray;
- (IBAction)payNowOrProceed:(id)sender;
@end
