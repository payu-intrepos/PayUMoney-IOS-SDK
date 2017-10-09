//
//  SettingViewController.h
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 11/3/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingViewController : BaseViewController

@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;
@property (nonatomic , weak) IBOutlet UITextField *firstNameTextField;
@property (nonatomic , weak) IBOutlet UITextField *lastNameTextField;
@property (nonatomic , weak) IBOutlet UITextField *mobileTextField;
@property (nonatomic , weak) IBOutlet UIButton *actionButton;
@property (nonatomic , strong) NSString *userEmailId;

@end
