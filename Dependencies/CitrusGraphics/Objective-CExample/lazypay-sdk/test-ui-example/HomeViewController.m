//
//  ViewController.m
//  LazyPayExample
//
//  Created by Mukesh Patil on 7/18/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import "HomeViewController.h"

#import "TestParams.h"

@interface HomeViewController () <UITextFieldDelegate>{
    LPUserDetails *user;
    LPUserAddress *addressInfo;
}
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicatorView;
@property (nonatomic, weak) IBOutlet UITextField *mobileTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *productSKUDetailTextField;
@property (nonatomic, weak) IBOutlet UITextField *amountTextField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *signOutButton;
@property (nonatomic, weak) IBOutlet UIButton *initiatePaytButton;
@property (nonatomic, weak) IBOutlet UIButton *checkEligibliytButton;
@property (nonatomic, weak) IBOutlet UILabel *versionLabel;
@property (nonatomic) float amount;
@property (strong) NSString *billUrl;
@property (strong) SVSegmentedControl *segmentedControl;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Merchant App";
    
    self.versionLabel.text = [NSString stringWithFormat:@"LazyPay Demo v%@", LAZYPAY_VERSION];

    self.checkEligibliytButton.layer.cornerRadius = 5;
    self.initiatePaytButton.layer.cornerRadius = 5;

    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    NSString *server = [defautls valueForKey:@"EnvironmentTo"];
    if (server == nil) {
        [defautls setValue:@"0" forKey:@"EnvironmentTo"];
    }
    
    if ([server integerValue] == 0) {
        self.billUrl = BillUrl_Sandbox;
    }
    else if ([server integerValue] == 1){
        self.billUrl = BillUrl_Production;
    }

    self.indicatorView.hidden = true;
    
    self.segmentedControl = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"SandBox", @"Production", nil]];
    //    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.font = [UIFont boldSystemFontOfSize:17.4];
    self.segmentedControl.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 14);
    self.segmentedControl.height = 40;
    self.segmentedControl.thumb.tintColor = [UIColor orangeColor];
    self.segmentedControl.backgroundTintColor = [UIColor blackColor];
    self.segmentedControl.textColor = [UIColor whiteColor];
    self.segmentedControl.mustSlideToChange = YES;
    [self.view addSubview:self.segmentedControl];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    if (screenHeight == 480) {
        self.segmentedControl.center = CGPointMake(self.view.center.x, self.initiatePaytButton.center.y + screenHeight/8);
    }
    else {
        self.segmentedControl.center = CGPointMake(self.view.center.x, self.initiatePaytButton.center.y + screenHeight/4);
    }
    
    [self segmentedControlChangedValue:[server integerValue]];
    [self.segmentedControl setSelectedSegmentIndex:[server integerValue] animated:YES];
    
    self.segmentedControl.changeHandler = ^(NSUInteger newIndex) {
        [self segmentedControlChangedValue:newIndex];
    };
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if ([LazyPay isUserSignedIn]) {
        self.signOutButton.title = @"SignOut";
        self.mobileTextField.hidden = YES;
        self.emailTextField.hidden = YES;
        self.checkEligibliytButton.hidden = YES;
    }
    else {
        self.signOutButton.title = @"";
        self.mobileTextField.hidden = NO;
        self.emailTextField.hidden = NO;
        self.checkEligibliytButton.hidden = NO;
    }
    
    self.mobileTextField.text = @"";
    self.emailTextField.text = @"";
    self.amountTextField.text = @"";
}

#pragma mark - UIControlEventValueChanged
- (void)segmentedControlChangedValue:(NSUInteger)newIndex {
    if ([self.view superview]) {
        [self environmentChangeAction:newIndex];
    }
    else {
        [self changeEnvironment:newIndex];
    }
}

- (void)environmentChangeAction:(NSUInteger)newIndex {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Warning!!"
                                          message:@"All data will be cleared and app will reset after environment switch."
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           if (newIndex == 0) {
                                               [self.segmentedControl setSelectedSegmentIndex:1 animated:YES];
                                           }
                                           else {
                                               [self.segmentedControl setSelectedSegmentIndex:0 animated:YES];
                                           }
                                       });
                                   }];
    
    UIAlertAction *proceedAction = [UIAlertAction
                                    actionWithTitle:NSLocalizedString(@"Proceed", @"Proceed action")
                                    style:UIAlertActionStyleCancel
                                    handler:^(UIAlertAction *action)
                                    {
                                        if (newIndex == 0) {
                                            if ([self.view superview]) {
                                                    [LazyPay signOut];
                                                    [self logoutAction:@"Sandbox"];
                                            }
                                        }
                                        else {
                                            if ([self.view superview]) {
                                                    [LazyPay signOut];
                                                    [self logoutAction:@"Production"];
                                            }
                                        }
                                        
                                        self.signOutButton.title = @"";
                                        self.mobileTextField.hidden = NO;
                                        self.emailTextField.hidden = NO;
                                        self.checkEligibliytButton.hidden = NO;
                                    
                                       self.mobileTextField.text = @"";
                                       self.emailTextField.text = @"";
                                       self.amountTextField.text = @"";

                                        [self changeEnvironment:newIndex];
                                    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:proceedAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)logoutAction:(NSString *)environment {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Info"
                                          message:[NSString stringWithFormat:@"Now, your switched with %@ environment.", environment]
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Ok", @"Yes action")
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"Yes action");
                               }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

// Initialize the SDK layer viz CTSAuthLayer/CTSProfileLayer/CTSPaymentLayer
- (void)changeEnvironment:(NSUInteger)newIndex {
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    
#warning "set your required environment to see testing results"
    if (newIndex == 0) {
        NSLog(@"setupWorkingEnvironmentTo CTSEnvSandbox");
        // initialize the SDK by setting it up with ClientIds
        [CitrusPaymentSDK initWithSignInID:SignInId_Sandbox
                              signInSecret:SignInSecretKey_Sandbox
                                  signUpID:SubscriptionId_Sandbox
                              signUpSecret:SubscriptionSecretKey_Sandbox
                                 vanityUrl:VanityUrl_Sandbox
                               environment:CTSEnvSandbox];
        self.billUrl = BillUrl_Sandbox;
        
        [CitrusPaymentSDK setLogLevel:CTSLogLevelVerbose];
        [defautls setValue:@"0" forKey:@"EnvironmentTo"];
    }
    else {
        NSLog(@"setupWorkingEnvironmentTo CTSEnvProduction");
        // initialize the SDK by setting it up with ClientIds
        [CitrusPaymentSDK initWithSignInID:SignInId_Production
                              signInSecret:SignInSecretKey_Production
                                  signUpID:SubscriptionId_Production
                              signUpSecret:SubscriptionSecretKey_Production
                                 vanityUrl:VanityUrl_Production
                               environment:CTSEnvProduction];
        self.billUrl = BillUrl_Production;
        
        [CitrusPaymentSDK setLogLevel:CTSLogLevelNone];
        
        [defautls setValue:@"1" forKey:@"EnvironmentTo"];
    }
}


- (BOOL)isInputDataSet {
    if ([self validateInputData]) {
        user = [[LPUserDetails alloc] init];
        user.email = self.emailTextField.text;
        user.mobile = self.mobileTextField.text;
        
        self.amount = [self.amountTextField.text floatValue];
        
        addressInfo = [[LPUserAddress alloc] init];
        addressInfo.city = TEST_CITY;
        addressInfo.country = TEST_COUNTRY;
        addressInfo.state = TEST_STATE;
        addressInfo.street1 = TEST_STREET1;
        addressInfo.street2 = TEST_STREET2;
        addressInfo.zip = TEST_ZIP;
        return YES;
    }
    else {
        return NO;
    }
}

- (IBAction)initiatePayment:(UIButton *)sender {
    if ([self isInputDataSet]) {
        [self lazyPayNowForAmount:self.amount setProductSkuDetails:nil];
    }
}

#pragma mark - TextView Delegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (strcmp([string cStringUsingEncoding:NSUTF8StringEncoding], "\b") == -8) {
        return YES;
    }
    
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    string = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    BOOL returnValue = YES;
    if (textField == self.mobileTextField) {
        returnValue = [self hasValidateTextInput:string maxLimit:10];
    }
    else if (textField == self.emailTextField) {
    }
    else if (textField == self.productSKUDetailTextField) {
    }
    else if (textField == self.amountTextField) {
        NSArray  *arrayOfString = [string componentsSeparatedByString:@"."];
        if (textField == self.amountTextField) {
            if ([arrayOfString count] >= 2 ) {
                if ([[arrayOfString objectAtIndex:1] length] > 2) {
                    returnValue = NO;
                }
            }
        }
    }
    
    return returnValue;
}

// MARK: touches began
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// all validation
- (BOOL)validateInputData {
    
    BOOL isValidInputData = NO;
    NSString *errorMessage = nil;
    
    NSString *tempMessage = @"Please enter a ";
    if (![LazyPay isUserSignedIn]) {
        if (![self hasValidateTextInput:self.mobileTextField.text maxLimit:10]) {
            errorMessage = [tempMessage stringByAppendingString:@"valid mobile number"];
        }
        
        if ([self.emailTextField.text length] == 0) {
            tempMessage = errorMessage.length ? [errorMessage stringByAppendingString:@", "] : tempMessage;
            errorMessage = [tempMessage stringByAppendingString:@"valid email Id"];
        }
    }
    
    //    if ([self.productSKUDetailTextField.text length] == 0) {
    //        tempMessage = errorMessage.length ? [errorMessage stringByAppendingString:@", "] : tempMessage;
    //        errorMessage = [tempMessage stringByAppendingString:@"valid product SKU detail"];
    //    }
    
    if ([self.amountTextField.text length] == 0) {
        tempMessage = errorMessage.length ? [errorMessage stringByAppendingString:@" and "] : tempMessage;
        errorMessage = [tempMessage stringByAppendingString:@"valid amount"];
    }
    
    
    [self.mobileTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.productSKUDetailTextField resignFirstResponder];
    [self.amountTextField resignFirstResponder];
    
    if (errorMessage == nil) {
        isValidInputData = YES;
    }
    else {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error!!"
                                              message:errorMessage
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Ok", @"Ok action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Ok action");
                                   }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    return isValidInputData;
}


- (BOOL)hasValidateTextInput:(NSString*)string maxLimit:(NSInteger)characterLimit {
    
    NSUInteger newLength = string.length;
    NSCharacterSet *caracterSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:caracterSet] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered])&&(newLength <= characterLimit) && string.length);
}

//
- (IBAction)checkEligibility:(UIButton *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.indicatorView.hidden = FALSE;
        [self.indicatorView startAnimating];
    });
    
    if ([self isInputDataSet]) {
        LazyPayConfig *lazyPayConfig = [LazyPayConfig lazyPayConfig:self.amount
                                                            billUrl:self.billUrl
                                                  productSkuDetails:nil
                                                               user:user
                                                            address:addressInfo];
        
        [LazyPay canMakePayment:lazyPayConfig
                    completionHandler:^(LPChekEligibility *response,
                                        NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.indicatorView stopAnimating];
                            self.indicatorView.hidden = TRUE;
                        });
                        
                        UIAlertController *alertController;
                        if (error) {
                            alertController = [UIAlertController
                                               alertControllerWithTitle:@"Error!"
                                               message:[error localizedDescription]
                                               preferredStyle:UIAlertControllerStyleAlert];
                        }
                        else {
                            alertController = [UIAlertController
                                               alertControllerWithTitle:@"Success!"
                                               message:response.reason
                                               preferredStyle:UIAlertControllerStyleAlert];
                        }
                        
                        UIAlertAction *okAction = [UIAlertAction
                                                   actionWithTitle:NSLocalizedString(@"Ok", @"No action")
                                                   style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action)
                                                   {
                                                       NSLog(@"No action");
                                                   }];
                        
                        [alertController addAction:okAction];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self presentViewController:alertController animated:YES completion:nil];
                        });
                    }];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = TRUE;
        });
    }
    
}


- (IBAction)signOut:(UIBarButtonItem *)sender {
    [self logOutButtonAction];
}


-(void)logOutButtonAction {
    if ([LazyPay isUserSignedIn]) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Warning!!"
                                              message:@"Are you sure you want to logout."
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesAction = [UIAlertAction
                                    actionWithTitle:NSLocalizedString(@"Yes", @"Yes action")
                                    style:UIAlertActionStyleCancel
                                    handler:^(UIAlertAction *action)
                                    {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            self.indicatorView.hidden = FALSE;
                                            [self.indicatorView startAnimating];
                                        });
                                        NSLog(@"Yes action");
                                        if ([LazyPay signOut]) {
                                            self.mobileTextField.hidden = NO;
                                            self.emailTextField.hidden = NO;
                                            self.checkEligibliytButton.hidden = NO;

                                            self.signOutButton.title = @"";
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                self.indicatorView.hidden = true;
                                                [self.indicatorView stopAnimating];
                                            });
                                        }
                                    }];
        
        UIAlertAction *noAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"No", @"No action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"No action");
                                   }];
        
        [alertController addAction:yesAction];
        [alertController addAction:noAction];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
}

- (void)lazyPayNowForAmount:(float)amount setProductSkuDetails:(NSArray *)productSkuDetails {
    
    productSkuDetails = nil;
    
    productSkuDetails = @[@{
                              @"productId": @"prod1",
                              @"description": @"Men's Firm-Ground Football Boot",
                              @"attributes": @{
                                      @"size": @"32",
                                      @"color": @"blue"
                                      },
                              @"imageUrl": @"www.google.com",
                              @"shippable": @true,
                              @"skus": @[@{
                                             @"skuId": @"sku1",
                                             @"price": @1,
                                             @"attributes": @{
                                                     @"size": @"30",
                                                     @"color": @"32"
                                                     }
                                             }]
                              }];
    
    NSDictionary *dict = [productSkuDetails objectAtIndex:0];
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Payment Confirmation"
                                          message:[NSString stringWithFormat:@"For Amount ₹%.02f\n%@", amount, dict[@"description"]]
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [self.indicatorView stopAnimating];
                                           self.indicatorView.hidden = TRUE;
                                       });
                                   }];
    
    UIAlertAction *payAction = [UIAlertAction
                                actionWithTitle:NSLocalizedString(@"Pay Now", @"OK action")
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    NSLog(@"pay action");
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        self.indicatorView.hidden = FALSE;
                                        [self.indicatorView startAnimating];
                                    });
                                    
                                    LazyPayConfig *lazyPayConfig = [LazyPayConfig lazyPayConfig:self.amount
                                                                                        billUrl:self.billUrl
                                                                              productSkuDetails:productSkuDetails
                                                                                           user:user
                                                                                        address:addressInfo];
                                    [LazyPay initiatePayment:lazyPayConfig                                                     andParentViewController:self
                                                 completionHandler:^(id paymentReceipt,
                                                                     NSError *error) {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         self.indicatorView.hidden = true;
                                                         [self.indicatorView stopAnimating];
                                                     });

                                                     UIAlertController *alert;
                                                     if (error) {
                                                         alert = [UIAlertController
                                                                  alertControllerWithTitle:@"Error!"
                                                                  message:[error localizedDescription]
                                                                  preferredStyle:UIAlertControllerStyleAlert];
                                                     }
                                                     else {
                                                         NSString *paymentStatus = paymentReceipt[@"TxStatus"];
                                                         if ([paymentStatus length] == 0) {
                                                             paymentStatus = paymentReceipt[@"Reason"];
                                                         }
                                                         
                                                         alert = [UIAlertController
                                                                  alertControllerWithTitle:nil
                                                                  message:[NSString stringWithFormat:@"TxStatus : %@", paymentStatus]
                                                     preferredStyle:UIAlertControllerStyleAlert];

                                                     }

                                                     UIAlertAction *okAction = [UIAlertAction
                                                                                actionWithTitle:NSLocalizedString(@"Ok", @"No action")
                                                                                style:UIAlertActionStyleDefault
                                                                                handler:^(UIAlertAction *action)
                                                                                {
                                                                                    NSLog(@"No action");
                                                                                }];
                                                     
                                                     [alert addAction:okAction];

                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self presentViewController:alert animated:YES completion:nil];
                                                     });
                                                 }];
                                    
                                }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:payAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
