//
//  PnPAddCardViewController.h
//  CitrusPay
//
//  Created by Yadnesh Wankhede on 07/07/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PnPWalletPayConstants.h"
#import "PnPAddCardView.h"

@interface PnPAddCardViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet PnPAddCardView *addCardView;
@property (strong)NSString *cardType;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraintSaveCardTop;
@property (assign, atomic) PNPTapType pnpTapType;
@property (strong, nonatomic) IBOutlet CTSLoaderButton *btnPayNow;
@property (assign) BOOL isWalletFlow;
@property (weak, nonatomic) UIViewController *parentVC;

@property (strong, nonatomic) IBOutlet UIImageView *imgCardLine;
@property (strong, nonatomic) IBOutlet UIImageView *imgExpiryLine;
@property (strong, nonatomic) IBOutlet UIImageView *imgCCVLine;
@property (strong, nonatomic) NSDecimalNumber *defaultConvFee;

@end
