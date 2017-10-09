//
//  SignUpViewController.h
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <CitrusPay/CitrusPay.h>

@interface SignUpViewController : BaseViewController<CitrusLoginDelegate>


@property (nonatomic , weak) IBOutlet UITextField *userNameTextField;
@property (nonatomic , weak) IBOutlet UITextField *mobileTextField;
@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic , weak) IBOutlet UIButton *signupButton;
@property (nonatomic , weak) IBOutlet UIButton *fullScopeRadioButton;
@property (nonatomic , weak) IBOutlet UIButton *limitedScopeRadioButton;
//@property int loginType;

@end
