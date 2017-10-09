//
//  CardsViewController.h
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import "BaseViewController.h"

@interface CardsViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic , strong) NSString *amount;
@property (assign) int landingScreen;

@property (nonatomic , strong) UITextField *cardNumberTextField;
@property (nonatomic , strong) UITextField *ownerNameTextField;
@property (nonatomic , strong)  UITextField *expiryDateTextField;
@property (nonatomic , strong)  UITextField *cvvTextField;
@property (nonatomic , weak) IBOutlet UITextField *netBankCodeTextField;
@property (nonatomic , strong) UIImageView *schemeTypeImageView;

@property (nonatomic , weak) IBOutlet UITableView *saveCardsTableView;

@property (nonatomic , weak) IBOutlet UIButton *loadButton;

@property (nonatomic , strong) UIPickerView *aPickerView;
@property (nonatomic , weak) IBOutlet UITableView *ccddtableView;


@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic , strong) CTSRuleInfo *ruleInfo;

@property (assign) BOOL isDirectPaymentEnable;

@end
