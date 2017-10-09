//
//  HomeViewController.h
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface HomeViewController : BaseViewController

@property (nonatomic , strong) NSString *userName;

@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;
@property (nonatomic , weak) IBOutlet UILabel *amountLabel;
@property (nonatomic , weak) IBOutlet UIView *containerView;

@property (nonatomic , weak) IBOutlet UIView *transparentViewView;
@property (nonatomic , weak) IBOutlet UIView *dpContainerView;
@property (nonatomic , weak) IBOutlet UITextField *dynamicPricingTextField;
@property (nonatomic , weak) IBOutlet UITextField *amountTextField;
@property (nonatomic , weak) IBOutlet UITextField *couponCodeTextField;
@property (nonatomic , weak) IBOutlet UITextField *alteredAmountTextField;
@property (nonatomic , weak) IBOutlet UIPickerView *pickerView;

@property (nonatomic , weak) IBOutlet UIButton *cancelButton;
@property (nonatomic , weak) IBOutlet UIButton *applyButton;

@end
