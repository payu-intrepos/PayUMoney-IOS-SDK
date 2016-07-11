//
//  SignUpView.h
//  PayU SDK
//
//  Created by Honey Lakhani on 10/14/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SignUpDelegate <NSObject>
-(void)sendingDataBackToController;
@end
@interface PayuMoneySDKSignUpView : UIView<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property PayuMoneySDKSignUpView *signUp;
- (void)registerForKeyboardNotifications;
-(void)removeNotifications;
@property id<SignUpDelegate>delegate;
- (IBAction)signUpBtnClicked:(UIButton *)sender;
@end
