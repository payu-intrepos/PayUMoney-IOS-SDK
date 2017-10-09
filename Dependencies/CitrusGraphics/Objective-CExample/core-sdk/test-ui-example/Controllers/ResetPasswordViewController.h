//
//  ResetPasswordViewController.h
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ResetPasswordViewController : BaseViewController

@property (nonatomic , strong) NSString *userName;
@property (nonatomic , weak) IBOutlet UIButton *resetButton;
@property (nonatomic , weak) IBOutlet UITextField *userNameTextField;
@property (nonatomic , weak) IBOutlet UITextField *resetTextField;
@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;

@end
