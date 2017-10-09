//
//  ViewController.m
//  PlugNPlayExample
//
//  Created by Yadnesh Wankhede on 8/8/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"

#import <PlugNPlay/PlugNPlay.h>

#import "MerchantConstants.h"

#define SCROLLVIEW_HEIGHT 600
#define SCROLLVIEW_WIDTH 320
#define defaultTopNavColor @"F79523"
#define defaultNavTitleColor @"FFFFFF"
#define defaultButtonColor @"F79523"
#define defaultButtonTextColor @"FFFFFF"
#define defaultMerchantName @"Shopmatics"

@interface ViewController ()<UIScrollViewDelegate>{
    UITextField *fieldInAction;
    UITextField *activeField;
    BOOL keyboardVisible;
    CGPoint offset;
    NSString *email;
    NSString *mobile;
    NSString *amount;
    NSString *navBarColorText;
    NSString *navBarTitleColorText;
    NSString *buttonColorText;
    NSString *buttonTitleColorText;
    NSString *merchantName;
    NSString *billUrl;
    NSString *returnUrl;
}
@property BOOL isCompletionDisable;
@property BOOL isWalletDisable;
@property BOOL isCardsDisable;
@property BOOL isNetbankDisable;
@end

@implementation ViewController
@synthesize  tfEmail,tfMobile,tfAmount,serverSelector;

- (void)tapped {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    keyboardVisible = false;
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchRememberedDetails];
    
    [self initPNP];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = YES;
    [_scrollView addGestureRecognizer:tapScroll];
    
    self.version.text = [NSString stringWithFormat:@"© Citrus Payments. PlugNPlay Demo v%@", PLUGNPLAY_VERSION];
    
    _scrollView.delegate = self;
    
    keyboardVisible = NO;
    tfEmail.delegate = tfMobile.delegate = tfAmount.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tfTopNavColor.delegate =_tfNavTitleColor.delegate =_tfButtonColor.delegate =_tfButtonTextColor.delegate =_tfMerchantDisplayName.delegate = self;
    
    _tfNavTitleColor.clearButtonMode =_tfButtonColor.clearButtonMode =_tfButtonTextColor.clearButtonMode =_tfTopNavColor.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    [self loadThemeColor];
    
    UILabel *countryCode = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 35, 30)];
    countryCode.text = @" +91";
    countryCode.font = [UIFont boldSystemFontOfSize:14];
    tfMobile.leftView = countryCode;
    tfMobile.leftViewMode = UITextFieldViewModeAlways;
    _navItem.text = _tfMerchantDisplayName.text;
    serverSelector.selectedSegmentIndex = 1;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont systemFontOfSize:15 weight:UIFontWeightThin], NSFontAttributeName,
                                nil];
    [serverSelector setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSLog(@"size of ui %lu",    sizeof(unsigned int));
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [self keyBoardNotification];
    [self registerForKeyboardNotifications];
    self.scrollView.contentSize = CGSizeMake(SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT);
    keyboardVisible = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initPNP {
    
    if([self selectedEnv] == CTSEnvSandbox){
        [CitrusPaymentSDK initWithSignInID:SignInId_Sandbox
                              signInSecret:SignInSecretKey_Sandbox
                                  signUpID:SubscriptionId_Sandbox
                              signUpSecret:SubscriptionSecretKey_Sandbox
                                 vanityUrl:VanityUrl_Sandbox
                               environment:CTSEnvSandbox];
        [CitrusPaymentSDK setLogLevel:CTSLogLevelVerbose];
        
        billUrl = BillUrl_Sandbox;
        returnUrl = LoadWallet_ReturnUrl_Sandbox;

    }
    else if([self selectedEnv] == CTSEnvProduction){
        [CitrusPaymentSDK initWithSignInID:SignInId_Production
                              signInSecret:SignInSecretKey_Production
                                  signUpID:SubscriptionId_Production
                              signUpSecret:SubscriptionSecretKey_Production
                                 vanityUrl:VanityUrl_Production
                               environment:CTSEnvProduction];
        [CitrusPaymentSDK setLogLevel:CTSLogLevelNone];
        
        billUrl = BillUrl_Production;
        returnUrl = LoadWallet_ReturnUrl_Production;
    }

    unsigned int topNavHexInt = [self intFromHexString:_tfTopNavColor.text];
    unsigned int topTitleHexInt = [self intFromHexString:_tfNavTitleColor.text];
    unsigned int buttonHexInt = [self intFromHexString:_tfButtonColor.text];
    unsigned int buttonTitleHexInt = [self intFromHexString:_tfButtonTextColor.text];
    //#008312 - green
    //#C333A1 - purple
    //#EF5B30 - orange
    //#35CA4B - light green
    [CitrusPaymentSDK setTopBarColor:UIColorFromRGB(topNavHexInt)];
    [CitrusPaymentSDK setTopTitleTextColor:UIColorFromRGB(topTitleHexInt)];
    [CitrusPaymentSDK setButtonColor:UIColorFromRGB(buttonHexInt)];
    [CitrusPaymentSDK setButtonTextColor:UIColorFromRGB(buttonTitleHexInt)];
    [CitrusPaymentSDK setIndicatorTintColor:[UIColor orangeColor]];
}

- (IBAction)resetTheme:(id)sender {
    [self resetThemeDetails];
}

-(CTSEnvironment)selectedEnv {
    if(serverSelector.selectedSegmentIndex == 0){
        return CTSEnvSandbox;
    }
    return CTSEnvProduction;
}

- (IBAction)pay:(id)sender {
    [tfAmount resignFirstResponder];
    [tfMobile resignFirstResponder];
    [tfEmail resignFirstResponder];
    
    [self initPNP];
    
    [PlugNPlay setMerchantDisplayName:_tfMerchantDisplayName.text];
    
    //customize plug and play's behaviour//optional step
    
    [PlugNPlay disableCompletionScreen:_isCompletionDisable];
    [PlugNPlay disableCards:_isCardsDisable];
    [PlugNPlay disableNetbanking:_isNetbankDisable];
    [PlugNPlay disableWallet:_isWalletDisable];
    
    //prepare all the parameters for Plug and Play
    PlugAndPlayPayment *paymentInfo = [[PlugAndPlayPayment alloc] init];
    paymentInfo.billUrlOrCTSBillObject = billUrl;
    paymentInfo.payAmount = tfAmount.text;
    
    CTSUser* user = [[CTSUser alloc] init];
    user.mobile = tfMobile.text;
    user.email = tfEmail.text;
    
    user.firstName = @"firstname";//optional
    user.lastName = @"lastname";//optional
    user.address = nil;//optional
    
    [self rememberEnteredDetails];
    
    [self.class requestGETBillAmount:paymentInfo.payAmount
                             billURL:paymentInfo.billUrlOrCTSBillObject
                            callback: ^(CTSBill *bill,
                                        NSError *error) {
                                if (error) {
                                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
                                    [self.navigationController popViewControllerAnimated:YES];
                                    return;
                                }
                                else {
                                    paymentInfo.billUrlOrCTSBillObject = bill;
                                    
                                    [PlugNPlay presentPaymentsViewController:paymentInfo
                                                                     forUser:user
                                                              viewController:self
                                                                  completion:^(CTSPaymentReceipt *paymentReceipt, NSError *error) {
                                                                      if (error != nil) {
                                                                          [UIUtility toastMessageOnScreen:[error localizedDescription]];
                                                                      } else {
                                                                          if([paymentReceipt isSuccess]){
                                                                              [UIUtility toastMessageOnScreen:@"Payment successful"];
                                                                          }
                                                                          else{
                                                                              [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Failed,  %@",[paymentReceipt transactionStatus]]];
                                                                          }
                                                                      }
                                                                  }];
                                }
                            }];
    
}

+(void)requestGETBillAmount:(NSString *)amount billURL:(NSString *)billUrl callback:(ASBillCallback)callback{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?amount=%@",billUrl, [NSString stringWithFormat:@"%.02f", [amount floatValue]]];
    LogTrace(@"urlString %@",urlString);
    
    NSMutableURLRequest* urlReq = [[NSMutableURLRequest alloc] initWithURL:
                                   [NSURL URLWithString:urlString]];
    [urlReq setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:5];
    
    [NSURLConnection sendAsynchronousRequest:urlReq queue:queue completionHandler:^(NSURLResponse * response, NSData *data, NSError * connectionError) {
        NSError *billError = connectionError;
        CTSBill* sampleBill = nil;
        if(connectionError == nil){
            NSString* billJson = [[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding];
            JSONModelError *jsonError;
            sampleBill = [[CTSBill alloc] initWithString:billJson
                                                   error:&jsonError];
            if(jsonError){
                billError = jsonError;
            }
            LogTrace(@"billJson %@",billJson);
            LogTrace(@"signature %@ ", sampleBill);
        }
        callback(sampleBill,billError);
    }];
}


- (IBAction)myWallet:(id)sender {
    [tfAmount resignFirstResponder];
    [tfMobile resignFirstResponder];
    [tfEmail resignFirstResponder];
    
    //prepare all the parameters for Plug and Play
    [self initPNP];
    
    CTSUser* user = [[CTSUser alloc] init];
    user.mobile = tfMobile.text;
    user.email = tfEmail.text;
    
    user.firstName = @"firstname";//optional
    user.lastName = @"lastname";//optional
    user.address = nil;//optional
    
    //initialize and configure the sdk
    [self rememberEnteredDetails];
    
    NSDictionary *customParams=[NSDictionary dictionaryWithObjectsAndKeys:@"0019",@"MerchantName",@"998",@"PaymentId",nil];
    
    [PlugNPlay presentWalletViewController:user
                                 returnURL:returnUrl
                              customParams:customParams
                            viewController:self
                                completion:^(NSError *validationError) {
                                    if (validationError != nil) {
                                        [UIUtility toastMessageOnScreen:[validationError localizedDescription]];
                                    }
                                    else {
                                        [UIUtility toastMessageOnScreen:@"Payment successful"];
                                    }
                                }];
}



- (IBAction)signout:(id)sender {
    [self doSignOut];
    [UIUtility toastMessageOnScreen:@"Signout Successfull"];
}

-(void)doSignOut{
    
    CTSAuthLayer *authLayer = [CitrusPaymentSDK fetchSharedAuthLayer];
    [authLayer signOut];
    
    [self initPNP];
}

- (void)loadThemeColor {
    _navigationBar.barTintColor = UIColorFromRGB([self intFromHexString:_tfTopNavColor.text]);
    _tfNavTitleColor.backgroundColor = UIColorFromRGB([self intFromHexString:_tfNavTitleColor.text]);
    _tfTopNavColor.backgroundColor = UIColorFromRGB([self intFromHexString:_tfTopNavColor.text]);
    _tfButtonColor.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonColor.text]);
    _tfButtonTextColor.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonTextColor.text]);
    _btnPayment.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonColor.text]);
    _navItem.textColor = UIColorFromRGB([self intFromHexString:_tfNavTitleColor.text]);
    _btnMyWallet.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonColor.text]);
    [_btnMyWallet setTitleColor: UIColorFromRGB([self intFromHexString:_tfButtonTextColor.text]) forState:UIControlStateNormal];
    [_btnPayment setTitleColor: UIColorFromRGB([self intFromHexString:_tfButtonTextColor.text]) forState:UIControlStateNormal];
}

- (void)resetThemeDetails {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NAVCOLOR"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NAVTITLECOLOR"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"BUTTONCOLOR"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"BUTTONTEXTCOLOR"];
    _tfTopNavColor.text = defaultTopNavColor;
    _tfNavTitleColor.text = defaultNavTitleColor;
    _tfButtonColor.text = defaultButtonColor;
    _tfButtonTextColor.text = defaultButtonTextColor;
    [self loadThemeColor];
}


- (void)fetchRememberedDetails {
    email = [[NSUserDefaults standardUserDefaults] valueForKey:@"EMAIL"];
    amount = [[NSUserDefaults standardUserDefaults] valueForKey:@"AMOUNT"];
    
    mobile = [[NSUserDefaults standardUserDefaults] valueForKey:@"MOBILE"];
    navBarColorText = [[NSUserDefaults standardUserDefaults] valueForKey:@"NAVCOLOR"];
    navBarTitleColorText = [[NSUserDefaults standardUserDefaults] valueForKey:@"NAVTITLECOLOR"];
    buttonColorText = [[NSUserDefaults standardUserDefaults] valueForKey:@"BUTTONCOLOR"];
    buttonTitleColorText = [[NSUserDefaults standardUserDefaults] valueForKey:@"BUTTONTEXTCOLOR"];
    merchantName = [[NSUserDefaults standardUserDefaults] valueForKey:@"MERCHANTNAME"];
    if (email.length != 0) {
        tfEmail.text = email;
    }  if (amount.length != 0) {
        tfAmount.text = amount;
    }  if (mobile.length != 0) {
        tfMobile.text = mobile;
    }  if (navBarColorText.length != 0) {
        _tfTopNavColor.text = navBarColorText;
    }  if (navBarTitleColorText.length != 0) {
        _tfNavTitleColor.text = navBarTitleColorText;
    }  if (buttonColorText.length != 0) {
        _tfButtonColor.text = buttonColorText;
    }  if (buttonTitleColorText.length != 0) {
        _tfButtonTextColor.text = buttonTitleColorText;
    }  if (merchantName.length != 0){
        _tfMerchantDisplayName.text = merchantName;
    }
}

- (void)rememberEnteredDetails {
    [[NSUserDefaults standardUserDefaults] setValue:tfAmount.text forKey:@"AMOUNT"];
    [[NSUserDefaults standardUserDefaults] setValue:tfEmail.text forKey:@"EMAIL"];
    [[NSUserDefaults standardUserDefaults] setValue:tfMobile.text forKey:@"MOBILE"];
    
    [[NSUserDefaults standardUserDefaults] setValue:_tfTopNavColor.text forKey:@"NAVCOLOR"];
    [[NSUserDefaults standardUserDefaults] setValue:_tfNavTitleColor.text forKey:@"NAVTITLECOLOR"];
    [[NSUserDefaults standardUserDefaults] setValue:_tfButtonColor.text forKey:@"BUTTONCOLOR"];
    [[NSUserDefaults standardUserDefaults] setValue:_tfButtonTextColor.text forKey:@"BUTTONTEXTCOLOR"];
    [[NSUserDefaults standardUserDefaults] setValue:_tfMerchantDisplayName.text forKey:@"MERCHANTNAME"];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillBeShown:(NSNotification*)notification {
    NSDictionary *info = notification.userInfo;
    CGSize value = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, value.height, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    
    CGRect aRect = self.view.frame;
    aRect.size.height  -= value.height;
    
    CGRect activeTextFieldRect = activeField.frame;
    CGPoint activeTextFieldOrigin = activeTextFieldRect.origin;
    if (!CGRectContainsPoint(activeTextFieldRect, activeTextFieldOrigin)) {
        [self.scrollView scrollRectToVisible:activeTextFieldRect animated:YES];
    }
}


- (void)keyboardWillBeHidden:(NSNotification*)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    keyboardVisible = false;
}

- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

- (IBAction)disableCompletion:(id)sender {
    UISwitch *completionSwitch = (UISwitch *)sender;
    BOOL isDisable = NO;
    if (completionSwitch.isOn) {
        isDisable = YES;
    }
    _isCompletionDisable = isDisable;
}
- (IBAction)disableWallet:(id)sender{
    UISwitch *walletSwitch = (UISwitch *)sender;
    BOOL isDisable = NO;
    if (walletSwitch.isOn) {
        isDisable = YES;
    }
    _isWalletDisable = isDisable;
}
- (IBAction)disableNetbanking:(id)sender{
    UISwitch *netBankingSwitch = (UISwitch *)sender;
    BOOL isDisable = NO;
    if (netBankingSwitch.isOn) {
        isDisable = YES;
    }
    _isNetbankDisable = isDisable;
}

- (IBAction)disableCards:(id)sender{
    UISwitch *cardsSwitch = (UISwitch *)sender;
    BOOL isDisable = NO;
    if (cardsSwitch.isOn) {
        isDisable = YES;
    }
    _isCardsDisable = isDisable;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [tfEmail resignFirstResponder];
    [tfMobile resignFirstResponder];
    [tfAmount resignFirstResponder];
    [_tfNavTitleColor resignFirstResponder];
    [_tfButtonTextColor resignFirstResponder];
    [_tfButtonColor resignFirstResponder];
    [_tfButtonTextColor resignFirstResponder];
    [_tfMerchantDisplayName resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    LogTrace(@"You entered textFieldShouldReturn %@",textField.text);
    [textField resignFirstResponder];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(50, 0, 0, 0);
    self.scrollView.contentInset = contentInsets;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    LogTrace(@"You entered textFieldDidEndEditing %@",textField.text);
    if(fieldInAction.tag > 5){
        textField.backgroundColor = UIColorFromRGB([self intFromHexString:textField.text]);
    }
    [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    fieldInAction = textField;
    activeField = textField;
    [self.scrollView setScrollEnabled:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.tag > 5){
        
        if(textField.text.length >=6 && string.length > 0){
            
            return NO;
        }
        
        NSString *finalColorString;
        
        if(string.length > 0){
            finalColorString= [NSString stringWithFormat:@"%@%@",textField.text,string ];
            
        }else{
            finalColorString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            ;
        }
        textField.backgroundColor = UIColorFromRGB([self intFromHexString:finalColorString]);
        
        if (textField.tag == 9) {
            _navigationBar.barTintColor = UIColorFromRGB([self intFromHexString:finalColorString]);
        }else if (textField.tag == 8){
            _navItem.textColor = UIColorFromRGB([self intFromHexString:finalColorString]);
        }else if (textField.tag == 7){
            _btnPayment.backgroundColor = _btnMyWallet.backgroundColor = UIColorFromRGB([self intFromHexString:finalColorString]);
        }else{
            [_btnMyWallet setTitleColor: UIColorFromRGB([self intFromHexString:finalColorString]) forState:UIControlStateNormal];
            [_btnPayment setTitleColor: UIColorFromRGB([self intFromHexString:finalColorString]) forState:UIControlStateNormal];
        }
    } else if(textField.tag == 5){
        NSString *finalMerchantName ;
        if(string.length > 0){
            finalMerchantName= [NSString stringWithFormat:@"%@%@",textField.text,string ];
            
        } else {
            finalMerchantName = [textField.text stringByReplacingCharactersInRange:range withString:string];
        }
        _navItem.text = finalMerchantName;
    }
    return YES;
}

- (IBAction)selectorValueChanged:(id)sender {
    [self doSignOut];
}

@end
