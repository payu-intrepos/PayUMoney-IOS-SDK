//
//  ViewController.h
//  PayU SDK
//
//  Created by Honey Lakhani on 9/28/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayuMoneySDKViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@property (weak, nonatomic) IBOutlet UITextField *transactionIdTextField;

@property (weak, nonatomic) IBOutlet UITextField *merchantIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *productInfoTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *successURLTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *failureURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *payNowBtn;
@property (nonatomic,strong) NSDictionary *merchantParamResponse;

- (IBAction)payButtonClicked:(UIButton *)sender;


@end

