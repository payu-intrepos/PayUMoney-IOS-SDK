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
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;

@end

@implementation PaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.paymentMode == PUMPaymentModeCCDC) {
        self.vwCCDC.hidden = NO;
    }
    else if (self.paymentMode == PUMPaymentModeNetBanking){
        self.vwNB.hidden = NO;
    }
    else if (self.paymentMode == PUMPaymentModeStoredCard){
        self.vwStoredCard.hidden = NO;
        self.vwNB.hidden = NO;
    }
    else if (self.paymentMode == PUMPaymentModeNone){
        [self btnTappedPayNow:nil];
    }
    self.switchUseWallet.hidden = NO;
    self.lblUseWallet.hidden = NO;
    selectedIndex = -1;
    if (self.paymentMode != PUMPaymentModeStoredCard){
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tapGesture];
    }
    // Do any additional setup after loading the view.
}
- (void)dismissKeyboard{
    [self.view endEditing:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnTappedPayNow:(id)sender {
    PUMPaymentParam *paymentParam = [[PUMPaymentParam alloc] init];
    
    if (self.switchUseWallet.on) {
        paymentParam.useWallet = YES;
    }
    
    if (self.paymentMode == PUMPaymentModeCCDC) {
        paymentParam.objCCDC.cardNumber = self.tfCCNum.text;
        paymentParam.objCCDC.expiryMonth = self.tfExpMonth.text;
        paymentParam.objCCDC.expiryYear = self.tfExpYear.text;
        paymentParam.objCCDC.cvv = self.tfCVV.text;
        paymentParam.paymentMode = PUMPaymentModeCCDC;
        
        
        
        self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];
        [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
        
        [[PayUMoneyCoreSDK sharedInstance] getBinDetailsAPI:paymentParam.objCCDC.cardNumber withCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
            [self.defaultActivityIndicator stopAnimatingActivityIndicator];
            if (!error) {
                if ([response[@"result"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *result = response[@"result"];
                    paymentParam.objCCDC.pg = result[@"category"];
                    paymentParam.objCCDC.cardType = result[@"binOwner"];
                    if (self.validateDetails.on){
                        paymentParam.objCCDC.validateDetails = YES;
                    }
                    
                    [self showWebView:paymentParam];
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
    else if (self.paymentMode == PUMPaymentModeNetBanking){
        paymentParam.objNetBanking.bankCode = self.tfBankCode.text;
        paymentParam.paymentMode = PUMPaymentModeNetBanking;
        [self showWebView:paymentParam];
    }
    else if (self.paymentMode == PUMPaymentModeStoredCard && selectedIndex>=0){
        PUMSaveCardBO* savedCard = [[PUMSaveCardBO alloc] initWithResponse:[self.arrStoredCard objectAtIndex:selectedIndex]];
        paymentParam.objSavedCard = savedCard;
        paymentParam.paymentMode = PUMPaymentModeStoredCard;
        paymentParam.objSavedCard.cvv = self.tfBankCode.text;
        [self showWebView:paymentParam];
    }
    else if (self.paymentMode == PUMPaymentModeNone){
        paymentParam.paymentMode = PUMPaymentModeNone;
        paymentParam.useWallet = YES;
        [self showWebView:paymentParam];
    }
    
}

-(void)showWebView:(PUMPaymentParam *)paymentParam{
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrStoredCard.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *eachStoredCard = [self.arrStoredCard objectAtIndex:indexPath.row];
    cell.textLabel.text = [eachStoredCard objectForKey:@"ccnum"];
    cell.detailTextLabel.text = [eachStoredCard objectForKey:@"cardName"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndex = (int)indexPath.row;
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
