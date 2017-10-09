//
//  ViewController.h
//  PlugNPlayExample
//
//  Created by Yadnesh Wankhede on 8/8/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UITextField *tfMobile;
@property (strong, nonatomic) IBOutlet UITextField *tfAmount;
@property (strong, nonatomic) IBOutlet UITextField *tfTopNavColor;
@property (strong, nonatomic) IBOutlet UITextField *tfNavTitleColor;
@property (strong, nonatomic) IBOutlet UITextField *tfButtonColor;
@property (strong, nonatomic) IBOutlet UITextField *tfButtonTextColor;
@property (strong, nonatomic) IBOutlet UITextField *tfMerchantDisplayName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ToContraint;
@property (strong, nonatomic) IBOutlet UISegmentedControl *serverSelector;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UIButton *btnPayment;
@property (strong, nonatomic) IBOutlet UIButton *btnMyWallet;
@property (strong, nonatomic) IBOutlet UIButton *btnResetTheme;
@property (strong, nonatomic) IBOutlet UILabel* navItem;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel* version;
@property (strong, nonatomic) IBOutlet UIBarButtonItem* logout;

- (IBAction)disableCompletion:(id)sender;
- (IBAction)disableWallet:(id)sender;
- (IBAction)disableNetbanking:(id)sender;
- (IBAction)disableCards:(id)sender;
- (IBAction)resetTheme:(id)sender;
- (IBAction)signOut;
@end
