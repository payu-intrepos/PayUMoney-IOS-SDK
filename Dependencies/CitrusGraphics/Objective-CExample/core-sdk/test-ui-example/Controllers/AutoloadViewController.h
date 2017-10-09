//
//  AutoloadViewController.h
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 2/9/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AutoloadViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UITextField *thresholTextField;
@property (nonatomic, weak) IBOutlet UITextField *topupTextField;
@property (nonatomic, weak) IBOutlet UIButton *authenticateButton;
@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic , strong) CTSPaymentOptions *cardInfo;

@end
