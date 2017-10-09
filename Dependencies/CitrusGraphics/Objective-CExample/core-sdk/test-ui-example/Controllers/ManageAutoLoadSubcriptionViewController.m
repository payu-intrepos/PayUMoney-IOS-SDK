//
//  ManageAutoLoadSubcriptionViewController.m
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 2/5/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import "ManageAutoLoadSubcriptionViewController.h"
#import "MerchantConstants.h"

@interface ManageAutoLoadSubcriptionViewController (){
    
    NSMutableArray *autoSubArrayArray;
    UIButton *lowerButton;
    UIButton *higherButton;
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
    UITextField *textField4;
    BOOL isDeactivateSub;
}

@end

@implementation ManageAutoLoadSubcriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indicatorView.hidden = TRUE;
    autoSubArrayArray = [[NSMutableArray alloc]init];
    [self getSubs];
    // Do any additional setup after loading the view.
    
    isDeactivateSub = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getSubs{
    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];
    CTSPaymentLayer *paymentlayer = [CitrusPaymentSDK fetchSharedPaymentLayer];

    
    [paymentlayer requestGetActiveAutoLoadSubscription:^(CTSAutoLoadSubResp *autoloadResponse, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
            
        });
        if (error) {
            if (isDeactivateSub == NO) {
                [UIUtility toastMessageOnScreen:[error localizedDescription]];
            }
        }
        else{
            autoSubArrayArray = [NSMutableArray arrayWithObject:autoloadResponse];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.autoLoadSubcriptionTableView reloadData];
                if (autoSubArrayArray.count==0) {
                    if (isDeactivateSub == NO) {
                        [UIUtility toastMessageOnScreen:@"No card is subscribed"];
                    }
                }
                
            });
        }

        
    }];
    
    
}



#pragma mark - TableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return autoSubArrayArray.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"autoloadIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    [cell.contentView viewWithTag:1000].layer.cornerRadius = 5;
     UISwitch *switchView;
    if (autoSubArrayArray.count>0) {
        
        NSDictionary *tempDict = [autoSubArrayArray objectAtIndex:indexPath.row];
        ((UILabel *) [cell.contentView viewWithTag:1001]).text = [tempDict valueForKey:@"card"];
        ((UILabel *) [cell.contentView viewWithTag:1002]).text = [tempDict valueForKey:@"subscriptionId"];
        ((UILabel *) [cell.contentView viewWithTag:1003]).text = [tempDict valueForKey:@"holder"];
        ((UILabel *) [cell.contentView viewWithTag:1004]).text = [tempDict valueForKey:@"expiry"];
        NSString *tempThresholdString = [NSString stringWithFormat:@"Threshold Amt: %@",[tempDict valueForKey:@"thresholdAmount"]];
        ((UILabel *) [cell.contentView viewWithTag:1005]).text = tempThresholdString;
        NSString *tempAutoloadString = [NSString stringWithFormat:@"Autoload Amt: : %@",[tempDict valueForKey:@"loadAmount"]];
        ((UILabel *) [cell.contentView viewWithTag:1006]).text = tempAutoloadString;
        
        for (id view in [cell.contentView viewWithTag:1000].subviews){
            if ([view isKindOfClass:[UISwitch class]]) {
                switchView  = (UISwitch *) view;
                switchView.tag = indexPath.row;
            }
            else if ([view isKindOfClass:[UIButton class]]){
                if ([((UIButton *) view).titleLabel.text isEqualToString:@"Update to Higher"]) {
                    higherButton = (UIButton *)view;
                    higherButton.layer.cornerRadius = 3;
                    higherButton.tag = indexPath.row;
                }
                else if ([((UIButton *) view).titleLabel.text isEqualToString:@"Update to Lower"]) {
                    lowerButton = (UIButton *)view;
                    lowerButton.tag = indexPath.row;
                    lowerButton.layer.cornerRadius = 3;
                }
            }
        }
        
        if ([[tempDict valueForKey:@"status"] isEqualToString:@"Active"]) {
            switchView.hidden = FALSE;
            [switchView setOn:YES animated:YES];
            lowerButton.hidden = FALSE;
            higherButton.hidden = FALSE;
        }
        else{
            lowerButton.hidden = TRUE;
            higherButton.hidden = TRUE;
            switchView.hidden = TRUE;
        }
        
    }
    [lowerButton addTarget:self action:@selector(updateToLower:) forControlEvents:UIControlEventTouchUpInside];
    [higherButton addTarget:self action:@selector(updateToHigher:) forControlEvents:UIControlEventTouchUpInside];
    
    [switchView addTarget:self action:@selector(setToInactiveSuscription:)forControlEvents:UIControlEventValueChanged];
    
    return cell;
}


#pragma mark - Action Methods
- (void) setToInactiveSuscription :(UISwitch*)tempSwitch{
    
    NSDictionary *tempDict = [autoSubArrayArray objectAtIndex:tempSwitch.tag];
    [self markSubscriptionInactive:[tempDict valueForKey:@"subscriptionId"]];
    
}


- (void) updateToLower:(UIButton *)button{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView *sendMoneyAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Subscription Update to Lower" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
        sendMoneyAlert.tag = 10001;
        sendMoneyAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        UITextField * alertTextField1 = [sendMoneyAlert textFieldAtIndex:0];
        alertTextField1.keyboardType = UIKeyboardTypeDecimalPad;
        alertTextField1.placeholder = @"Enter Threshold Amount.";
        
        UITextField * alertTextField2 = [sendMoneyAlert textFieldAtIndex:1];
        alertTextField2.keyboardType = UIKeyboardTypeDecimalPad;
        alertTextField2.placeholder = @"Enter lower Autoload Amount.";
        [alertTextField2  setSecureTextEntry:FALSE];
        
        [sendMoneyAlert show];
    });
    
}


- (void) updateToHigher:(UIButton *)button{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 110)];
    
    textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10,0,252,25)];
    textField1.borderStyle = UITextBorderStyleBezel;
    textField1.placeholder = @"Enter Threshold Amount.";
    textField1.font = [UIFont fontWithName:@"Verdana" size:13];
    textField1.keyboardType = UIKeyboardTypeDecimalPad;
    textField1.backgroundColor = [UIColor whiteColor];
    textField1.delegate = self;
    [view addSubview:textField1];
    
    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10,25,252,25)];
    textField2.placeholder = @"Enter higher Autoload Amount.";
    textField2.borderStyle = UITextBorderStyleBezel;
    textField2.keyboardType = UIKeyboardTypeDecimalPad;
    textField2.font = [UIFont fontWithName:@"Verdana" size:13];
    textField2.backgroundColor = [UIColor whiteColor];
    textField2.delegate = self;
    [view addSubview:textField2];
    
    
    textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10,50,252,25)];
    textField3.placeholder = @"Enter CVV";
    textField3.borderStyle = UITextBorderStyleBezel;
    textField3.keyboardType = UIKeyboardTypeNumberPad;
    textField3.backgroundColor = [UIColor whiteColor];
    textField3.font = [UIFont fontWithName:@"Verdana" size:13];
    textField3.delegate = self;
    [view addSubview:textField3];
    
    textField4 = [[UITextField alloc] initWithFrame:CGRectMake(10,75,252,25)];
    textField4.borderStyle = UITextBorderStyleBezel;
    textField4.placeholder = @"Enter credit card number.";
    textField4.font = [UIFont fontWithName:@"Verdana" size:13];
    textField4.keyboardType = UIKeyboardTypeNumberPad;
    textField4.backgroundColor = [UIColor whiteColor];
    textField4.delegate = self;
    [view addSubview:textField4];
    
     dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Subscription Update to Higher" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alertView setValue:view  forKey:@"accessoryView"];
        
        alertView.tag = 10002;
        [alertView show];
     });
    
}



-(void)markSubscriptionInactive:(NSString *)subscriptionId{
    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];
    [[CTSPaymentLayer fetchSharedPaymentLayer] requestDeactivateAutoLoadSubId:subscriptionId completion:^(CTSAutoLoadSubResp *autoloadResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
            
        });
        isDeactivateSub = YES;
        if(error == nil){
            [self getSubs];
            [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"subscription %@\n updated to : %@",autoloadResponse.subscriptionId,autoloadResponse.status]];
        }
        else {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
    }];
}



-(void)updateSubscriptionToLowerWithLowerAutoloadAmount:(NSString *)amount andWithThresholdAmount:(NSString *)thresholdAmount{
    
    NSDictionary *tempDict = [autoSubArrayArray objectAtIndex:lowerButton.tag];
    if (![self checkValueIsDecimal:amount]) {
        amount = [amount stringByAppendingString:@".00"];
    }
    if (![self checkValueIsDecimal:thresholdAmount]) {
        thresholdAmount = [thresholdAmount stringByAppendingString:@".00"];
    }
    if (([thresholdAmount doubleValue] >=500.00) && ([amount doubleValue] <= [[tempDict valueForKey:@"loadAmount"] doubleValue])){
        self.indicatorView.hidden = FALSE;
        [self.indicatorView startAnimating];
        
        [[CTSPaymentLayer fetchSharedPaymentLayer] requestUpdateAutoLoadSubId:[tempDict valueForKey:@"subscriptionId"] autoLoadAmount:amount thresholdAmount:thresholdAmount completion:^(CTSAutoLoadSubResp *autoloadResponse, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorView stopAnimating];
                self.indicatorView.hidden = TRUE;
                
            });
            if (error) {
                [UIUtility toastMessageOnScreen:[error localizedDescription]];
            }
            else{
                [self getSubs];
                [UIUtility toastMessageOnScreen: [NSString stringWithFormat:@"sbscription updated %@",[self toReadableString:autoloadResponse]]];
            }
        }];
    }
    else{
    
        [UIUtility toastMessageOnScreen:@"Threshold amount should be greater than 500 and Autoload amount should be less than previous value"];
    }
    
}



- (void)updateSubscriptionToHigherWithHigherAutoloadAmount:(NSString *)amount withThresholdAmount:(NSString *)thresholdAmount withCvv:(NSString *)cvv andCardNumber:(NSString *)cardNumber{
    
    NSDictionary *tempDict = [autoSubArrayArray objectAtIndex:higherButton.tag];
    if (![self checkValueIsDecimal:amount]) {
        amount = [amount stringByAppendingString:@".00"];
    }
    if (![self checkValueIsDecimal:thresholdAmount]) {
        thresholdAmount = [thresholdAmount stringByAppendingString:@".00"];
    }
    if (([amount doubleValue] > [[tempDict valueForKey:@"loadAmount"] doubleValue])) {
    
        self.indicatorView.hidden = FALSE;
        [self.indicatorView startAnimating];
        
//        CTSPaymentDetailUpdate *creditCardInfo = [[CTSPaymentDetailUpdate alloc] init];
//        // Update card for card payment.
//        CTSElectronicCardUpdate *creditCard = [[CTSElectronicCardUpdate alloc] initCreditCard];
//        creditCard.number = cardNumber;
//        creditCard.expiryDate = [tempDict valueForKey:@"expiry"];
//        creditCard.scheme = [CTSUtility fetchCardSchemeForCardNumber:cardNumber];
//        creditCard.ownerName = [tempDict valueForKey:@"holder"];
//        creditCard.cvv = cvv;
//        [creditCardInfo addCard:creditCard];
        
        
        CTSPaymentOptions *creditCardInfo = [CTSPaymentOptions creditCardOption:cardNumber
                                                                  cardExpiryDate:[tempDict valueForKey:@"expiry"]
                                                                             cvv:cvv];

        CTSLoadMoney *loadMoney = [[CTSLoadMoney alloc ] init];
        loadMoney.paymentInfo = creditCardInfo;
        loadMoney.contactInfo = nil;
        loadMoney.userAddress = nil;
        loadMoney.amount = @"1";
        loadMoney.returnUrl = self.returnUrl;
        loadMoney.custParams = nil;
        loadMoney.controller = self;
        
        CTSAutoLoad *autoload = [[CTSAutoLoad alloc]init];
        autoload.autoLoadAmt = amount;
        autoload.thresholdAmount = thresholdAmount;
        
        [[CTSPaymentLayer fetchSharedPaymentLayer] requestLoadAndIncrementAutoloadSubId:[tempDict valueForKey:@"subscriptionId"] loadMoney:loadMoney autoLoad:autoload withCompletionHandler:^(CTSLoadAndPayRes *loadAndSubscribe, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorView stopAnimating];
                self.indicatorView.hidden = TRUE;
                
            });
            if(error == nil){
                LogTrace(@"loadAndSubscribe %@",loadAndSubscribe.autoLoadResp);
                LogTrace(@"loadAndSubscribe %@",loadAndSubscribe.loadMoneyResponse);
                [self getSubs];
                [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"autoloadSubscriptions %@",[self toReadableString:loadAndSubscribe.autoLoadResp]]];
            }
            else {
                [UIUtility toastMessageOnScreen:[error localizedDescription]];
            }
        }];
    }
    else{
        
        [UIUtility toastMessageOnScreen:@"Autoload amount should be greater than previous values"];
    }
}

-(NSString *)toReadableString:(CTSAutoLoadSubResp *)load{
    NSString *string = [NSString stringWithFormat:@"subscriptionId: %@ \nthresholdAmount: %@ \nloadAmount: %@ \nstatus: %@ \nexpiry: %@\nholder: %@",load.subscriptionId,load.thresholdAmount,load.loadAmount,load.status,load.expiry,load.holder];
    return string;
}

#pragma mark - AlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.view endEditing:YES];
    
    if (alertView.tag ==10001){
        if (buttonIndex==1) {
            
            [self updateSubscriptionToLowerWithLowerAutoloadAmount:[alertView textFieldAtIndex:1].text andWithThresholdAmount:[alertView textFieldAtIndex:0].text];
            
        }
    }
    else if (alertView.tag==10002) {
        if (buttonIndex==1) {

            [self updateSubscriptionToHigherWithHigherAutoloadAmount:textField2.text withThresholdAmount:textField1.text withCvv:textField3.text andCardNumber:textField4.text];
            
        }
    }

}

- (BOOL) checkValueIsDecimal:(NSString *)string{
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count==2) {
        return YES;
    }
    return NO;

}

@end

