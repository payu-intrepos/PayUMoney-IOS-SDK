//
//  LoginViewController.h
//  PayU SDK
//
//  Created by Honey Lakhani on 9/28/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayuMoneySDKLoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *loginOrSignUpView;
- (IBAction)loginBtnClicked:(UIButton *)sender;
- (IBAction)signUpBtnClicked:(UIButton *)sender;
@property NSArray *merchantParamsArr;
@property NSString *str;
@end
