//
//  PaymentVC.m
//  PayUMoneyExample
//
//  Created by Umang Arya on 7/3/17.
//  Copyright © 2017 PayU. All rights reserved.
//

#import "PaymentVC.h"
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>
#import "Constants.h"
#import "Utils.h"
#import "iOSDefaultActivityIndicator.h"
#import "EMISelectorViewController.h"

#define kInvaildVPAMessage @"Please enter a valid vpa"
#define kUnableToValidateVPAMessage @"Unable to validate VPA"
#define kUPIUnavailable @"UPI option is unavailable"

@interface PaymentVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    int selectedIndex;
}
@property (weak, nonatomic) IBOutlet UIView *vwCCDC;
@property (weak, nonatomic) IBOutlet UIView *vwNB;
@property (weak, nonatomic) IBOutlet UITableView *vwStoredCard;
@property (weak, nonatomic) IBOutlet UITextField *tfCCNum;
@property (weak, nonatomic) IBOutlet UITextField *tfExpMonth;
@property (weak, nonatomic) IBOutlet UITextField *tfExpYear;
@property (weak, nonatomic) IBOutlet UITextField *tfCVV;
@property (weak, nonatomic) IBOutlet UITextField *tfBankCode;
@property (weak, nonatomic) IBOutlet UISwitch *switchUseWallet;
@property (weak, nonatomic) IBOutlet UILabel *lblUseWallet;
@property (weak, nonatomic) IBOutlet UISwitch *validateDetails;
@property (weak, nonatomic) IBOutlet UISwitch *saveCardSwitch;

@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;

@end

@implementation PaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.paymentMode == PUMPaymentModeCCDC) {
        self.vwCCDC.hidden = NO;
    }
    else if (self.paymentMode == PUMPaymentModeNetBanking || self.paymentMode == PUMPaymentMode3PWallet || self.paymentMode == PUMPaymentModeEMI){
        if (self.paymentMode == PUMPaymentModeEMI) {
            self.vwCCDC.hidden = NO;
        }
        self.vwStoredCard.hidden = NO;
    }
    else if (self.paymentMode == PUMPaymentModeStoredCard){
        self.vwStoredCard.hidden = NO;
        self.vwNB.hidden = NO;
    } else if (self.paymentMode == PUMPaymentModeUPI) {
        self.vwNB.hidden = NO;
        self.vwStoredCard.hidden = YES;
    }
    else if (self.paymentMode == PUMPaymentModeNone){
        [self btnTappedPayNow:nil];
    }
    self.switchUseWallet.hidden = NO;
    self.lblUseWallet.hidden = NO;
    selectedIndex = -1;
    if (!(self.paymentMode == PUMPaymentModeStoredCard || self.paymentMode == PUMPaymentModeNetBanking || self.paymentMode == PUMPaymentMode3PWallet || self.paymentMode == PUMPaymentModeEMI)){
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tapGesture];
    }
    
    [self checkIfUPIOptionAvaliable];
}
- (void)dismissKeyboard{
    [self.view endEditing:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkIfUPIOptionAvaliable {
    if (self.paymentMode == PUMPaymentModeUPI && ![[PayUMoneyCoreSDK sharedInstance] isUPIOptionAvailable]) {
        [self showAlertWithMessage:kUPIUnavailable];
    }
}

- (void)getBinDetails:(NSString *)cardNumber withCompletionBlock:(PUMRawJSONCompletionBlock)completionBlock {
    self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    
    [[PayUMoneyCoreSDK sharedInstance] getBinDetailsAPI:cardNumber withCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (!error) {
            if ([response[@"result"] isKindOfClass:[NSDictionary class]]) {
                completionBlock(response,error,extraParam);
            }
            else{
                [Utils showMsgWithTitle:@"Error" message:[PUMSDKError getErrorForCode:PUMErrorCardDetailFailed].localizedDescription];
            }
        }
        else{
            [Utils showMsgWithTitle:@"Error" message:error.localizedDescription];
        }
    }];
}

- (IBAction)btnTappedPayNow:(id)sender {
    PUMPaymentParam *paymentParam = [[PUMPaymentParam alloc] init];
    
    if (self.switchUseWallet.on) {
        paymentParam.useWallet = YES;
    }
    
    if (self.paymentMode == PUMPaymentModeCCDC) {
        [self setUpCardParamsForCCDC:paymentParam];
        paymentParam.paymentMode = PUMPaymentModeCCDC;
        
        __weak PaymentVC *weakSelf = self;
        [self getBinDetails:paymentParam.objCCDC.cardNumber withCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
            NSDictionary *result = response[@"result"];
            paymentParam.objCCDC.pg = result[@"category"];
            paymentParam.objCCDC.cardType = result[@"binOwner"];
            paymentParam.objCCDC.countryCode = result[@"countryCode"];
            
            [weakSelf showWebView:paymentParam];
        }];
    }
    else if (self.paymentMode == PUMPaymentMode3PWallet && selectedIndex>=0){
        paymentParam.obj3PWallet.bankCode = [[[self.arrNetBank objectAtIndex:selectedIndex] allKeys] firstObject];
        paymentParam.paymentMode = PUMPaymentMode3PWallet;
        [self showWebView:paymentParam];
    }
    else if (self.paymentMode == PUMPaymentModeEMI && selectedIndex>=0){
        [self setUpCardParamsForEMI:paymentParam];
        paymentParam.paymentMode = PUMPaymentModeEMI;
        
        __weak PaymentVC *weakSelf = self;
        [self getBinDetails:paymentParam.objEMI.cardNumber withCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
            NSDictionary *result = response[@"result"];
            paymentParam.objEMI.pg = EMI;
            paymentParam.objEMI.cardType = result[@"binOwner"];
            paymentParam.objEMI.countryCode = result[@"countryCode"];
            paymentParam.objEMI.isCreditCard = ![[result[@"category"] lowercaseString] isEqualToString:@"dc"];
            [weakSelf openEMITenureScreen:paymentParam];
        }];
    }
    else if (self.paymentMode == PUMPaymentModeNetBanking && selectedIndex>=0){
        paymentParam.objNetBanking.bankCode = [[[self.arrNetBank objectAtIndex:selectedIndex] allKeys] firstObject];
        paymentParam.paymentMode = PUMPaymentModeNetBanking;
        [self showWebView:paymentParam];
    }
    else if (self.paymentMode == PUMPaymentModeStoredCard && selectedIndex>=0){
        PUMSaveCardBO* savedCard = [[PUMSaveCardBO alloc] initWithResponse:[self.arrStoredCard objectAtIndex:selectedIndex]];
        paymentParam.objSavedCard = savedCard;
        paymentParam.paymentMode = PUMPaymentModeStoredCard;
        paymentParam.objSavedCard.cvv = self.tfBankCode.text;
        [self showWebView:paymentParam];
    } else if (self.paymentMode == PUMPaymentModeUPI) {
        [self checkForValidVPA];
    } else if (self.paymentMode == PUMPaymentModeNone){
        paymentParam.paymentMode = PUMPaymentModeNone;
        paymentParam.useWallet = YES;
        [self showWebView:paymentParam];
    }
    
}

- (void)setUpCardParamsForCCDC:(PUMPaymentParam *)params {
    params.objCCDC.cardNumber = self.tfCCNum.text;
    params.objCCDC.expiryMonth = self.tfExpMonth.text;
    params.objCCDC.expiryYear = self.tfExpYear.text;
    params.objCCDC.cvv = self.tfCVV.text;
    params.objCCDC.shouldSave = _saveCardSwitch.isOn;
    params.objCCDC.validateDetails = self.validateDetails.isOn;
}

- (void)setUpCardParamsForEMI:(PUMPaymentParam *)params {
    params.objEMI.cardNumber = self.tfCCNum.text;
    params.objEMI.expiryMonth = self.tfExpMonth.text;
    params.objEMI.expiryYear = self.tfExpYear.text;
    params.objEMI.cvv = self.tfCVV.text;
    params.objEMI.shouldSave = _saveCardSwitch.isOn;
    params.objEMI.validateDetails = self.validateDetails.isOn;
}

-(void)openEMITenureScreen:(PUMPaymentParam *)paymentParam {
    NSDictionary *emiDictionary = [self.arrNetBank objectAtIndex:selectedIndex];
    
    EMISelectorViewController *emiSelectorVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EMISelectorViewController"];
    [emiSelectorVC setBankCode:[[emiDictionary allKeys] firstObject]];
    [emiSelectorVC setPaymentParams:paymentParam];
    [self.navigationController pushViewController:emiSelectorVC animated:YES];
}

-(void)showWebView:(PUMPaymentParam *)paymentParam{
    [[PayUMoneyCoreSDK sharedInstance] setOrderDetails:[self testOrderDetailsArray]];
    [[PayUMoneyCoreSDK sharedInstance] showWebViewWithPaymentParam:paymentParam
                                                  onViewController:self
                                               withCompletionBlock:^(NSDictionary *response, NSError *error, NSError *validationError, id extraParam) {
                                                   if (validationError) {
                                                       [Utils showMsgWithTitle:@"Error" message:validationError.localizedDescription];
                                                   }
                                                   else{
                                                       if (!response) {
                                                           response = [[NSDictionary alloc] init];
                                                       }
                                                       [[NSNotificationCenter defaultCenter] postNotificationName:PaymentCompletion object:[NSDictionary dictionaryWithObjectsAndKeys:response,RESPONSE,error,ERROR, nil]];
                                                   }
                                               }];
}

- (NSArray *)testOrderDetailsArray {
    return @[@{@"From":@"Delhi"}, @{@"To":@"Pune"}];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)proceedWithVPA:(NSString *)vpa {
    PUMUPI *upiObject = [PUMUPI new];
    upiObject.vpa = vpa;
    
    PUMPaymentParam *paymentParam = [PUMPaymentParam new];
    paymentParam.objUPI = upiObject;
    paymentParam.paymentMode = PUMPaymentModeUPI;
    paymentParam.useWallet = self.switchUseWallet.isOn;
    [self showWebView:paymentParam];
}

#pragma mark - API -

- (void)checkForValidVPA {
    [self.view endEditing:YES];
    NSString *vpa = [self.tfBankCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    __weak PaymentVC *weakSelf = self;
    
    self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    
    [[PayUMoneyCoreSDK sharedInstance] validateVPA:vpa completion:^(BOOL isValidVPA, NSError *error) {
        [weakSelf.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (error) {
            [weakSelf showAlertWithMessage:kUnableToValidateVPAMessage];
        } else {
            if (isValidVPA) {
                [weakSelf proceedWithVPA:vpa];
            } else {
                [weakSelf showAlertWithMessage:kInvaildVPAMessage];
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.paymentMode != PUMPaymentModeStoredCard ){
        return self.arrNetBank.count;
    }
    else{
        return self.arrStoredCard.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.paymentMode != PUMPaymentModeStoredCard ){
        NSDictionary *eachNetBank = [self.arrNetBank objectAtIndex:indexPath.row];
        if (_paymentMode == PUMPaymentModeEMI) {
            NSDictionary *firstEMIOption = [[[[eachNetBank allValues] firstObject] allValues] firstObject];
            cell.textLabel.text = [firstEMIOption valueForKey:@"bank"];
        }
        else {
            cell.textLabel.text = [[[eachNetBank allValues] firstObject] objectForKey:@"title"];
        }
        cell.detailTextLabel.text = [[eachNetBank allKeys] firstObject];
    }
    else{
        NSDictionary *eachStoredCard = [self.arrStoredCard objectAtIndex:indexPath.row];
        cell.textLabel.text = [eachStoredCard objectForKey:@"ccnum"];
        cell.detailTextLabel.text = [eachStoredCard objectForKey:@"cardName"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (self.paymentMode == PUMPaymentModeNetBanking){
    //        self.tfBankCode.text = [[self tableView:tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text copy];
    //    }
    selectedIndex = (int)indexPath.row;
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
