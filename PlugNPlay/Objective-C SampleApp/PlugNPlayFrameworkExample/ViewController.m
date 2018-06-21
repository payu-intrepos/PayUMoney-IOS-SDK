//
//  ViewController.m
//  PlugNPlayExample
//
//  Created by Yadnesh Wankhede on 8/8/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <PlugNPlay/PlugNPlay.h>

#define SCROLLVIEW_HEIGHT 600
#define SCROLLVIEW_WIDTH 320

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kMerchantKey @"mdyCKV"
#define kMerchantID @"4914106"
#define kMerchantSalt @"Je7q3652"

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
@property BOOL isExitAlertOnBankPageDisable;
@property BOOL isExitAlertOnCheckoutPageDisable;
@end

@implementation ViewController
@synthesize  tfEmail,tfMobile,tfAmount,serverSelector;

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchRememberedDetails];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = YES;
    [_scrollView addGestureRecognizer:tapScroll];
    
    self.version.text = [NSString stringWithFormat:@"© PlugNPlay Demo v%@", @""];

    _scrollView.delegate = self;
    
    keyboardVisible = NO;
    tfEmail.delegate = tfMobile.delegate = tfAmount.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
  
    _tfTopNavColor.delegate =_tfNavTitleColor.delegate =_tfButtonColor.delegate =_tfButtonTextColor.delegate =_tfMerchantDisplayName.delegate = self;
    
    _tfNavTitleColor.clearButtonMode =_tfButtonColor.clearButtonMode =_tfButtonTextColor.clearButtonMode =_tfTopNavColor.clearButtonMode = UITextFieldViewModeWhileEditing;
    

    [self loadThemeColor];

    _navItem.text = _tfMerchantDisplayName.text;
//    serverSelector.selectedSegmentIndex = 1;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont systemFontOfSize:15 weight:UIFontWeightThin], NSFontAttributeName,
                                nil];
    [serverSelector setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSLog(@"size of ui %lu",    sizeof(unsigned int));
    
    [self getTxnParam];
//    [self initCoreSDK];
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [self keyBoardNotification];
    [self registerForKeyboardNotifications];
//    self.scrollView.contentSize = CGSizeMake(SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGHT);
    keyboardVisible = NO;
    
    if ([PayUMoneyCoreSDK isUserSignedIn]) {
        _logout.enabled = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Keyboard handling

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

#pragma mark - User Actions

- (IBAction)pay:(id)sender {
    [tfAmount resignFirstResponder];
    [tfMobile resignFirstResponder];
    [tfEmail resignFirstResponder];
    
    //Set UI level customisations in PnP
    [PlugNPlay setMerchantDisplayName:_tfMerchantDisplayName.text];
    [PlugNPlay setButtonTextColor:UIColorFromRGB([self intFromHexString:_tfButtonTextColor.text])];
    [PlugNPlay setButtonColor:UIColorFromRGB([self intFromHexString:_tfButtonColor.text])];
    [PlugNPlay setTopTitleTextColor:UIColorFromRGB([self intFromHexString:_tfNavTitleColor.text])];
    [PlugNPlay setTopBarColor:UIColorFromRGB([self intFromHexString:_tfTopNavColor.text])];
    
    //Customize plug and play's behaviour//optional step
    [PlugNPlay setDisableCompletionScreen:_isCompletionDisable];
    [PlugNPlay setExitAlertOnBankPageDisabled:_isExitAlertOnBankPageDisable];
    [PlugNPlay setExitAlertOnCheckoutPageDisabled:_isExitAlertOnCheckoutPageDisable];
    
    [PlugNPlay setOrderDetails:[self testOrderDetailsArray]];

    PUMTxnParam * txnParam = [self getTxnParam];
    [self rememberEnteredDetails];
    
    [PlugNPlay presentPaymentViewControllerWithTxnParams:txnParam
                                        onViewController:self
                                     withCompletionBlock:^(NSDictionary *paymentResponse, NSError *error, id extraParam) {
                                      if (error) {
                                          [UIUtility toastMessageOnScreen:[error localizedDescription]];
                                      } else {
                                          NSString *message;
                                          if ([paymentResponse objectForKey:@"result"] && [[paymentResponse objectForKey:@"result"] isKindOfClass:[NSDictionary class]] ) {
                                              message = [[paymentResponse objectForKey:@"result"] valueForKey:@"error_Message"];
                                              if ([message isEqual:[NSNull null]] || [message length] == 0 || [message isEqualToString:@"No Error"]) {
                                                  message = [[paymentResponse objectForKey:@"result"] valueForKey:@"status"];
                                              }
                                          }
                                          else {
                                              message = [paymentResponse valueForKey:@"status"];
                                          }
                                          [UIUtility toastMessageOnScreen:message];
                                      }
                                  }];
    
}

- (NSArray *)testOrderDetailsArray {
    return @[@{@"From":@"Delhi"}, @{@"To":@"Pune"}];
}

- (IBAction)resetTheme:(id)sender {
    [self resetThemeDetails];
}

- (void)tapped {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    keyboardVisible = false;
    [self.view endEditing:YES];
}


- (IBAction)disableCompletion:(id)sender {
    UISwitch *completionSwitch = (UISwitch *)sender;
    BOOL isDisable = NO;
    if (completionSwitch.isOn) {
        isDisable = YES;
    }
    _isCompletionDisable = isDisable;
}

- (IBAction)disableExitAlertOnBankPage:(id)sender {
    UISwitch *completionSwitch = (UISwitch *)sender;
    BOOL isDisable = NO;
    if (completionSwitch.isOn) {
        isDisable = YES;
    }
    _isExitAlertOnBankPageDisable = isDisable;
}

- (IBAction)disableExitAlertOnCheckoutPage:(id)sender {
    UISwitch *completionSwitch = (UISwitch *)sender;
    BOOL isDisable = NO;
    if (completionSwitch.isOn) {
        isDisable = YES;
    }
    _isExitAlertOnCheckoutPageDisable = isDisable;
}

#pragma mark - Touch events handling

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

#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    LogTrace(@"You entered textFieldShouldReturn %@",textField.text);
    [textField resignFirstResponder];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(50, 0, 0, 0);
    self.scrollView.contentInset = contentInsets;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    LogTrace(@"You entered textFieldDidEndEditing %@",textField.text);
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
            _btnPayment.backgroundColor = _btnMyWallet.backgroundColor = _btnResetTheme.backgroundColor = UIColorFromRGB([self intFromHexString:finalColorString]);
        }else{
            [_btnMyWallet setTitleColor: UIColorFromRGB([self intFromHexString:finalColorString]) forState:UIControlStateNormal];
            [_btnPayment setTitleColor: UIColorFromRGB([self intFromHexString:finalColorString]) forState:UIControlStateNormal];
            [_btnResetTheme setTitleColor: UIColorFromRGB([self intFromHexString:finalColorString]) forState:UIControlStateNormal];
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

#pragma mark - Theme management


- (void)loadThemeColor {
    _navigationBar.barTintColor = UIColorFromRGB([self intFromHexString:_tfTopNavColor.text]);
    _tfNavTitleColor.backgroundColor = UIColorFromRGB([self intFromHexString:_tfNavTitleColor.text]);
    _tfTopNavColor.backgroundColor = UIColorFromRGB([self intFromHexString:_tfTopNavColor.text]);
    _tfButtonColor.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonColor.text]);
    _tfButtonTextColor.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonTextColor.text]);
    _btnPayment.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonColor.text]);
    _btnResetTheme.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonColor.text]);
    _navItem.textColor = UIColorFromRGB([self intFromHexString:_tfNavTitleColor.text]);
    _btnMyWallet.backgroundColor = UIColorFromRGB([self intFromHexString:_tfButtonColor.text]);
    [_btnMyWallet setTitleColor: UIColorFromRGB([self intFromHexString:_tfButtonTextColor.text]) forState:UIControlStateNormal];
    [_btnPayment setTitleColor: UIColorFromRGB([self intFromHexString:_tfButtonTextColor.text]) forState:UIControlStateNormal];
    [_btnResetTheme setTitleColor: UIColorFromRGB([self intFromHexString:_tfButtonTextColor.text]) forState:UIControlStateNormal];
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

#pragma mark - Helper methods

-(PUMTxnParam*)getTxnParam{
    PUMTxnParam *txnParam= [[PUMTxnParam alloc] init];
//    PUMRequestParams *params = [PUMRequestParams sharedParams];
    
    //Pass these parameters
    txnParam.phone = tfMobile.text;
    txnParam.email = tfEmail.text;
    txnParam.amount = tfAmount.text;
    txnParam.environment = [self selectedEnv];
    txnParam.firstname = @"UserFirstName";
    txnParam.key =  kMerchantKey;
    txnParam.merchantid = kMerchantID;
//    params.txnid = [NSString stringWithFormat:@"0nf7%@",[self getRandomString:4]];
    txnParam.txnID = @"12";
    txnParam.surl = @"https://www.payumoney.com/mobileapp/payumoney/success.php";
    txnParam.furl = @"https://www.payumoney.com/mobileapp/payumoney/failure.php";
    txnParam.productInfo = @"iPhone7";
    
    txnParam.udf1 = @"as";
    txnParam.udf2 = @"sad";
    txnParam.udf3 = @"";
    txnParam.udf4 = @"";
    txnParam.udf5 = @"";
    txnParam.udf6 = @"";
    txnParam.udf7 = @"";
    txnParam.udf8 = @"";
    txnParam.udf9 = @"";
    txnParam.udf10 = @"";
    txnParam.hashValue = [self getHashForPaymentParams:txnParam];
//    params.hashValue = @"FDBE365FCE1133A9D7091BEE25D032910B7CE8C2F1AA02F86179209EF4A1652CCB35159ECAEFEDD8DE404E2B27809F0B487749DC8DBD9D264E52142B6D3C3270";
    return txnParam;
}

- (NSString *)getRandomString:(NSInteger)length
{
    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
    
    NSString *numbers = @"0123456789";
    
    // First number cannot be 0
    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
    
    for (int i = 1; i < length; i++) {
        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
    }
    
    return returnString;
}

//- (void)initCoreSDK {
//    if([self selectedEnv] == PUMEnvironmentTest){
////        [PUMCoreSDKManager initWithKey:@"Aqryi8"
////                            merchantid:@"397202"
////                                  salt:@"ZRC9Xgru"
////                                  surl:@"https://www.payumoney.com/mobileapp/payumoney/success.php"
////                                  furl:@"https://www.payumoney.com/mobileapp/payumoney/failure.php"
////                              logo_url:@"https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
////                           environment:PUMEnvironmentTest];
//
//        [PUMCoreSDKManager initWithKey:@"tPJM2e"
//                                merchantid:@"4824899"
//                                  salt:@"x4rmTrFm"
//                                  surl:@"https://www.payumoney.com/mobileapp/payumoney/success.php"
//                                  furl:@"https://www.payumoney.com/mobileapp/payumoney/failure.php"
//                              logo_url:@"https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
//                           environment:PUMEnvironmentTest];
//    }
//    else if([self selectedEnv] == PUMEnvironmentProduction){
//        
//        billUrl = BillUrlProd;
//        returnUrl = LoadWalletReturnUrlProd;
//        
//        [PUMCoreSDKManager initWithKey:@"mdyCKV"
//                            merchantid:@"4914106"
//                                  salt:@"Je7q3652"
//                                  surl:@"https://www.payumoney.com/mobileapp/payumoney/success.php"
//                                  furl:@"https://www.payumoney.com/mobileapp/payumoney/failure.php"
//                              logo_url:@"https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
//                           environment:PUMEnvironmentProduction];
//    }
//    
//    unsigned int topNavHexInt = [self intFromHexString:_tfTopNavColor.text];
//    unsigned int topTitleHexInt = [self intFromHexString:_tfNavTitleColor.text];
//    unsigned int buttonHexInt = [self intFromHexString:_tfButtonColor.text];
//    unsigned int buttonTitleHexInt = [self intFromHexString:_tfButtonTextColor.text];
//    //#008312 - green
//    //#C333A1 - purple
//    //#EF5B30 - orange
//    //#35CA4B - light green
//    
//    [PlugNPlay setTopBarColor:UIColorFromRGB(topNavHexInt)];
//    [PlugNPlay setTopTitleTextColor:UIColorFromRGB(topTitleHexInt)];
//    [PlugNPlay setButtonColor:UIColorFromRGB(buttonHexInt)];
//    [PlugNPlay setButtonTextColor:UIColorFromRGB(buttonTitleHexInt)];
//    [PlugNPlay setIndicatorTintColor:[UIColor orangeColor]];
//}

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


- (void)fetchRememberedDetails {
    email = [[NSUserDefaults standardUserDefaults] valueForKey:@"EMAIL"];
    amount = [[NSUserDefaults standardUserDefaults] valueForKey:@"AMOUNT"];
    
    mobile = [[NSUserDefaults standardUserDefaults] valueForKey:@"MOBILE"];
    navBarColorText = [[NSUserDefaults standardUserDefaults] valueForKey:@"NAVCOLOR"];
    navBarTitleColorText = [[NSUserDefaults standardUserDefaults] valueForKey:@"NAVTITLECOLOR"];
    buttonColorText = [[NSUserDefaults standardUserDefaults] valueForKey:@"BUTTONCOLOR"];
    buttonTitleColorText = [[NSUserDefaults standardUserDefaults] valueForKey:@"BUTTONTEXTCOLOR"];
    merchantName = [[NSUserDefaults standardUserDefaults] valueForKey:@"MERCHANTNAME"];
    id selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] valueForKey:@"ENVIRONMENT"];
    if (email.length != 0) {
        tfEmail.text = email;
    }  if (amount.length != 0) {
        tfAmount.text = amount;
    }  if (mobile.length != 0) {
        tfMobile.text = mobile;
    }
    if (navBarColorText.length != 0) {
        _tfTopNavColor.text = navBarColorText;
    }
    else{
        _tfTopNavColor.text = defaultTopNavColor;
    }
    if (navBarTitleColorText.length != 0) {
        _tfNavTitleColor.text = navBarTitleColorText;
    }
    else{
        _tfNavTitleColor.text = defaultNavTitleColor;
    }
    if (buttonColorText.length != 0) {
        _tfButtonColor.text = buttonColorText;
    }
    else{
        _tfButtonColor.text = defaultButtonColor;
    }
    if (buttonTitleColorText.length != 0) {
        _tfButtonTextColor.text = buttonTitleColorText;
    }
    else{
        _tfButtonTextColor.text = defaultButtonTextColor;
    }
    if (merchantName.length != 0){
        _tfMerchantDisplayName.text = merchantName;
    }
    if (selectedSegmentIndex){
        self.serverSelector.selectedSegmentIndex = [selectedSegmentIndex integerValue];
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
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",(long)self.serverSelector.selectedSegmentIndex] forKey:@"ENVIRONMENT"];
}

- (IBAction)selectorValueChanged:(id)sender {
    [self doSignOut];
}

-(void)doSignOut{
    if ([PayUMoneyCoreSDK isUserSignedIn]) {
        [PayUMoneyCoreSDK signOut];
        [UIUtility toastMessageOnScreen:@"Signout Successfull"];
        _logout.enabled = NO;
    }
}

- (IBAction)signOut {
    [self doSignOut];
}

-(PUMEnvironment)selectedEnv {
    if(serverSelector.selectedSegmentIndex == 0){
        return PUMEnvironmentTest;
    }
    return PUMEnvironmentProduction;
}

//TODO: get rid of this function for test environemnt
-(NSString*)getHashForPaymentParams:(PUMTxnParam*)txnParam {
    NSString *salt = kMerchantSalt;
    NSString *hashSequence = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@",txnParam.key,txnParam.txnID,txnParam.amount,txnParam.productInfo,txnParam.firstname,txnParam.email,txnParam.udf1,txnParam.udf2,txnParam.udf3,txnParam.udf4,txnParam.udf5,txnParam.udf6,txnParam.udf7,txnParam.udf8,txnParam.udf9,txnParam.udf10, salt];
    
    NSString *hash = [[[[[self createSHA512:hashSequence] description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return hash;
}

- (NSString*) createSHA512:(NSString *)source {
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    
    CC_SHA512(keyData.bytes, (CC_LONG)keyData.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    NSLog(@"Hash output --------- %@",output);
    NSString *hash =  [[[[output description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    return hash;
}


@end


