//
//  CardsViewController.m
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import "CardsViewController.h"
#import "HMSegmentedControl.h"
#import "AutoloadViewController.h"

@interface CardsViewController () <UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *array;
    UITextField *currentTextField;
    UISegmentedControl *_segControl;
    NSArray *debitArray;
    NSArray *creditArray;
    NSMutableArray *_savedAccountsArray;
    NSMutableArray *_balancesArray;
    NSMutableArray *_banksArray;
    NSDictionary *netBankingDict;
    NSInteger selectedRow;
    NSString *cvvText;
    NSMutableDictionary *imageDict;
    UISwitch *switchView;
    
    CTSPaymentOptions *_paymentOptions;
    NSDecimalNumber *mvcEnteredAmount;
    NSDecimalNumber *prepiadEnteredAmount;
    NSDecimalNumber *otherEnteredAmount;
    NSDecimalNumber *remainingAmount_tobePaid;
    NSDecimalNumber *totalEnteredAmount;
    
    NSDecimalNumber *transactionAmount;
    
    BOOL _useMVC;
    BOOL _useCash;
    BOOL _useOther;
    BOOL _useNewCardNB;
    BOOL _useOtherWas;
    
    CTSSimpliChargeDistribution *_amountDistribution;
    BOOL _allSet;
    NSString *selectedPaymentoption;
    NSIndexPath *oldIndexPath;
    NSIndexPath *selectedIndexPath;
    NSDictionary *oldDictionary;
    BOOL _useSavedAccounts;
    
    NSDecimalNumber *_mvcMaxBalance;
    NSDecimalNumber *_cashMaxBalance;
    NSDecimalNumber *_totalSelectedAmount;
    
    BOOL isAnySubscriptionActive;
    UISwitch *autoloadSwitch;
    UIView *pickerToolBarView;
    
    NSInteger _cardNumberMaxLimit;
    NSInteger _cardNumberMiniLimit;
    NSInteger _cvvNumberLimit;
    NSString *selectedPayment;
}
@end

@implementation CardsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedIndexPath = nil;
    selectedRow = NSNotFound;
    
    selectedPayment = [[NSString alloc] init];

    _cardNumberMaxLimit = 19;
    _cvvNumberLimit = 4;

    NSDecimal zero = [NSDecimalNumber zero].decimalValue;
    mvcEnteredAmount = [NSDecimalNumber decimalNumberWithDecimal:zero];
    prepiadEnteredAmount = [NSDecimalNumber decimalNumberWithDecimal:zero];
    otherEnteredAmount = [NSDecimalNumber decimalNumberWithDecimal:zero];
    remainingAmount_tobePaid = [NSDecimalNumber decimalNumberWithDecimal:zero];
    
    _useMVC = NO;
    _useCash = NO;
    _useOther = NO;
    _allSet = YES;
    _useNewCardNB = NO;
    
    oldDictionary = [[NSDictionary alloc] init];
    selectedRow = NSNotFound;
    selectedPaymentoption = [[NSString alloc] init];
    self.amount = [NSString stringWithFormat:@"%.02f", [self.amount floatValue]];
    
    NSDecimal myFloatDecimal = [[NSNumber numberWithFloat:[self.amount floatValue]] decimalValue];
    transactionAmount = [NSDecimalNumber decimalNumberWithDecimal:myFloatDecimal];
    
    [self initialSetting];
    LogTrace(@"landingscreeen : %d",self.landingScreen);
    
    _paymentOptions = [CTSPaymentOptions new];
    
    /*
    [[CTSPaymentLayer fetchSharedPaymentLayer] requestCardBINService:@"4377486998511289"
                                                   completionHandler:^(CTSCardBinJSON *cardBinJSON,
                                                                       NSError *error) {
    }];
    [[CTSPaymentLayer fetchSharedPaymentLayer] requestAuthCardBINService:@"4377486998511289" completionHandler:^(CTSCardBinJSON *cardBinJSON, NSError *error) {
    }];
     */
    
//    [[CTSPaymentLayer fetchSharedPaymentLayer] requestMerchantPgSettings:@"jazzcinemas" withCompletionHandler:^(CTSPgSettings *pgSettings, NSError *error) {
//        if(error){
//            //handle error
//            LogTrace(@"[error localizedDescription] %@ ", [error localizedDescription]);
//        }
//        else {
//            LogTrace(@"pgSettings %@ ", pgSettings);
//        }
//    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [switchView setOn:NO animated:YES];
    [autoloadSwitch setOn:NO animated:YES];
    
    if (self.landingScreen == 0) {
        self.title = [NSString stringWithFormat:@"Load Money for Amount : %@", self.amount];
    }
    else if (self.landingScreen == 2){
        self.title = [NSString stringWithFormat:@"Payment for Amount : %@", self.ruleInfo.originalAmount];
        self.amount = self.ruleInfo.originalAmount;
        NSDecimal myFloatDecimal = [[NSNumber numberWithFloat:[self.amount floatValue]] decimalValue];
        transactionAmount = [NSDecimalNumber decimalNumberWithDecimal:myFloatDecimal];
    }
    else {
        self.title = [NSString stringWithFormat:@"Payment for Amount : %@", self.amount];
    }
}

#pragma mark - Initial Setting Methods

- (void) initialSetting {
    
    // Button & View setting
    self.indicatorView.hidden = TRUE;
    self.loadButton.layer.cornerRadius = 4;
    //    [self.saveCardsTableView setHidden:TRUE];
    self.netBankCodeTextField.hidden = TRUE;
    
    
    array =[[NSArray alloc]init];
    _savedAccountsArray =[[NSMutableArray alloc] init];
    _balancesArray =[[NSMutableArray alloc] init];
    _banksArray =[[NSMutableArray alloc] init];
    
    if (self.landingScreen == 0) {
        [self requestLoadMoneyPgSettings];
    }
    else {
        [self requestPaymentModes];
    }
    
    
    if (!self.isDirectPaymentEnable) {
        if (self.landingScreen==1) {
            [self calculatePaymentDistribution];
        }
        [self getSaveCards:nil];
    }
    
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard:)];
    [self.ccddtableView addGestureRecognizer:tapRecognizer];
    
//    [self.pickerView setHidden:TRUE];
    
//    UIToolbar *accessoryToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//    accessoryToolbar.barTintColor = [UIColor orangeColor];
//    // Configure toolbar .....
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePickerView)];
//    
//    [accessoryToolbar setItems:[NSArray arrayWithObjects:doneButton, nil] animated:YES];
    
//    self.netBankCodeTextField.inputView = self.pickerView;
//    self.netBankCodeTextField.inputAccessoryView = accessoryToolbar;
    
    
    pickerToolBarView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height/1.5, self.view.frame.size.width,200)];
    [pickerToolBarView setBackgroundColor:[UIColor whiteColor]];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,pickerToolBarView.frame.size.width,42)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePickerView)];
    [toolBar setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    
    self.aPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,toolBar.frame.size.height,toolBar.frame.size.width,200)];
    [self.aPickerView setDataSource: self];
    [self.aPickerView setDelegate: self];
    self.aPickerView.showsSelectionIndicator = YES;
    [self.aPickerView setBackgroundColor:[UIColor whiteColor]];
    
    [pickerToolBarView addSubview:toolBar];
    [pickerToolBarView addSubview:self.aPickerView];
    [self.view addSubview:pickerToolBarView];
    [self.view bringSubviewToFront:pickerToolBarView];
    [pickerToolBarView setHidden:YES];

    //Setting for Segment Control
    if (self.landingScreen==1) {
        
        self.title = @"Payment";
        NSString *string = [NSString stringWithFormat:@"Pay Rs %@",self.amount];
        [self.loadButton setTitle:string forState:UIControlStateNormal];
    }
    else if (self.landingScreen==0){
        self.title = @"Load Money";
        NSString *string = [NSString stringWithFormat:@"Load Rs %@",self.amount];
        [self.loadButton setTitle:string forState:UIControlStateNormal];
    }
    else if (self.landingScreen==2){
        self.title = @"Dynamic Pricing";
        NSString *string = [NSString stringWithFormat:@"Pay Rs %@",self.ruleInfo.originalAmount];
        [self.loadButton setTitle:string forState:UIControlStateNormal];
        
        self.amount = string;
    }
    
    // Segmented control with scrolling
    HMSegmentedControl *segmentedControl ;
    
    if (self.isDirectPaymentEnable) {
        segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Debit Card", @"Credit Card", @"Net Banking"]];
    }
    else{
        
        segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Saved Card", @"Debit Card", @"Credit Card", @"Net Banking"]];
    }
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    segmentedControl.frame = CGRectMake(0, 64, viewWidth, 45);
    segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.verticalDividerEnabled = YES;
    segmentedControl.verticalDividerColor = [UIColor whiteColor];
    segmentedControl.verticalDividerWidth = 1.5f;
    [segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        return attString;
    }];
    [segmentedControl addTarget:self action:@selector(loadUsingCard:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
    
    [self loadUsingCard:nil];
    imageDict = [[CTSDataCache sharedCache] fetchCachedDataForKey:BANK_LOGO_KEY];
    
    
}

- (void)calculatePaymentDistribution {
    
    [[CTSPaymentLayer fetchSharedPaymentLayer] requestCalculatePaymentDistribution:self.amount
                             completionHandler:^(CTSSimpliChargeDistribution *amountDistribution,
                                                 NSError *error) {
                                 
                                 if (error) {
                                     NSLog(@"error %@", [error localizedDescription]);
                                 }
                                 else {
                                     _amountDistribution = amountDistribution;
                                     _useMVC = amountDistribution.useMVC;
                                     _useCash = amountDistribution.useCash;
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [self.saveCardsTableView reloadData];
                                     });
                                 }
                                 
                             }];
    
}


#pragma mark - Action Methods

- (IBAction)loadUsingCard:(id)sender {
    
    _segControl = (UISegmentedControl *)sender;
    
    [self.view endEditing:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resetUI];
    });
    [pickerToolBarView setHidden:TRUE];
    self.loadButton.hidden = FALSE;
    self.loadButton.userInteractionEnabled = TRUE;
    
    if (self.isDirectPaymentEnable) {
        if (_segControl.selectedSegmentIndex==0 ||
            _segControl.selectedSegmentIndex==1) {
            
            [self.saveCardsTableView setHidden:TRUE];
            self.ccddtableView.hidden = FALSE;
            self.netBankCodeTextField.hidden = TRUE;
            
        }
        else if (_segControl.selectedSegmentIndex==2){
            
            [self.saveCardsTableView setHidden:TRUE];
            self.ccddtableView.hidden = TRUE;
            self.netBankCodeTextField.hidden = FALSE;
            self.loadButton.userInteractionEnabled = FALSE;
        }
    }
    else {
        if (_segControl.selectedSegmentIndex==0){
            
            [self.saveCardsTableView setHidden:FALSE];
            self.ccddtableView.hidden = TRUE;
            self.netBankCodeTextField.hidden = TRUE;
            self.loadButton.hidden = FALSE;
            
            _useSavedAccounts = YES;
            if (self.landingScreen == 1) {
                _useNewCardNB = NO;
                _useOther = NO;
                
                selectedIndexPath = nil;
                selectedRow = NSNotFound;
                
                [self removePaymentOption:@"Debit-Card"];
                [self removePaymentOption:@"Credit-Card"];
                [self removePaymentOption:@"Net-Banking"];
            }
         }
        else if (_segControl.selectedSegmentIndex==1 ||
                 _segControl.selectedSegmentIndex==2) {
            
            [self.saveCardsTableView setHidden:TRUE];
            self.ccddtableView.hidden = FALSE;
            self.netBankCodeTextField.hidden = TRUE;
            
            [self.ccddtableView reloadData];
            if (_segControl.selectedSegmentIndex==2) {
                if ([[CTSAuthLayer fetchSharedAuthLayer] isUserSignedIn]) {
                    [self getActiveSubs:nil];
                }
                [self removePaymentOption:@"Debit-Card"];
                [self removePaymentOption:@"Net-Banking"];
                [self appendingPaymentOption:@"Credit-Card"];
            }
            else {
                [self removePaymentOption:@"Credit-Card"];
                [self removePaymentOption:@"Net-Banking"];
                [self appendingPaymentOption:@"Debit-Card"];
            }
            
//            _useMVC = NO;
//            _useCash = NO;
//
            _useSavedAccounts = NO;

            if (self.landingScreen == 1) {
                _useNewCardNB = YES;
                
                if([self.saveCardsTableView cellForRowAtIndexPath:selectedIndexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
                    [self.saveCardsTableView cellForRowAtIndexPath:selectedIndexPath].accessoryType = UITableViewCellAccessoryNone;
                }
            }

         }
        else if (_segControl.selectedSegmentIndex==3){
            
            [self.saveCardsTableView setHidden:TRUE];
            self.ccddtableView.hidden = TRUE;
            self.netBankCodeTextField.hidden = FALSE;
            self.loadButton.userInteractionEnabled = FALSE;
            
            _useSavedAccounts = NO;
            
            if (self.landingScreen == 1) {
                _useNewCardNB = YES;
                
                [self removePaymentOption:@"Debit-Card"];
                [self removePaymentOption:@"Credit-Card"];
                [self appendingPaymentOption:@"Net-Banking"];
                
                if([self.saveCardsTableView cellForRowAtIndexPath:selectedIndexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
                    [self.saveCardsTableView cellForRowAtIndexPath:selectedIndexPath].accessoryType = UITableViewCellAccessoryNone;
                }
            }

        }
        else if (_segControl.selectedSegmentIndex==4){
            
            [self.saveCardsTableView setHidden:TRUE];
            self.ccddtableView.hidden = TRUE;
            self.netBankCodeTextField.hidden = TRUE;
            self.loadButton.hidden = TRUE;
            
            _useSavedAccounts = NO;
            if (self.landingScreen == 1) {
                _useNewCardNB = YES;
            }
            
         }
        
    }
}

- (IBAction)getSaveCards:(id)sender {
    
    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];
    
    [[CTSProfileLayer fetchSharedProfileLayer] requestPaymentInformationWithCompletionHandler:^(CTSConsumerProfile * consumerProfile,
                                                                   NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
            
        });
        if(error){
            // Your code to handle error.
            [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Couldn't find saved cards \nerror: %@",[error localizedDescription]]];
        }
        else {
            // Your code to handle success.
            
//            // get saved NetBanking payment options
//            NSArray  *netBankingArray = [consumerProfile getSavedNBPaymentOptions];
//            // get saved Debit cards payment options
//            NSArray  *debitCardArray = [consumerProfile getSavedDCPaymentOptions];
//            // get saved Credit cards payment options
//            NSArray  *creditCardArray = [consumerProfile getSavedCCPaymentOptions];
            
            if ([_balancesArray count] != 0) {
                [_balancesArray removeAllObjects];
            }
            
            if ([_savedAccountsArray count] != 0) {
                [_savedAccountsArray removeAllObjects];
            }
            
            NSMutableString *toastString = [[NSMutableString alloc] init];
            if([consumerProfile.paymentOptionsList count])
            {
                for (NSDictionary *dict in [consumerProfile.paymentOptionsList mutableCopy]) {
                    if ([[dict valueForKey:@"paymentMode"] isEqualToString:@"MVC"]) {
                        [_balancesArray addObject:dict];
                        NSDecimal myFloatDecimal = [[NSNumber numberWithFloat:[[dict valueForKey:@"maxBalance"] floatValue]] decimalValue];
                        _mvcMaxBalance = [NSDecimalNumber decimalNumberWithDecimal:myFloatDecimal];
                    }
                    else if ([[dict valueForKey:@"paymentMode"] isEqualToString:@"PREPAID_CARD"]) {
                        [_balancesArray addObject:dict];
                        NSDecimal myFloatDecimal = [[NSNumber numberWithFloat:[[dict valueForKey:@"maxBalance"] floatValue]] decimalValue];
                        _cashMaxBalance = [NSDecimalNumber decimalNumberWithDecimal:myFloatDecimal];
                    }
                    else {
                        [_savedAccountsArray addObject:dict];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.saveCardsTableView reloadData];
                });
                
            }
            else{
                toastString =(NSMutableString *) @"No saved cards, please save card first";
                [UIUtility toastMessageOnScreen:toastString];
            }
        }
    }];
}

- (IBAction)saveCard:(id)sender {
    
    self.loadButton.userInteractionEnabled = TRUE;
    
    [self setPaymentInfoForSmartPay];
    
    switchView = (UISwitch *)sender;
    
    NSString *resultantDate;
    if (self.expiryDateTextField.text.length!=0) {
        NSArray* subStrings = [self.expiryDateTextField.text componentsSeparatedByString:@"/"];
        int year = [[subStrings objectAtIndex:1] intValue]+2000;
        resultantDate = [NSString stringWithFormat:@"%d/%d",[[subStrings objectAtIndex:0] intValue],year];
    }
    
    if (self.cardNumberTextField.text.length>0) {
        NSString *scheme = [CTSUtility fetchCardSchemeForCardNumber:self.cardNumberTextField.text];
        if ([scheme isEqualToString:@"MTRO"] && self.cvvTextField.text.length==0 && self.expiryDateTextField.text.length==0) {
            self.expiryDateTextField.text = @"11/2019";
            self.cvvTextField.text = @"123";
        }
    }
    
    // Configure your request here.
    if (self.cardNumberTextField.text.length==0 || self.expiryDateTextField.text.length==0 || self.cvvTextField.text.length==0 || self.ownerNameTextField.text.length==0) {
        [UIUtility toastMessageOnScreen:@"Couldn't save this card.\n All fields are mandatory."];
        [switchView setOn:NO animated:YES];
    }
    else if (![CTSUtility validateExpiryDate:resultantDate]){
        [UIUtility toastMessageOnScreen:@"Expiry date is not valid."];
        [switchView setOn:NO animated:YES];
    }
    else{
        
        [[CTSProfileLayer fetchSharedProfileLayer] updatePaymentInfo:_paymentOptions
                         withCompletionHandler:^(NSError *error) {
                             self.loadButton.userInteractionEnabled = TRUE;
                             if(error == nil){
                                 // Your code to handle success.
                                 [UIUtility toastMessageOnScreen:@"Successfully card saved"];
                             }
                             else {
                                 [switchView setOn:NO animated:YES];
                                 // Your code to handle error.
                                 [UIUtility toastMessageOnScreen:error.localizedDescription];
                             }
                         }];
    }
    
}


-(void)requestLoadMoneyPgSettings {
    
    [[CTSPaymentLayer fetchSharedPaymentLayer] requestLoadMoneyPgSettingsCompletionHandler:^(CTSPgSettings *pgSettings, NSError *error){
        if(error){
            //handle error
            LogTrace(@"[error localizedDescription] %@ ", [error localizedDescription]);
        }
        else {
            debitArray = [CTSUtility fetchMappedCardSchemeForSaveCards:[[NSSet setWithArray:pgSettings.debitCard] allObjects] ];
            creditArray = [CTSUtility fetchMappedCardSchemeForSaveCards:[[NSSet setWithArray:pgSettings.creditCard] allObjects] ];
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
            
            
            LogTrace(@" pgSettings %@ ", pgSettings);
            for (NSString* val in creditArray) {
                LogTrace(@"CC %@ ", val);
            }
            
            for (NSString* val in debitArray) {
                LogTrace(@"DC %@ ", val);
            }
            
            _banksArray = pgSettings.netBanking;
            
            for (NSDictionary* arr in pgSettings.netBanking) {
                //setting the object for Issuer bank code in Dictionary
                [tempDict setObject:[arr valueForKey:@"issuerCode"] forKey:[arr valueForKey:@"bankName"]];
                
                LogTrace(@"bankName %@ ", [arr valueForKey:@"bankName"]);
                LogTrace(@"issuerCode %@ ", [arr valueForKey:@"issuerCode"]);
                
            }
            netBankingDict = tempDict;
        }
        
    }];
    
    
}

- (void)requestPaymentModes {
    CTSKeyStore *keyStore = [CTSUtility fetchCachedKeyStore];

    [[CTSPaymentLayer fetchSharedPaymentLayer] requestMerchantPgSettings:keyStore.vanity withCompletionHandler:^(CTSPgSettings *pgSettings, NSError *error) {
        if(error){
            //handle error
            LogTrace(@"[error localizedDescription] %@ ", [error localizedDescription]);
        }
        else {
            debitArray = [CTSUtility fetchMappedCardSchemeForSaveCards:[[NSSet setWithArray:pgSettings.debitCard] allObjects] ];
            creditArray = [CTSUtility fetchMappedCardSchemeForSaveCards:[[NSSet setWithArray:pgSettings.creditCard] allObjects] ];
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
            _banksArray = pgSettings.netBanking;
            
            for (NSDictionary* arr in pgSettings.netBanking) {
                //setting the object for Issuer bank code in Dictionary
                [tempDict setObject:[arr valueForKey:@"issuerCode"] forKey:[arr valueForKey:@"bankName"]];                
            }
            netBankingDict = tempDict;
        }
    }];
}

- (void)updateSwitchAtIndexPath:(UISwitch *)localSwitchView {
    
    if ([localSwitchView isOn]) {
        [localSwitchView setOn:YES animated:YES];
        [self saveCard:localSwitchView];
    } else {
        [localSwitchView setOn:NO animated:YES];
        
    }
    
}

- (IBAction)loadOrPayMoney:(id)sender {
    _allSet = YES;
    if (self.landingScreen==1) {
        [self setPaymentInfoForSmartPay];
        [self paymentSummary];
    }
    else if(self.landingScreen==0){
        [self setPaymentInfoForSmartPay];
        [self paymentSummary];
    }
    else if(self.landingScreen==2){
        [self setPaymentInfoForSmartPay];
        [self paymentSummary];
    }
}

- (void)loadOrPayDPMoney {
    if (self.landingScreen==1) {
        if (_allSet) {
            [self simpliPay];
        }
    }
    else if(self.landingScreen==0){
        if (_allSet) {
            [self loadMoneyInCitrusPay];
        }
    }
    else if(self.landingScreen==2){
        if (_allSet) {
            [self dynamicPricing];
        }
    }
}


- (BOOL)validateCardSchemesBanks {
    [self.view endEditing:YES];
    if ([self.expiryDateTextField.text length] != 0) {
        NSArray* subStrings = [self.expiryDateTextField.text componentsSeparatedByString:@"/"];
        if ([subStrings count] != 1) {
            int year = [[subStrings objectAtIndex:1] intValue]+2000;
            NSString *resultantDate = [NSString stringWithFormat:@"%d/%d",[[subStrings objectAtIndex:0] intValue],year];
            if (![CTSUtility validateExpiryDate:resultantDate]){
                [UIUtility toastMessageOnScreen:@"Expiry date is not valid."];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.indicatorView stopAnimating];
                    self.indicatorView.hidden = TRUE;
                });
                return NO;
            }
            else {
                return YES;
            }
        }
        else {
            [UIUtility toastMessageOnScreen:@"Expiry date is not valid."];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.indicatorView stopAnimating];
                self.indicatorView.hidden = TRUE;
            });
            return NO;
        }
    }
    return 0;
}

- (void)setPaymentInfoForSmartPay {
    
    
    _allSet = YES;
    
    NSDecimal zero = [NSDecimalNumber zero].decimalValue;
    totalEnteredAmount = [NSDecimalNumber decimalNumberWithDecimal:zero];
    
    mvcEnteredAmount = [NSDecimalNumber decimalNumberWithDecimal:zero];
    prepiadEnteredAmount = [NSDecimalNumber decimalNumberWithDecimal:zero];
    otherEnteredAmount = [NSDecimalNumber decimalNumberWithDecimal:zero];
    
    NSDecimalNumber *remiainingAmount;
    remiainingAmount = [NSDecimalNumber decimalNumberWithDecimal:zero];
    
    
    if (self.landingScreen == 0 ||
        self.landingScreen == 2) {
        if (_useSavedAccounts || _useNewCardNB) {
            if (_useOther) {
                otherEnteredAmount = [otherEnteredAmount decimalNumberByAdding:transactionAmount];
                totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:otherEnteredAmount];
            }
        }
        else {
            otherEnteredAmount = [otherEnteredAmount decimalNumberByAdding:transactionAmount];
            totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:otherEnteredAmount];
        }
        
        LogTrace(@"_useOther");
        LogTrace(@"otherEnteredAmount %f", [otherEnteredAmount floatValue]);
        
        if ([totalEnteredAmount floatValue] != [transactionAmount floatValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Selected payment option is zero or more than transction amount.\nPlease try again"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        else {
            _totalSelectedAmount = totalEnteredAmount;
        }
    }
    else {
        if (_useSavedAccounts || _useNewCardNB) {
            
            if (_useMVC) {
                if ([_mvcMaxBalance floatValue] < [transactionAmount floatValue]) {
                    totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:_mvcMaxBalance];
                    mvcEnteredAmount = _mvcMaxBalance;
                }
                else {
                    totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:transactionAmount];
                    mvcEnteredAmount = totalEnteredAmount;
                }
                remiainingAmount = [transactionAmount decimalNumberBySubtracting:mvcEnteredAmount];
                
                LogTrace(@"_useMVC");
                LogTrace(@"mvcEnteredAmount %f", [mvcEnteredAmount floatValue]);
            }
            
            if (_useCash) {
                if ([remiainingAmount floatValue] == 0) {
                    if ([_cashMaxBalance floatValue] < [transactionAmount floatValue]) {
                        totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:_cashMaxBalance];
                        prepiadEnteredAmount = _cashMaxBalance;
                    }
                    else {
                        totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:transactionAmount];
                        prepiadEnteredAmount = transactionAmount;
                    }
                }
                else {
                    if ([_cashMaxBalance floatValue] < [remiainingAmount floatValue]) {
                        totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:_cashMaxBalance];
                        prepiadEnteredAmount = _cashMaxBalance;
                    }
                    else {
                        totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:remiainingAmount];
                        prepiadEnteredAmount = remiainingAmount;
                    }
                }
                
                if ([remiainingAmount floatValue] != 0) {
                    remiainingAmount = [transactionAmount decimalNumberBySubtracting:totalEnteredAmount];
                }
                else {
                    remiainingAmount = [transactionAmount decimalNumberBySubtracting:prepiadEnteredAmount];
                }
                
                LogTrace(@"_useCash");
                LogTrace(@"prepiadEnteredAmount %f", [prepiadEnteredAmount floatValue]);
            }
            
            if (_useOther || _useNewCardNB) {
                if ([remiainingAmount floatValue] != 0) {
                    totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:remiainingAmount];
                    otherEnteredAmount = remiainingAmount;
                }
                else if ([totalEnteredAmount floatValue] != 0 &&
                         !_useMVC &&
                         !_useCash) {
                    otherEnteredAmount = [transactionAmount decimalNumberBySubtracting:totalEnteredAmount];
                    totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:otherEnteredAmount];
                }
                else {
                    otherEnteredAmount = [otherEnteredAmount decimalNumberByAdding:transactionAmount];
                    totalEnteredAmount = [totalEnteredAmount decimalNumberByAdding:otherEnteredAmount];
                }
                LogTrace(@"_useOther");
                LogTrace(@"otherEnteredAmount %f", [otherEnteredAmount floatValue]);
            }
            
            if ([totalEnteredAmount floatValue] > [transactionAmount floatValue]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Selected payment option is more than transaction amount.\nPlease try again"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                [alert show];
                _allSet = NO;
                return;
            }
            else if ([totalEnteredAmount floatValue] < [transactionAmount floatValue]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Selected payment option is less than transaction amount.\nPlease try again"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                [alert show];
                _allSet = NO;
                return;
            }
            else {
                _totalSelectedAmount = totalEnteredAmount;
            }
        }
        else {
            otherEnteredAmount = [otherEnteredAmount decimalNumberByAdding:transactionAmount];
            _totalSelectedAmount = otherEnteredAmount;
            totalEnteredAmount = otherEnteredAmount;
            LogTrace(@"_useOther");
            LogTrace(@"otherEnteredAmount %f", [otherEnteredAmount floatValue]);
        }
    }
    LogTrace(@"totalEnteredAmount %f", [totalEnteredAmount floatValue]);
    
    _paymentOptions = nil;
    
    if (!_useMVC ||
        !_useCash ||
        [otherEnteredAmount floatValue] != 0.00) {
        NSString *cardNumber = [self.cardNumberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (self.isDirectPaymentEnable) {
            
            if (_segControl.selectedSegmentIndex == 0 ||
                _segControl.selectedSegmentIndex == 1) {
                if ([self validPaymentObject] == NO) {
                    _allSet = NO;
                    return;
                }
            }

            if (_segControl.selectedSegmentIndex==0 ||
                _segControl.selectedSegmentIndex==1) {
                if (cardNumber.length == 0 ||
                    self.expiryDateTextField.text.length == 0 ||
                    self.cvvTextField.text.length == 0) {
                    UIAlertView *cvvAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Payment details can't be blank.\nPlease enter correct payment details." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [cvvAlert show];
                    _allSet = NO;
                    return;
                }
            }
            
            if (_segControl.selectedSegmentIndex==0) {
                // Debit card
                _paymentOptions = [CTSPaymentOptions debitCardOption:cardNumber
                                                      cardExpiryDate:self.expiryDateTextField.text
                                                                 cvv:self.cvvTextField.text];
                selectedPaymentoption = cardNumber;
            }
            else if (_segControl.selectedSegmentIndex==1) {
                // Credit card
                _paymentOptions = [CTSPaymentOptions creditCardOption:cardNumber
                                                       cardExpiryDate:self.expiryDateTextField.text
                                                                  cvv:self.cvvTextField.text];
                selectedPaymentoption = cardNumber;
            }
            else if (_segControl.selectedSegmentIndex==2){
                NSString *code = [netBankingDict valueForKey:self.netBankCodeTextField.text];
                [_banksArray enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
                    /* Do something with |obj|. */
                    if ([obj[@"issuerCode"] isEqualToString:code]) {
                        selectedPaymentoption = obj[@"bankName"];
                    }
                }];
                
                _paymentOptions = [CTSPaymentOptions netBankingOption:selectedPaymentoption
                                                           issuerCode:code];
                
            }
            
        }
        else {
            
            if (_segControl.selectedSegmentIndex == 1 ||
                _segControl.selectedSegmentIndex == 2) {
                if ([self validPaymentObject] == NO) {
                    _allSet = NO;
                    return;
                }
            }

            if (_segControl.selectedSegmentIndex==1 ||
                _segControl.selectedSegmentIndex==2) {
                if (cardNumber.length == 0 ||
                    self.expiryDateTextField.text.length == 0 ||
                    self.cvvTextField.text.length == 0) {
                    UIAlertView *cvvAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Payment details can't be blank.\nPlease enter correct payment details." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [cvvAlert show];
                    _allSet = NO;
                    return;
                }
            }
            
            if (_segControl.selectedSegmentIndex==1) {
                // Debit card
                _paymentOptions = [CTSPaymentOptions debitCardOption:cardNumber
                                                      cardExpiryDate:self.expiryDateTextField.text
                                                                 cvv:self.cvvTextField.text];
                selectedPaymentoption = cardNumber;
            }
            else if (_segControl.selectedSegmentIndex==2) {
                // Credit card
                _paymentOptions = [CTSPaymentOptions creditCardOption:cardNumber
                                                       cardExpiryDate:self.expiryDateTextField.text
                                                                  cvv:self.cvvTextField.text];
                selectedPaymentoption = cardNumber;
            }
            else if (_segControl.selectedSegmentIndex==3){
                NSString *code = [netBankingDict valueForKey:self.netBankCodeTextField.text];
                [_banksArray enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
                    /* Do something with |obj|. */
                    if ([obj[@"issuerCode"] isEqualToString:code]) {
                        selectedPaymentoption = obj[@"bankName"];
                    }
                }];
                
                _paymentOptions = [CTSPaymentOptions netBankingOption:selectedPaymentoption
                                                           issuerCode:code];
                
            }
            else if (_segControl.selectedSegmentIndex==0){
                
                [_savedAccountsArray enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
                    /* Do something with |obj|. */
                    if ([[obj valueForKey:@"selected"] boolValue] == YES) {
                        selectedRow = idx;
                    }
                }];
                
                if (selectedRow != NSNotFound) {
                    
                    JSONModelError* jsonError;
                    CTSConsumerProfileDetails* consumerProfileDetails = [[CTSConsumerProfileDetails alloc]
                                                                         initWithDictionary:[_savedAccountsArray objectAtIndex:selectedRow]
                                                                         error:&jsonError];
                    
                    if ([consumerProfileDetails.paymentMode isEqualToString:@"DEBIT_CARD"]) {
                        [consumerProfileDetails setCvv:cvvText];
                        _paymentOptions = [CTSPaymentOptions debitCardTokenized:consumerProfileDetails];
                        selectedPaymentoption = consumerProfileDetails.name;
                    }
                    else if ([consumerProfileDetails.paymentMode isEqualToString:@"CREDIT_CARD"]) {
                        [consumerProfileDetails setCvv:cvvText];
                        _paymentOptions = [CTSPaymentOptions creditCardTokenized:consumerProfileDetails];
                        selectedPaymentoption = consumerProfileDetails.name;
                    }
                    else if ([consumerProfileDetails.paymentMode isEqualToString:@"NET_BANKING"]) {
                        _paymentOptions = [CTSPaymentOptions netBankingTokenized:consumerProfileDetails];
                        selectedPaymentoption = consumerProfileDetails.bank;
                    }
                }
            }
            
        }
    }
}

- (void)paymentSummary {
    
    if (_allSet) {
        NSString *message = [[NSString alloc] init];
        
        NSString *title;
        title = [NSString stringWithFormat:@"Payment Summary\n\nTotal Amount : %@", _totalSelectedAmount];
        
        if (_useSavedAccounts | _useNewCardNB) {
            if ([mvcEnteredAmount floatValue] != 0.0 || _useMVC) {
                message = [message stringByAppendingString:[NSString stringWithFormat:@"\nMVC Amount : %@", mvcEnteredAmount]];
            }
            
            if ([prepiadEnteredAmount floatValue] != 0.0 || _useCash) {
                message = [message stringByAppendingString:[NSString stringWithFormat:@"\nPrepaid Amount : %@", prepiadEnteredAmount]];
            }
        }
        
        if ([otherEnteredAmount floatValue] != 0.0) {
            message = [message stringByAppendingString:[NSString stringWithFormat:@"\nCharge Payment option : %@\nAmount : %@", selectedPaymentoption, otherEnteredAmount]];
         }
        
        if ([totalEnteredAmount floatValue] != 0.0) {
            message = [message stringByAppendingString:[NSString stringWithFormat:@"\nTotal selected amount : %@", totalEnteredAmount]];
        }

        if ([mvcEnteredAmount floatValue] != 0 ||
            [prepiadEnteredAmount floatValue] != 0 ||
            [otherEnteredAmount floatValue] != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"Not Now"
                                                      otherButtonTitles:@"Pay Now", nil];
                alert.tag = 2000;
                [alert show];
            });
        }
        
    }
}

- (void)appendingPaymentOption:(NSString *)option  {
    NSString *tempMessage = @"";
    if ([selectedPayment localizedCaseInsensitiveContainsString:option]) {
        if (self.landingScreen == 1) {
            self.title = [NSString stringWithFormat:@"Option:%@", selectedPayment];
        }
    }
    else {
        tempMessage = selectedPayment.length ? [selectedPayment stringByAppendingString:@"+"] : tempMessage;
        selectedPayment = [tempMessage stringByAppendingString:option];
 
        if (self.landingScreen == 1) {
            self.title = [NSString stringWithFormat:@"Option:%@", selectedPayment];
        }
    }
}

- (void)removePaymentOption:(NSString *)option  {
    if ([selectedPayment localizedCaseInsensitiveContainsString:option]) {
        if ([option isEqualToString:@"MVC"]) {
            if ([selectedPayment localizedCaseInsensitiveContainsString:@"+MVC"]) {
                option = [@"+" stringByAppendingString:option];
            }
            else if ([selectedPayment localizedCaseInsensitiveContainsString:@"MVC+"]) {
                option = [option stringByAppendingString:@"+"];
            }
        }
        else if ([option isEqualToString:@"Wallet"]) {
            if ([selectedPayment localizedCaseInsensitiveContainsString:@"+Wallet"]) {
                option = [@"+" stringByAppendingString:option];
            }
            else if ([selectedPayment localizedCaseInsensitiveContainsString:@"Wallet+"]) {
                option = [option stringByAppendingString:@"+"];
            }
        }
        else if ([option isEqualToString:@"Debit-Card"]) {
            if ([selectedPayment localizedCaseInsensitiveContainsString:@"+Debit-Card"]) {
                option = [@"+" stringByAppendingString:option];
            }
            else if ([selectedPayment localizedCaseInsensitiveContainsString:@"Debit-Card+"]) {
                option = [option stringByAppendingString:@"+"];
            }
        }
        else if ([option isEqualToString:@"Credit-Card"]) {
            if ([selectedPayment localizedCaseInsensitiveContainsString:@"+Credit-Card"]) {
                option = [@"+" stringByAppendingString:option];
            }
            else if ([selectedPayment localizedCaseInsensitiveContainsString:@"Credit-Card+"]) {
                option = [option stringByAppendingString:@"+"];
            }
        }
        else if ([option isEqualToString:@"Net-Banking"]) {
            if ([selectedPayment localizedCaseInsensitiveContainsString:@"+Net-Banking"]) {
                option = [@"+" stringByAppendingString:option];
            }
            else if ([selectedPayment localizedCaseInsensitiveContainsString:@"Net-Banking+"]) {
                option = [option stringByAppendingString:@"+"];
            }
        }
 
        selectedPayment = [[selectedPayment stringByReplacingOccurrencesOfString:option withString:@""] mutableCopy];

        if (self.landingScreen == 1) {
            self.title = [NSString stringWithFormat:@"Option:%@", selectedPayment];
        }
    }
    else {
        if (self.landingScreen == 1) {
            self.title = [NSString stringWithFormat:@"Option:%@", selectedPayment];
        }
    }
 }


- (void)simpliPay {
    NSString *totalSelectedAmount = [NSString stringWithFormat:@"%.02f", [_totalSelectedAmount floatValue]];
    
    // If you wish to use BillURL follow below signature
    PaymentType *paymentType;
    if ((!_useMVC && !_useCash) && _paymentOptions) {
        paymentType = [PaymentType PGPayment:totalSelectedAmount
                                     billUrl:self.billUrl
                               paymentOption:_paymentOptions
                                     contact:self.contactInfo
                                     address:self.addressInfo];
    }
    else if (_useMVC && !_useCash && !_paymentOptions) {
        paymentType = [PaymentType mvcPayment:totalSelectedAmount
                                      billUrl:self.billUrl
                                      contact:self.contactInfo
                                      address:self.addressInfo];
    }
    else if (_useCash && !_useMVC && !_paymentOptions) {
        paymentType = [PaymentType citrusCashPayment:totalSelectedAmount
                                             billUrl:self.billUrl
                                             contact:self.contactInfo
                                             address:self.addressInfo];
    }
    if ((_useMVC ||_useCash) || _paymentOptions) {
        paymentType = [PaymentType splitPayment:totalSelectedAmount
                                        billUrl:self.billUrl
                                         useMVC:_useMVC
                                        useCash:_useCash
                                  paymentOption:_paymentOptions
                                        contact:self.contactInfo
                                        address:self.addressInfo];
    }
    
    [[CTSPaymentLayer fetchSharedPaymentLayer] requestSimpliPay:paymentType
           andParentViewController:self
                 completionHandler:^(CTSPaymentReceipt *paymentReceipt, NSError *error) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         if (error) {
                             [UIUtility toastMessageOnScreen:[error localizedDescription]];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                         else {
                             NSString *paymentStatus = paymentReceipt.toDictionary[@"TxStatus"];
                             if ([paymentStatus length] == 0) {
                                 paymentStatus = paymentReceipt.toDictionary[@"Reason"];
                             }
                             
                             [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Payment Status: %@", paymentStatus]];
                             [self resetUI];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                     });
                 }];
    
    
    // optional
// If you wish to use CTSBill object follow below signature
/*
    [CTSUtility requestBillAmount:totalSelectedAmount
                          billURL:BillUrl
                         callback: ^(CTSBill *bill,
                                     NSError *error) {
                             if (error) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [self.indicatorView stopAnimating];
                                     self.indicatorView.hidden = TRUE;
                                 });
                                 [UIUtility toastMessageOnScreen:[error localizedDescription]];
                                 [self.navigationController popViewControllerAnimated:YES];
                                 return;
                             }
                             else {
                                 bill.customParameters = customParams; // optional
                                 
                                 PaymentType *paymentType;
                                 if ((!_useMVC && !_useCash) && _paymentOptions) {
                                     paymentType = [PaymentType PGPayment:totalSelectedAmount
                                                                  billObject:bill
                                                            paymentOption:_paymentOptions
                                                                  contact:contactInfo
                                                                  address:addressInfo];
                                 }
                                 if ((_useMVC ||_useCash) && _paymentOptions) {
                                     paymentType = [PaymentType splitPayment:totalSelectedAmount
                                                                  billObject:bill
                                                                      useMVC:_useMVC
                                                                     useCash:_useCash
                                                               paymentOption:_paymentOptions
                                                                     contact:contactInfo
                                                                     address:addressInfo];
                                 }
                                 else if (_useMVC && !_paymentOptions) {
                                     paymentType = [PaymentType mvcPayment:totalSelectedAmount
                                                                billObject:bill
                                                                   contact:contactInfo
                                                                   address:addressInfo];
                                 }
                                 else if (_useCash && !_paymentOptions) {
                                     paymentType = [PaymentType citrusCashPayment:totalSelectedAmount
                                                                       billObject:bill
                                                                          contact:contactInfo
                                                                          address:addressInfo];
                                 }
                                 
                                 [paymentLayer requestSimpliPay:paymentType
                                        andParentViewController:self
                                              completionHandler:^(CTSPaymentReceipt *paymentReceipt, NSError *error) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.indicatorView stopAnimating];
                                                      self.indicatorView.hidden = TRUE;
                                                  });
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (error) {
                                                          [UIUtility toastMessageOnScreen:[error localizedDescription]];
                                                          [self.navigationController popViewControllerAnimated:YES];
                                                      }
                                                      else {
 
                                                          NSString *paymentStatus = paymentReceipt.toDictionary[@"TxStatus"];
                                                          if ([paymentStatus length] == 0) {
                                                              paymentStatus = paymentReceipt.toDictionary[@"Reason"];
                                                          }
                                                          
                                                          [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Payment Status: %@", paymentStatus]];
                                                          [self resetUI];
                                                          [self.navigationController popViewControllerAnimated:YES];
                                                      }
                                                  });
                                              }];
                             }
                         }];
 */
}


- (void)loadMoneyInCitrusPay {
    NSString *totalSelectedAmount = [NSString stringWithFormat:@"%.02f", [_totalSelectedAmount floatValue]];
    
    PaymentType *paymentType;
    paymentType = [PaymentType loadMoney:totalSelectedAmount
                               returnUrl:self.returnUrl
                           paymentOption:_paymentOptions
                            customParams:self.customParams
                                 contact:self.contactInfo
                                 address:self.addressInfo];

    [[CTSPaymentLayer fetchSharedPaymentLayer] requestSimpliPay:paymentType
           andParentViewController:self
                 completionHandler:^(CTSPaymentReceipt *paymentReceipt, NSError *error) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         if (error) {
                             [UIUtility toastMessageOnScreen:[error localizedDescription]];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                         else {
                             [self resetUI];
                             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Load Money Status %@",[paymentReceipt.toDictionary valueForKey:LoadMoneyResponeKey]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                             
                             if (_segControl.selectedSegmentIndex==2) {
                                 alert.delegate = self;
                                 alert.tag = 102;
                             }
                             [alert show];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                     });
                 }];
}



- (void)dynamicPricing {
    NSString *totalSelectedAmount = [NSString stringWithFormat:@"%.02f", [_totalSelectedAmount floatValue]];

    // If you wish to use BillURL follow below signature
    PaymentType *paymentType;
    paymentType = [PaymentType performDynamicPricing:totalSelectedAmount
                                             billUrl:self.billUrl
                                       paymentOption:_paymentOptions
                                            ruleInfo:self.ruleInfo
                                         extraParams:nil
                                             contact:self.contactInfo
                                             address:self.addressInfo];
    
    //
    [[CTSPaymentLayer fetchSharedPaymentLayer] requestSimpliPay:paymentType
           andParentViewController:self
                 completionHandler:^(CTSPaymentReceipt *paymentReceipt, NSError *error) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         if (error) {
                             [UIUtility toastMessageOnScreen:[error localizedDescription]];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                         else {
                             NSString *paymentStatus = paymentReceipt.toDictionary[@"TxStatus"];
                             if ([paymentStatus length] == 0) {
                                 paymentStatus = paymentReceipt.toDictionary[@"Reason"];
                             }
                             
                             [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Payment Status: %@", paymentStatus]];
                             [self resetUI];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                     });
                 }];

    
    // optional
    // If you wish to use CTSBill object follow below signature
/*
    [CTSUtility requestDPBillForRule:self.ruleInfo
                             billURL:BillUrl
                            callback:^(CTSBill *bill, NSError *error) {
                                if (error) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self.indicatorView stopAnimating];
                                        self.indicatorView.hidden = TRUE;
                                    });
                                    
                                    [UIUtility toastMessageOnScreen:[error localizedDescription]];
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                                else {
                                    PaymentType *paymentType;
                                    paymentType = [PaymentType performDynamicPricing:totalSelectedAmount
                                                                          billObject:bill
                                                                       paymentOption:_paymentOptions
                                                                            ruleInfo:self.ruleInfo
                                                                         extraParams:nil
                                                                             contact:contactInfo
                                                                             address:addressInfo];
                                    
                                    //
                                    [paymentLayer requestSimpliPay:paymentType
                                           andParentViewController:self
                                                 completionHandler:^(CTSPaymentReceipt *paymentReceipt, NSError *error) {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self.indicatorView stopAnimating];
                                                         self.indicatorView.hidden = TRUE;
                                                     });
                                                     
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (error) {
                                                             [UIUtility toastMessageOnScreen:[error localizedDescription]];
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                         }
                                                         else {
 
                                                             NSString *paymentStatus = paymentReceipt.toDictionary[@"TxStatus"];
                                                             if ([paymentStatus length] == 0) {
                                                                 paymentStatus = paymentReceipt.toDictionary[@"Reason"];
                                                             }
                                                             
                                                             [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"Payment Status: %@", paymentStatus]];
                                                             [self resetUI];
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                         }
                                                     });
                                                 }];

                                }
                            }];
  */
}

- (void)resignKeyboard:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)hidePickerView{
    self.loadButton.userInteractionEnabled = TRUE;
    [currentTextField resignFirstResponder];
    [pickerToolBarView setHidden:YES];
}


-(IBAction)getActiveSubs:(id)sender{
    
    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];
    CTSPaymentLayer *paymentlayer = [CitrusPaymentSDK fetchSharedPaymentLayer];
    [paymentlayer requestGetAutoLoadSubType:AutoLoadSubsctiptionTypeActive completion:^(CTSAutoLoadSubGetResp *autoloadSubscriptions, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
        });
        if (error) {
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
        else{
            if (autoloadSubscriptions.subcriptions.count==0) {
                autoloadSwitch.userInteractionEnabled = TRUE;
                isAnySubscriptionActive = NO;
            }
            else{
                autoloadSwitch.userInteractionEnabled = FALSE;
                isAnySubscriptionActive = YES;
            }
        }
    }];
}

- (void)loadMoneyWithAutoloadView:(UISwitch *)localSwitchView {
    
    if ([localSwitchView isOn]) {
        [localSwitchView setOn:YES animated:YES];
        
        [self setPaymentInfoForSmartPay];
        if (self.cardNumberTextField.text.length==0 || self.expiryDateTextField.text.length==0 || self.cvvTextField.text.length==0) {
            //[UIUtility toastMessageOnScreen:@"Couldn't do Autoload.\n All fields are mandatory."];
            [localSwitchView setOn:NO animated:YES];
        }
        else {
            [self performSegueWithIdentifier:@"AutoloadViewIdentifier" sender:self];
        }
        
    } else {
        [localSwitchView setOn:NO animated:YES];
        
    }
    
}


//#pragma mark - TextView Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.netBankCodeTextField resignFirstResponder];

    if (textField==self.netBankCodeTextField) {
        
        if (netBankingDict.count==0) {
            [pickerToolBarView setHidden:TRUE];
//            [self.netBankCodeTextField resignFirstResponder];
            [UIUtility toastMessageOnScreen:@"Please Contact to Citruspay care to enable your Net banking."];
        }
        else{
            [pickerToolBarView setHidden:NO];
            currentTextField=textField;
            array = [netBankingDict allKeys];
            [self.aPickerView reloadAllComponents];
            [self.aPickerView selectRow:0 inComponent:0 animated:YES];
            [self pickerView:self.aPickerView didSelectRow:0 inComponent:0];
//            [self.netBankCodeTextField becomeFirstResponder];
        }
    }
}
//
//-(BOOL)textField:(UITextField *)textField
//shouldChangeCharactersInRange:(NSRange)range
//replacementString:(NSString *)string {
//    
//    if (textField.tag == 2000) {
//        __block NSString *text = [textField text];
//        if ([textField.text isEqualToString:@""] || ( [string isEqualToString:@""] && textField.text.length==1)) {
//           // self.schemeTypeImageView.image = [CTSUtility getSchmeTypeImage:string forParentView:self.view];
//            [self.schemeTypeImageView setSystemActivity];
//            NSString* scheme = [CTSUtility fetchCardSchemeForCardNumber:string];
//            [self.schemeTypeImageView loadCitrusCardWithCardScheme:scheme];
//        }
//        
//        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
//        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
//            return NO;
//        }
//        
//        text = [text stringByReplacingCharactersInRange:range withString:string];
//        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
//        if (text.length>1) {
//            [self.schemeTypeImageView setSystemActivity];
//            NSString* scheme = [CTSUtility fetchCardSchemeForCardNumber:text];
//            [self.schemeTypeImageView loadCitrusCardWithCardScheme:scheme];
//           // self.schemeTypeImageView.image = [CTSUtility getSchmeTypeImage:text forParentView:self.view];
//        }
//        NSString *newString = @"";
//        while (text.length > 0) {
//            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
//            newString = [newString stringByAppendingString:subString];
//            if (subString.length == 4) {
//                newString = [newString stringByAppendingString:@" "];
//            }
//            text = [text substringFromIndex:MIN(text.length, 4)];
//        }
//        
//        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
//        if (newString.length>1) {
//            NSString* scheme = [CTSUtility fetchCardSchemeForCardNumber:[newString stringByReplacingOccurrencesOfString:@" " withString:@""]];
//            if ([scheme isEqualToString:@"MTRO"]) {
//                if (newString.length >= 24) {
//                    return NO;
//                }
//            }
//            else{
//                if (newString.length >= 24) {
//                    return NO;
//                }
//            }
//        }
//        
//        [textField setText:newString];
//        return NO;
//        
//    }
//    else if (textField==self.cvvTextField) {
//        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        int length = (int)[currentString length];
//        if (length > 4) {
//            return NO;
//        }
//    }
//    else if (textField==self.expiryDateTextField) {
//        __block NSString *text = [textField text];
//        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789/"];
//        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//        
//        text = [text stringByReplacingCharactersInRange:range withString:string];
//        NSArray* subStrings = [text componentsSeparatedByString:@"/"];
//        int month = [[subStrings objectAtIndex:0] intValue];
//        if(month > 12){
//            NSString *string=@"";
//            string = [string stringByAppendingFormat:@"0%@",text];
//            text = string;
//        }
//        text = [text stringByReplacingOccurrencesOfString:@"/" withString:@""];
//        if ([string isEqualToString:@""]) {
//            return YES;
//        }
//        
//        NSString *newString = @"";
//        while (text.length > 0) {
//            NSString *subString = [text substringToIndex:MIN(text.length, 2)];
//            newString = [newString stringByAppendingString:subString];
//            if (subString.length == 2 && ![newString containsString:@"/"]) {
//                newString = [newString stringByAppendingString:@"/"];
//            }
//            text = [text substringFromIndex:MIN(text.length, 2)];
//        }
//        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
//        
//        if (newString.length >=6) {
//            return NO;
//        }
//        
//        [textField setText:newString];
//        
//        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
//            return NO;
//        }
//        else{
//            return NO;
//        }
//    }
//    
//    return YES;
//    
//}

#pragma mark - TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.landingScreen == 0 ||
       self.landingScreen == 2){
        return 1;
    }
    else
        return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    //
    if (tableView == self.saveCardsTableView) {
        if(section == 0 &&
           self.landingScreen == 1) {
            return _balancesArray.count;
        }
        else if(section == 1 ||
                self.landingScreen == 0 ||
                self.landingScreen == 2){
            return _savedAccountsArray.count;
        }
    }
    else {
        if (_segControl.selectedSegmentIndex==2 && self.landingScreen==0) {
            return 5;
        }
        else if(section == 0) {
            return 4;
        }
    }
    return 0;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.saveCardsTableView) {
        if(section == 0 &&
           self.landingScreen == 1) {
            return @"Balance Accounts details";
        }
        else if(section == 1 ||
                self.landingScreen == 0 ||
                self.landingScreen == 2){
            return @"Saved Accounts details";
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.saveCardsTableView) {
        return 120;
    }
    else
        return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.ccddtableView) {
        if (indexPath.section == 0) {
            NSString *simpleTableIdentifier =[NSString stringWithFormat:@"test%d",(int)indexPath.row];
            cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            }
            if (indexPath.row==0) {
                self.cardNumberTextField = (UITextField *)[cell.contentView viewWithTag:2000];
                self.cardNumberTextField.delegate = self;
                self.schemeTypeImageView = (UIImageView *)[cell.contentView viewWithTag:2001];
            }
            if (indexPath.row==1) {
                self.expiryDateTextField = (UITextField *)[cell.contentView viewWithTag:2002];
                self.expiryDateTextField.delegate = self;
                self.cvvTextField = (UITextField *)[cell.contentView viewWithTag:2004];
                self.cvvTextField.delegate = self;
            }
            if (indexPath.row==2) {
                self.ownerNameTextField = (UITextField *)[cell.contentView viewWithTag:2006];
                self.ownerNameTextField.delegate = self;
                
            }
            if (indexPath.row==3) {
                UISwitch *localSwitchView = (UISwitch *)[cell.contentView viewWithTag:2005];
                [localSwitchView addTarget:self action:@selector(updateSwitchAtIndexPath:)forControlEvents:UIControlEventValueChanged];
            }
            if (indexPath.row==4) {
                autoloadSwitch = (UISwitch *)[cell.contentView viewWithTag:2007];
                [autoloadSwitch addTarget:self action:@selector(loadMoneyWithAutoloadView:)forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    else if (tableView == self.saveCardsTableView){
        
        if (indexPath.section == 0 &&
            self.landingScreen == 1) {
            static NSString *CellIdentifier = @"balanceIdentifier";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.contentView viewWithTag:1000].layer.cornerRadius = 5;
            
            NSDictionary *balanceDict = [_balancesArray objectAtIndex:indexPath.row];
            if ([balanceDict[@"paymentMode"]  isEqualToString:@"MVC"]) {
                ((UILabel *) [cell.contentView viewWithTag:1001]).text = balanceDict[@"paymentMode"];
                ((UILabel *) [cell.contentView viewWithTag:1002]).text = [NSString stringWithFormat:@"Your Current Balance is Rs : %.02f", [balanceDict[@"maxBalance"] floatValue]];
                
                if ([balanceDict[@"maxBalance"] floatValue] != 0.00) {
                    if (_useMVC) {
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        [self appendingPaymentOption:@"MVC"];
                    }
                }
                else {
                    ((UILabel *) [cell.contentView viewWithTag:1003]).text = @"Insufficient balance. Please tap on other payment option.";
                }
            }
            else if ([balanceDict[@"paymentMode"]  isEqualToString:@"PREPAID_CARD"]) {
                ((UILabel *) [cell.contentView viewWithTag:1001]).text = balanceDict[@"paymentMode"];
                ((UILabel *) [cell.contentView viewWithTag:1002]).text = [NSString stringWithFormat:@"Your Current Balance is Rs : %.02f", [balanceDict[@"maxBalance"] floatValue]];
                
                if ([balanceDict[@"maxBalance"] floatValue] != 0.00) {
                    if (_useCash) {
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        [self appendingPaymentOption:@"Wallet"];
                    }
                }
                else {
                    ((UILabel *) [cell.contentView viewWithTag:1003]).text = @"Insufficient balance. Please tap on other payment option.";
                }
            }
            
        }
        else if (indexPath.section == 1 ||
                 self.landingScreen == 0 ||
                 self.landingScreen == 2){
            static NSString *CellIdentifier = @"saveCardIdentifier";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.contentView viewWithTag:1000].layer.cornerRadius = 5;
            
            NSDictionary *accountsDict = [_savedAccountsArray objectAtIndex:indexPath.row];
            if ([accountsDict[@"paymentMode"]  isEqualToString:@"NET_BANKING"]) {
                ((UILabel *) [cell.contentView viewWithTag:1001]).text = (![accountsDict[@"name"]  isEqual: [NSNull null]]) ? accountsDict[@"name"] : @"";
                ((UILabel *) [cell.contentView viewWithTag:1002]).text = (![accountsDict[@"bank"]  isEqual: [NSNull null]]) ? accountsDict[@"bank"] : @"";
                ;
                ((UILabel *) [cell.contentView viewWithTag:1003]).text = @"";
                ((UILabel *) [cell.contentView viewWithTag:1004]).text = @"";
            }
            else {
                ((UILabel *) [cell.contentView viewWithTag:1001]).text = (![accountsDict[@"name"]  isEqual: [NSNull null]]) ? accountsDict[@"name"] : @"";
                ;
                ((UILabel *) [cell.contentView viewWithTag:1002]).text = (![accountsDict[@"cardNumber"]  isEqual: [NSNull null]]) ? accountsDict[@"cardNumber"] : @"";
                ;
                ((UILabel *) [cell.contentView viewWithTag:1003]).text = (![accountsDict[@"bank"]  isEqual: [NSNull null]]) ? accountsDict[@"bank"] : @"";
                ;
                NSString *cardExpiryDate = (![accountsDict[@"cardExpiryDate"]  isEqual: [NSNull null]]) ? accountsDict[@"cardExpiryDate"] : @"";
                
                if (cardExpiryDate.length != 0) {
                    NSMutableString *string = [cardExpiryDate mutableCopy];
                    [string insertString:@"/" atIndex:2];
                    ((UILabel *) [cell.contentView viewWithTag:1004]).text = string;
                }
            }
            
//            if (indexPath.row == 0) {
//                if (_useOther == YES) {
//                    selectedRow = indexPath.row;
//                    selectedIndexPath = indexPath;
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                    if ([accountsDict[@"paymentMode"]  isEqualToString:@"NET_BANKING"]) {
//                        selectedPaymentoption = accountsDict[@"bank"];
//                        [self appendingPaymentOption:@"Net-Banking"];
//                    }
//                    else if ([accountsDict[@"paymentMode"]  isEqualToString:@"DEBIT_CARD"]) {
//                        selectedPaymentoption = accountsDict[@"name"];
//                        [self appendingPaymentOption:@"Debit-Card"];
//                    }
//                    else if ([accountsDict[@"paymentMode"]  isEqualToString:@"CREDIT_CARD"]) {
//                        selectedPaymentoption = accountsDict[@"name"];
//                        [self appendingPaymentOption:@"Credit-Card"];
//                    }
//                }
//                else {
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                    if ([accountsDict[@"paymentMode"]  isEqualToString:@"NET_BANKING"]) {
//                        [self removePaymentOption:@"Net-Banking"];
//                    }
//                    else if ([accountsDict[@"paymentMode"]  isEqualToString:@"DEBIT_CARD"]) {
//                        [self removePaymentOption:@"Debit-Card"];
//                    }
//                    else if ([accountsDict[@"paymentMode"]  isEqualToString:@"CREDIT_CARD"]) {
//                        [self removePaymentOption:@"Credit-Card"];
//                    }
//
//                }
//            }

//            if ([accountsDict[@"selected"] boolValue] == YES &&
//                oldIndexPath == indexPath) {
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            }
//            else {
//                cell.accessoryType = UITableViewCellAccessoryNone;
//            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([accountsDict[@"paymentMode"] isEqualToString:@"NET_BANKING"]) {
                    [((UIImageView *) [cell.contentView viewWithTag:1005]) setSystemActivity];
                    [((UIImageView *) [cell.contentView viewWithTag:1005]) loadCitrusBankWithBankCID:(![accountsDict[@"issuerCode"]  isEqual: [NSNull null]]) ? accountsDict[@"issuerCode"] : @""];
                }
                else {
                    [((UIImageView *) [cell.contentView viewWithTag:1005]) setSystemActivity];
                    [((UIImageView *) [cell.contentView viewWithTag:1005]) loadCitrusCardWithCardScheme:(![accountsDict[@"cardScheme"]  isEqual: [NSNull null]]) ? accountsDict[@"cardScheme"] : @""];
                }
            });
            
        }
    }
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.saveCardsTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (indexPath.section == 0 &&
            self.landingScreen == 1) {
            NSMutableDictionary *balanceDict = [[NSMutableDictionary alloc] init];
            NSDictionary *oldDict = (NSDictionary *)[_balancesArray objectAtIndex:indexPath.row];
            [balanceDict addEntriesFromDictionary:oldDict];
            
            if ([balanceDict[@"maxBalance"] floatValue] != 0.00) {
                if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
                    if ([balanceDict[@"paymentMode"] isEqualToString:@"MVC"]) {
                        _useMVC = NO;
                        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
                        [self removePaymentOption:@"MVC"];
//                        if ([_cashMaxBalance floatValue] < [transactionAmount floatValue]) {
//                            _useCash = YES;
//                            NSIndexPath * newIndexPath = [NSIndexPath  indexPathForRow:indexPath.row+1 inSection:indexPath.section];
//                            [tableView cellForRowAtIndexPath:newIndexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//                            [self appendingPaymentOption:@"Wallet"];
//                        }
                        ((UILabel *) [[tableView cellForRowAtIndexPath:indexPath].contentView viewWithTag:1003]).text = @"Check row to pay using MVC payment options";
                    }
                    
                    if ([balanceDict[@"paymentMode"] isEqualToString:@"PREPAID_CARD"]) {
                        _useCash = NO;
                        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
                        [self removePaymentOption:@"Wallet"];
                        ((UILabel *) [[tableView cellForRowAtIndexPath:indexPath].contentView viewWithTag:1003]).text = @"Check row to pay using Prepaid payment options";
                    }
                    
                    if (![balanceDict[@"paymentMode"] isEqualToString:@"PREPAID_CARD"] &&
                        ![balanceDict[@"paymentMode"] isEqualToString:@"MVC"]) {
                        selectedRow = NSNotFound;
                    }
                }
                else {
                    if ([balanceDict[@"paymentMode"] isEqualToString:@"MVC"]) {
                        _useMVC = YES;
                        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
                        [self appendingPaymentOption:@"MVC"];
                        ((UILabel *) [[tableView cellForRowAtIndexPath:indexPath].contentView viewWithTag:1003]).text = @"Uncheck row to pay using other payment options";
                    }
                    
                    if ([balanceDict[@"paymentMode"] isEqualToString:@"PREPAID_CARD"]) {
                        _useCash = YES;
                        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
                        [self appendingPaymentOption:@"Wallet"];
                        ((UILabel *) [[tableView cellForRowAtIndexPath:indexPath].contentView viewWithTag:1003]).text = @"Uncheck row to pay using other payment options";
                    }
                    
                    if (![balanceDict[@"paymentMode"] isEqualToString:@"PREPAID_CARD"] &&
                        ![balanceDict[@"paymentMode"] isEqualToString:@"MVC"]) {
                        selectedRow = indexPath.row;
                    }
                    
                    if ([balanceDict[@"paymentMode"] isEqualToString:@"PREPAID_CARD"] ||
                        [balanceDict[@"paymentMode"] isEqualToString:@"MVC"]) {
                        [self setPaymentInfoForSmartPay];
                        [self paymentSummary];
                    }
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *cvvAlert = [[UIAlertView alloc] initWithTitle:@"Balance Accounts details" message:@"Insufficient balance.\n Please tap on other payment option." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [cvvAlert show];
                });
            }
        }
        if (indexPath.section == 1 ||
            self.landingScreen == 0 ||
            self.landingScreen == 2) {
            
            NSMutableDictionary *accountsDict = [[NSMutableDictionary alloc] init];
            NSDictionary *oldDict = (NSDictionary *)[_savedAccountsArray objectAtIndex:indexPath.row];
            [accountsDict addEntriesFromDictionary:oldDict];
            
            if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
                [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
                if ([accountsDict[@"paymentMode"]  isEqualToString:@"NET_BANKING"]) {
                    [self removePaymentOption:@"Net-Banking"];
                }
                else if ([accountsDict[@"paymentMode"]  isEqualToString:@"DEBIT_CARD"]) {
                    [self removePaymentOption:@"Debit-Card"];
                }
                else if ([accountsDict[@"paymentMode"]  isEqualToString:@"CREDIT_CARD"]) {
                    [self removePaymentOption:@"Credit-Card"];
                }

                selectedRow = NSNotFound;
                selectedIndexPath = nil;
                
                _useOther = NO;
                
                [accountsDict setObject:@"0" forKey:@"selected"];
                [_savedAccountsArray replaceObjectAtIndex:indexPath.row withObject:accountsDict];
                
                if (oldIndexPath != indexPath &&
                    oldDictionary != accountsDict) {
                    oldIndexPath = indexPath;
                    oldDictionary = accountsDict;
                }
            }
            else {
                [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
                if ([accountsDict[@"paymentMode"]  isEqualToString:@"NET_BANKING"]) {
                    [self appendingPaymentOption:@"Net-Banking"];
                }
                else if ([accountsDict[@"paymentMode"]  isEqualToString:@"DEBIT_CARD"]) {
                    [self appendingPaymentOption:@"Debit-Card"];
                }
                else if ([accountsDict[@"paymentMode"]  isEqualToString:@"CREDIT_CARD"]) {
                    [self appendingPaymentOption:@"Credit-Card"];
                }

                selectedRow = indexPath.row;
                selectedIndexPath = indexPath;
                
                if (oldIndexPath != nil &&
                    oldIndexPath != indexPath &&
                    oldDictionary != accountsDict) {
                    [tableView cellForRowAtIndexPath:oldIndexPath].accessoryType = UITableViewCellAccessoryNone;
                    if ([accountsDict[@"paymentMode"]  isEqualToString:@"NET_BANKING"]) {
                        [self removePaymentOption:@"Net-Banking"];
                    }
                    else if ([accountsDict[@"paymentMode"]  isEqualToString:@"DEBIT_CARD"]) {
                        [self removePaymentOption:@"Debit-Card"];
                    }
                    else if ([accountsDict[@"paymentMode"]  isEqualToString:@"CREDIT_CARD"]) {
                        [self removePaymentOption:@"Credit-Card"];
                    }

                    [accountsDict setObject:@"0" forKey:@"selected"];
                    [_savedAccountsArray replaceObjectAtIndex:oldIndexPath.row withObject:oldDictionary];
                }
                
                
                if ([accountsDict[@"paymentMode"] isEqualToString:@"NET_BANKING"]) {
                    _useOther = YES;
                    
                    if (oldIndexPath != indexPath &&
                        oldDictionary != accountsDict) {
                        oldIndexPath = indexPath;
                        oldDictionary = accountsDict;
                    }
                    
                    [accountsDict setObject:@"1" forKey:@"selected"];
                    [_savedAccountsArray replaceObjectAtIndex:indexPath.row withObject:accountsDict];
                    
                    
                    [self setPaymentInfoForSmartPay];
                    [self paymentSummary];
                    selectedPaymentoption = accountsDict[@"bank"];
                }
                else {
                    
                    JSONModelError* jsonError;
                    CTSConsumerProfileDetails* consumerProfileDetails = [[CTSConsumerProfileDetails alloc]
                                                                         initWithDictionary:[_savedAccountsArray objectAtIndex:indexPath.row]
                                                                         error:&jsonError];
                    
                    if ([accountsDict[@"paymentMode"] isEqualToString:@"DEBIT_CARD"]) {
                        _paymentOptions = [CTSPaymentOptions debitCardTokenized:consumerProfileDetails];
                    }
                    else if ([accountsDict[@"paymentMode"] isEqualToString:@"CREDIT_CARD"]) {
                        _paymentOptions = [CTSPaymentOptions creditCardTokenized:consumerProfileDetails];
                    }
                    
                    if ([_paymentOptions canDoOneTapPayment]) {
                        //do not prompt user for CVV
                        LogTrace(@"found Stored OneTap Paymentinfo, will do the OneTapPayment");
                        
                        _paymentOptions.cvv = nil;
                        cvvText = nil;
                        
                        _useOther = YES;
                        
                        
                        if (oldIndexPath != selectedIndexPath &&
                            oldDictionary != accountsDict) {
                            oldIndexPath = selectedIndexPath;
                            oldDictionary = accountsDict;
                        }
                        
                        [accountsDict setObject:@"1" forKey:@"selected"];
                        [_savedAccountsArray replaceObjectAtIndex:indexPath.row withObject:accountsDict];
                        
                        [self setPaymentInfoForSmartPay];
                        [self paymentSummary];
                        
                    }
                    else {
                        //get cvv from user
                        LogTrace(@"no oneTapPaymentInfo found for the token");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertView *cvvAlert = [[UIAlertView alloc] initWithTitle:@""
                                                                               message:@"Please enter cvv."
                                                                              delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
                            cvvAlert.tag = 100;
                            cvvAlert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                            UITextField *textField = [cvvAlert textFieldAtIndex:0];
                            textField.keyboardType = UIKeyboardTypeNumberPad;
                            textField.placeholder = @"cvv";
                            [cvvAlert show];
                        });
                    }
                    
                }
                
            }
        }
    }
}

#pragma mark - AlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [alertView dismissWithClickedButtonIndex:buttonIndex
                                    animated:NO];
    [self.view endEditing:YES];
    
    if (alertView.tag==100){
        NSMutableDictionary *accountsDict = [[NSMutableDictionary alloc] init];
        
        if (buttonIndex==1) {
            UITextField * alertTextField = [alertView textFieldAtIndex:0];
            [alertTextField resignFirstResponder];
            
            NSDictionary *oldDict = (NSDictionary *)[_savedAccountsArray objectAtIndex:selectedIndexPath.row];
            [accountsDict addEntriesFromDictionary:oldDict];
            
            cvvText = alertTextField.text;
            
            _useOther = YES;
            
            if (oldIndexPath != selectedIndexPath &&
                oldDictionary != accountsDict) {
                oldIndexPath = selectedIndexPath;
                oldDictionary = accountsDict;
            }
            
            [accountsDict setObject:@"1" forKey:@"selected"];
            [_savedAccountsArray replaceObjectAtIndex:selectedIndexPath.row withObject:accountsDict];
            
            [self setPaymentInfoForSmartPay];
            [self paymentSummary];
        }
        else {
            
            NSDictionary *oldDict = (NSDictionary *)[_savedAccountsArray objectAtIndex:oldIndexPath.row];
            [accountsDict addEntriesFromDictionary:oldDict];
            
            _useOther = NO;
            
            if (oldIndexPath != selectedIndexPath &&
                oldDictionary != accountsDict) {
                oldIndexPath = selectedIndexPath;
                oldDictionary = accountsDict;
            }
            
            [self.saveCardsTableView cellForRowAtIndexPath:oldIndexPath].accessoryType = UITableViewCellAccessoryNone;
            if ([accountsDict[@"paymentMode"]  isEqualToString:@"NET_BANKING"]) {
                [self removePaymentOption:@"Net-Banking"];
            }
            else if ([accountsDict[@"paymentMode"]  isEqualToString:@"DEBIT_CARD"]) {
                [self removePaymentOption:@"Debit-Card"];
            }
            else if ([accountsDict[@"paymentMode"]  isEqualToString:@"CREDIT_CARD"]) {
                [self removePaymentOption:@"Credit-Card"];
            }

            [accountsDict setObject:@"0" forKey:@"selected"];
            [_savedAccountsArray replaceObjectAtIndex:oldIndexPath.row withObject:accountsDict];
        }
    }
    else if (alertView.tag == 2000){
        if (buttonIndex==1) {
            [self loadOrPayDPMoney];
        }
    }
    else if (alertView.tag == 102){
        if (buttonIndex==0) {
            if (!isAnySubscriptionActive) {
                sleep(.3);
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self subscribeCard];
                });
            }
        }

    }
    else if (alertView.tag==103){
        
        if (buttonIndex==1) {
            
            [self suscribeAfterLoadWithThresholdAmount:[alertView textFieldAtIndex:0].text andWithLoadAmount:[alertView textFieldAtIndex:0].text];
            
        }
    }
    
}

-(IBAction)suscribeAfterLoadWithThresholdAmount:(NSString *)thresholdAmount andWithLoadAmount:(NSString *)loadAmount{
    CTSPaymentLayer *paymentlayer = [CitrusPaymentSDK fetchSharedPaymentLayer];
    CTSAutoLoad *autoload = [[CTSAutoLoad alloc]init];
    
    autoload.autoLoadAmt = loadAmount;
    autoload.thresholdAmount = thresholdAmount;
    
    self.indicatorView.hidden = FALSE;
    [self.indicatorView startAnimating];
    
    [paymentlayer requestSubscribeAutoAfterLoad:autoload withCompletionHandler:^(CTSAutoLoadSubResp *autoloadResponse, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
        });
        
        if(error){
            [UIUtility toastMessageOnScreen:[error localizedDescription]];
        }
        else{
            [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@"autoloadSubscriptions %@",autoloadResponse]];
        }
    }];
}

- (void) subscribeCard{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView *sendMoneyAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to subscribe this card?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
        sendMoneyAlert.tag = 103;
        sendMoneyAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        UITextField * alertTextField1 = [sendMoneyAlert textFieldAtIndex:0];
        alertTextField1.keyboardType = UIKeyboardTypeDecimalPad;
        alertTextField1.placeholder = @"Enter Threshold Amount.";
        
        UITextField * alertTextField2 = [sendMoneyAlert textFieldAtIndex:1];
        alertTextField2.keyboardType = UIKeyboardTypeDecimalPad;
        alertTextField2.placeholder = @"Enter Autoload Amount.";
        [alertTextField2  setSecureTextEntry:FALSE];
        
        [sendMoneyAlert show];
    });
    
}

#pragma mark - StoryBoard Delegate Methods
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"AutoloadViewIdentifier"]) {
        AutoloadViewController *viewController = (AutoloadViewController *)segue.destinationViewController;
        viewController.cardInfo = _paymentOptions;
        
    }
    
}


#pragma mark - PickerView Delegate Methods

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [array count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    currentTextField.text = [array objectAtIndex:row];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return [array objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UIView *tempView = view;
    
    UILabel *pickerLabel;
    UIImageView *imageView;
    if (!tempView)
    {
        tempView =[[UIView alloc]init];
        imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 5, 40, 40);
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, -5, self.view.bounds.size.width, 50)];
        pickerLabel.textColor = [UIColor darkGrayColor];
        pickerLabel.font = [UIFont fontWithName:@"Verdana-Semibold" size:15];
        pickerLabel.textAlignment = NSTextAlignmentLeft;
        pickerLabel.backgroundColor = [UIColor clearColor];
        

        [tempView addSubview:imageView];
        [tempView addSubview:pickerLabel];
    }
    
  //  imageView.image = [CTSUtility fetchBankLogoImageByBankIssuerCode:[[netBankingDict allValues] objectAtIndex:row] forParentView:self.view];
    
    [imageView setSystemActivity];
    [imageView loadCitrusBankWithBankCID:[[netBankingDict allValues] objectAtIndex:row]];

    [pickerLabel setText:[array objectAtIndex:row]];
    
    return tempView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED;
{
    return 50;
}
#pragma mark - Reset UI Methods

- (void) resetUI {
    self.cardNumberTextField.text = @"";
    self.ownerNameTextField.text = @"";
    self.expiryDateTextField.text = @"";
    self.cvvTextField.text = @"";
    self.netBankCodeTextField.text = @"";
    self.schemeTypeImageView.image = nil;
    self.cardNumberTextField.rightView = nil;
    [switchView setOn:NO animated:YES];
}

#pragma mark - Dealloc Methods

- (void) dealloc {
    self.cardNumberTextField = nil;
    self.ownerNameTextField = nil;
    self.expiryDateTextField = nil;
    self.cvvTextField = nil;
    self.netBankCodeTextField = nil;
    self.loadButton = nil;
    self.aPickerView = nil;
    self.indicatorView = nil;
    self.schemeTypeImageView = nil;
}

//
// all validation
- (BOOL)validPaymentObject {
    
//    CTSPaymentOptions *_paymentObject = nil;
    NSString *errorMessage = nil;
    
    NSString *scheme = [CTSUtility fetchCardSchemeForCardNumber:self.cardNumberValue];
    
    NSString *tempMessage = @"Please enter a ";
    if (![self hasValidateTextInput:self.cardNumberValue maxLimit:_cardNumberMaxLimit]) {
        errorMessage = [tempMessage stringByAppendingString:@"valid card number"];
    }
    else if ([scheme isEqualToString:@"UNKNOWN"]) {
        errorMessage = [tempMessage stringByAppendingString:@"valid card number"];
    }
    else  {
        NSString *errMsg = [self validateMiniLimit:self.cardNumberValue
                                          forDigit:_cardNumberMiniLimit
                                      errorMessage:@"valid card number"];
        if (errMsg.length) {
            errorMessage = [tempMessage stringByAppendingString:errMsg];
        }
    }
    
    if (![self validateExpiryDate:self.expiryDateTextField.text]) {
        tempMessage = errorMessage.length ? [errorMessage stringByAppendingString:@", "] : tempMessage;
        errorMessage = [tempMessage stringByAppendingString:@"valid expiry date"];
    }
    else if (![CTSUtility validateExpiryDate:self.expiryDateTextField.text]) {
        tempMessage = errorMessage.length ? [errorMessage stringByAppendingString:@", "] : tempMessage;
        errorMessage = [tempMessage stringByAppendingString:@"valid expiry date"];
    }
    else  {
        tempMessage = errorMessage.length ? [errorMessage stringByAppendingString:@", "] : tempMessage;
        NSString *errMsg = [self validateMiniLimit:self.expiryDateTextField.text
                                          forDigit:4
                                      errorMessage:@"valid expiry date"];
        
        if (errMsg.length) {
            errorMessage = [tempMessage stringByAppendingString:errMsg];
        }
    }
    
    if (![self hasValidateTextInput:self.cvvTextField.text maxLimit:_cvvNumberLimit]) {
        tempMessage = errorMessage.length ? [errorMessage stringByAppendingString:@" and "] : tempMessage;
        errorMessage = [tempMessage stringByAppendingString:@"valid CVV number"];
    }
    else  {
        tempMessage = errorMessage.length ? [errorMessage stringByAppendingString:@" and "] : tempMessage;
        NSString *errMsg = [self validateMiniLimit:self.cvvTextField.text
                                          forDigit:_cvvNumberLimit
                                      errorMessage:@"valid CVV number"];
        if (errMsg.length) {
            errorMessage = [tempMessage stringByAppendingString:errMsg];
        }
    }
    
    if (errorMessage != nil) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:errorMessage
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Ok", @"Ok action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    else {
//        _paymentObject = [CTSPaymentOptions creditCardOption:self.cardNumberValue
//                                              cardExpiryDate:[self.expiryDateTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]
//                                                         cvv:self.cvvTextField.text];
        
        return YES;
    }
    return 0;
}

- (void)getCardSchemeType:(NSString*)string {
    
    if (string.length > 0) {
        NSString *schemeType = [CTSUtility fetchCardSchemeForCardNumber:string];
        _cardNumberMaxLimit = [self cardNumberMaxLimitFromSchemeType:schemeType];
        _cardNumberMiniLimit = [self cardNumberMiniLimitFromSchemeType:schemeType];
        
    }
}

- (NSInteger)cardNumberMaxLimitFromSchemeType:(NSString *)schemeType {
    // references : https://en.wikipedia.org/wiki/Bank_card_number
    // Visa - mini=13, max=16 digit supported
    // Master Card - mini/max=16 digit supported
    // Diners - mini=14, 15, max=16  digit supported
    // Discover - mini/max=16 digit  supported
    // AMEX - mini/max=15 digit supported
    // MAESTRO - mini=15, max=19 digit supported
    // JCB - mini/max=16 digit supported
    NSInteger digit = 0;
    
    if ([schemeType isEqualToString:@"AMEX"]) {
        digit = 15; // AMEX 15 digit only supported
        _cvvNumberLimit = 4; // AMEX CVV 4 digit supported
    }
    else if ([schemeType isEqualToString:@"MTRO"]) {
        digit = 19; // MAESTRO 15-19 digit only supported
        _cvvNumberLimit = 3; // for others CVV 3 digit supported
    }
    else {
        digit = 16; // for others max 16 digit supported
        _cvvNumberLimit = 3; // for others CVV 3 digit supported
    }
    return digit;
}

- (NSInteger)cardNumberMiniLimitFromSchemeType:(NSString *)schemeType {
    // references : https://en.wikipedia.org/wiki/Bank_card_number
    // Visa - mini=13, max=16 digit supported
    // Master Card - mini/max=16 digit supported
    // Diners - mini=14, 15, max=16  digit supported
    // Discover - mini/max=16 digit  supported
    // AMEX - mini/max=15 digit supported
    // MAESTRO - mini=15, max=19 digit supported
    // JCB - mini/max=16 digit supported
    NSInteger digit = 0;
    
    if ([schemeType isEqualToString:@"VISA"]) {
        digit = 13; // Visa 13, 16 = max 16 digit only supported
    }
    else if ([schemeType isEqualToString:@"DINERS"]) {
        digit = 14; // Diners 14, 15, 16 = max 16 digit only supported
    }
    else if ([schemeType isEqualToString:@"AMEX"] ||
             [schemeType isEqualToString:@"MTRO"]) {
        digit = 15; // AMEX/Maestro Card 15-19 digit only supported
    }
    else {
        digit = 16; // for others max 16 digit supported
    }
    return digit;
}


- (void)updateCardTypeImage:(NSString*)string {
    
   // UIImageView *cardImage = nil;
    
    if (string.length > 0) {
//        cardImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, self.cardNumberTextField.bounds.size.height)];
//        self.cardNumberTextField.rightViewMode = UITextFieldViewModeAlways;
//        cardImage.backgroundColor = [UIColor clearColor];
//        cardImage.contentMode = UIViewContentModeScaleToFill;
//        [cardImage setContentMode:UIViewContentModeCenter];
        
        [self.schemeTypeImageView setSystemActivity];
        [self.schemeTypeImageView loadCitrusCardWithCardScheme:[CTSUtility fetchCardSchemeForCardNumber:string]];
        
        _cardNumberMaxLimit = [self cardNumberMaxLimitFromSchemeType:[CTSUtility fetchCardSchemeForCardNumber:string]];
        _cardNumberMiniLimit = [self cardNumberMiniLimitFromSchemeType:[CTSUtility fetchCardSchemeForCardNumber:string]];
        
    }
    
   // self.cardNumberTextField.rightView = self.schemeTypeImageView;
}



- (NSString *)validateMiniLimit:(NSString *)toString
                       forDigit:(NSInteger)digit
                   errorMessage:(NSString *)errorMessage {
    
    NSCharacterSet *caracterSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    NSString *filtered = [[toString componentsSeparatedByCharactersInSet:caracterSet] componentsJoinedByString:@""];
    
    if (filtered.length < digit) {
        return errorMessage;
    }
    return nil;
}


- (NSString *)cardNumberValue {
    return [self.cardNumberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

// MARK: UItextfield Delegate methods.

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.cardNumberTextField) {
        [self.expiryDateTextField becomeFirstResponder];
    }
    else if (textField == self.expiryDateTextField) {
        [self.cvvTextField becomeFirstResponder];
    }
    else if (textField == self.cvvTextField) {
        [self.view endEditing:YES];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (strcmp([string cStringUsingEncoding:NSUTF8StringEncoding], "\b") == -8) {
        
        if (textField == self.cardNumberTextField) {
            [self updateCardTypeImage:[textField.text stringByReplacingCharactersInRange:range withString:string]];
        }
        return YES;
    }
    
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    string = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    BOOL returnValue = YES;
    if (textField == self.cardNumberTextField) {
        
        returnValue = [self hasValidateTextInput:[string stringByReplacingOccurrencesOfString:@" " withString:@""] maxLimit:_cardNumberMaxLimit];
        
        if (returnValue) {
            [self updateCardTypeImage:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
            
            textField.text = [self formatedCardnumber:string];
            return NO;
        }
    }
    else if (textField == self.expiryDateTextField) {
        
        returnValue = [self validStringforExpirayDate:string];
    }
    else if (textField == self.cvvTextField) {
        
        returnValue = [self hasValidateTextInput:string maxLimit:_cvvNumberLimit];
    }
    
    return returnValue;
}

- (BOOL)validStringforExpirayDate:(NSString*)string {
    //TODO: Rewrite the function like formatedCardnumber: method
    NSString *returnValue = string;
    
    if (string.length>2 && string.length<9) {
        
        NSString *firstPart;
        NSString *secondPart;
        
        NSArray *components = [string componentsSeparatedByString:@"/"];
        if (components.count > 2) {
            return NO;
        }
        if (components.count == 2) {
            firstPart = [components firstObject];
            secondPart = [components lastObject];
        }
        else {
            firstPart = [string substringToIndex:2];
            secondPart = [string substringWithRange:NSMakeRange(firstPart.length, string.length-firstPart.length)];
        }
        
        returnValue = [[firstPart stringByAppendingString:@"/"] stringByAppendingString:secondPart];
    }
    else if (string.length == 2) {
        
        returnValue = [[string stringByReplacingOccurrencesOfString:@"/" withString:@""] stringByAppendingString:@"/"];
    }
    
    BOOL value = returnValue.length >7 ? NO:YES;
    
    value = value && [self hasValidateTextInput:[returnValue stringByReplacingOccurrencesOfString:@"/" withString:@""] maxLimit:4];
    
    if (value) {
        [self.expiryDateTextField performSelector:@selector(setText:) withObject:returnValue afterDelay:0];
    }
    
    return value;
}

- (BOOL)hasValidateTextInput:(NSString*)string maxLimit:(NSInteger)characterLimit {
    
    NSUInteger newLength = string.length;
    NSCharacterSet *caracterSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:caracterSet] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered])&&(newLength <= characterLimit) && string.length);
}

- (BOOL)validateExpiryDate:(NSString*)string {
    
    NSArray *components = [string componentsSeparatedByString:@"/"];
    NSInteger firstPart = [[components firstObject] integerValue];
    NSInteger secondPart = 0;
    
    if (components.count == 2) {
        
        secondPart = [[components lastObject] integerValue];
    }
    
    if (firstPart < 32 && firstPart != 0 && secondPart < 100 && secondPart != 0) {
        return YES;
    }
    return NO;
}


// MARK: Format card number

- (NSString*)formatedCardnumber:(NSString*)cardnumber {
    NSString *string = cardnumber;
    
    NSInteger bunchCount = 5;
    
    NSRange range = NSMakeRange(string.length-1, 1);
    NSString *subString = [string substringWithRange:range];
    
    if (string.length%bunchCount == 0) {
        string = [string stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@" %@", subString]];
    }
    return string;
}

@end
