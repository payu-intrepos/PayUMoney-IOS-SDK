//
//  LoginView.h
//  PayU SDK
//
//  Created by Honey Lakhani on 10/14/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayuMoneySDKKeychainItemWrapper.h"
#import "PayuMoneySDKLoginService.h"
@protocol LoginViewDelegate <NSObject>
-(void)goBackToController : (NSString *)msg;
@end
@interface PayuMoneySDKLoginView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SendingResponseDelegate,LoginServiceDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITableView *loginTableView;
@property PayuMoneySDKLoginView *loginView;

@property NSArray *loginParams;
@property id<LoginViewDelegate> logindelegate;
- (void)registerForKeyboardNotifications;
-(void)removeNotifications;
-(PayuMoneySDKLoginView *)initWithFrame : (CGRect)frame withArray : (NSArray *)cellArr;
@end
