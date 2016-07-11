//
//  InititalTable ViewController.m
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 7/7/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import "InititalTableViewController.h"
#import "PayUmoneySDKPayment.h"
#import "PayuMoneySDKFinalViewController.h"

#define generictag 999

@interface InititalTableViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    NSArray *arr;
    UIToolbar* numberToolbar;
    UITextField *activeTxtFld;
    CGFloat value;

}
@end

@implementation InititalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     arr = @[@"Amount",@"Txn ID",@"Merchant ID",@"key",@"salt",@"phone",@"Firstname",@"Email",@"Product Info",@"SURL",@"FURL"];
    [self registerForKeyboardNotifications];
     numberToolbar= [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.sampleTblVw.tableFooterView =[self prepareFooterView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *cellId = @"cellID";
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [[cell.contentView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat xpos = 10;
    CGFloat ypos = 10;
    CGFloat height = 40;
    CGFloat width = self.sampleTblVw.frame.size.width - 20;

    UITextField *textfld = [[UITextField alloc]initWithFrame:CGRectMake(xpos, ypos, width, height)];
    textfld.placeholder = [NSString stringWithFormat:@"Enter %@",arr[indexPath.row]];
    textfld.borderStyle = UITextBorderStyleRoundedRect;
    textfld.tag = generictag+indexPath.row;
    textfld.delegate=self;
    textfld.inputAccessoryView = numberToolbar;
    [cell.contentView addSubview:textfld];
    
    return cell;
}

-(UIView *)prepareFooterView
{
    UIView *footerVw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIButton *paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [paybtn setTitle:@"Pay Now" forState:UIControlStateNormal];
    [paybtn setBackgroundColor:SDK_BROWN_COLOR];
    [paybtn setTitleColor:SDK_WHITE_COLOR forState:UIControlStateNormal];
    [paybtn setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 125, 25, 250, 50)];
    [paybtn addTarget:self action:@selector(payBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [footerVw addSubview:paybtn];
    return footerVw;
}


#pragma mark- START SDK
#pragma mark-

-(void)payBtnClicked
{
    // ASK below values from customers
    UITextField *txtFldAmount = (UITextField *)[self.view viewWithTag:generictag];
    
    // Validation for amount
    if ([self matchRegex:amountregex :txtFldAmount.text]){
        [self preprareInputParamsForSDKForAmount:txtFldAmount.text];
    }
    else{
        ALERT(SDK_APP_TITLE, @"Specify Amount");
    }
}




-(void)preprareInputParamsForSDKForAmount:(NSString*)amount{
    UITextField *txtFldTxnID = (UITextField *)[self.view viewWithTag:generictag+1];
    UITextField *txtFldPhone = (UITextField *)[self.view viewWithTag:generictag+5];
    UITextField *txtFldFirstName = (UITextField *)[self.view viewWithTag:generictag+6];
    UITextField *txtFldEmail = (UITextField *)[self.view viewWithTag:generictag+7];
    UITextField *txtFldProdInfo = (UITextField *)[self.view viewWithTag:generictag+8];
    
    
    
    
    // For Testing Purpose use static values
    NSString *txnID = [txtFldTxnID hasText]?txtFldTxnID.text : USER_INPUT_TXN_ID;
    NSString *phone = [txtFldPhone hasText]?txtFldPhone.text : USER_INPUT_PHONE;
    NSString *firstName = [txtFldFirstName hasText]?txtFldFirstName.text : USER_INPUT_FIRST_NAME;
    NSString *email = [txtFldEmail hasText]?txtFldEmail.text : USER_INPUT_EMAIL;
    NSString *prod_info = [txtFldProdInfo hasText]?txtFldProdInfo.text : USER_INPUT_PROD_INFO;
    
    
    
    // Prepare Input Dictionary
    NSMutableDictionary *dictParams = [NSMutableDictionary new];
    
    
    [dictParams setObject:amount forKey:SDK_amount];
    [dictParams setObject:firstName forKey:SDK_firstName];
    [dictParams setObject:phone forKey:SDK_phone];
    [dictParams setObject:email forKey:SDK_email];
    [dictParams setObject:prod_info forKey:SDK_productinfo];
    [dictParams setObject:txnID forKey:SDK_txnId];
    
    
    //TODO: Set values in App PayuMoneySDKAppConstant
    
    [dictParams setObject:MERCHANT_ID forKey:SDK_merchantId];
    [dictParams setObject:MERCHANT_KEY forKey:SDK_key];
    [dictParams setObject:MERCHANT_SALT forKey:SDK_salt];
    [dictParams setObject:MERCHANT_SURL forKey:SDK_surl];
    [dictParams setObject:MERCHANT_FURL forKey:SDK_furl];
    

    // Start SDK Call Here
    PayUmoneySDKPayment *objPaymentSDK = [[PayUmoneySDKPayment alloc] init];
    [objPaymentSDK startSDK:dictParams withCallBack:self];

    [self addObserverForSDKTransactionDetails];
}

// SDK Observers
-(void)addObserverForSDKTransactionDetails{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackFromPayUTransaction:) name:kNotificationTxnCompleted object:nil];
}

-(void)callBackFromPayUTransaction:(NSNotification*)notification
{
    UIStoryboard *sdkSB = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
    PayuMoneySDKFinalViewController *finalVC = [sdkSB instantiateViewControllerWithIdentifier:@"finalVC"];
    
    if([notification.object isEqual:kNotificationSuccessTxn])
    {
        finalVC.msg = @"congrats! Payment is successful!!";
    }
    else if([notification.object isEqual:kNotificationFailureTxn])
    {
        finalVC.msg = @"Oops!!! Payment Failed";
    }
    else if([notification.object isEqual:kNotificationRejectTxn]){
        finalVC.msg  = @"Payment Cancelled";
    }
    
    // Remove Notification Observers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTxnCompleted object:nil];

    
    // Pop to Current Controller
    [self.navigationController popToViewController:self animated:YES];
    
    [self.navigationController pushViewController:finalVC animated:YES];
}













-(void)cancelNumberPad{
    [activeTxtFld resignFirstResponder];
    activeTxtFld.text = @"";
}

-(void)doneWithNumberPad{
    
    [activeTxtFld resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeTxtFld = textField;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    activeTxtFld = nil;
}
-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShown : (NSNotification *)notification
{
    CGFloat value1 = value;
    CGFloat loc = ((activeTxtFld.tag-generictag)+1)*60;
    value = [self checkForKeyboard:activeTxtFld.frame.origin.y +loc withTextFieldHeight:activeTxtFld.frame.size.height withNotification :notification];
   
    
    [self.sampleTblVw setContentOffset:CGPointMake(0,value)];
}
-(CGFloat)checkForKeyboard : (CGFloat)yPos  withTextFieldHeight : (CGFloat)height  withNotification : (NSNotification *)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat scrheight = [UIScreen mainScreen].bounds.size.height;
    CGFloat originKeyboard = scrheight - kbSize.size.height;
    
    //    if (yPos + height >= kbSize.origin.y  - kbSize.size.height) {
    if (yPos + height >=  originKeyboard ) {
        
        //return yPos + height - (kbSize.origin.y - kbSize.size.height);
        return yPos + height - originKeyboard;
    }
    return 0.0f;
}
- (void)keyboardHide:(NSNotification *)notification
{
    [self.sampleTblVw setContentOffset:CGPointZero];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(BOOL)matchRegex : (NSString *)regex  : (NSString *)text
{
    NSError *err = NULL;
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&err];
    
    NSRange rangeOfFirstMatch = [exp rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        if(rangeOfFirstMatch.length == text.length)
            return YES;
    }
    return NO;
    
}


@end
