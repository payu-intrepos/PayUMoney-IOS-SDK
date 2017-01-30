//
//  ViewController.m
//  frameworkIntegrationFromScratch
//
//  Created by Vipin Aggarwal on 16/01/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import "ViewController.h"
#import <PayUmoney_SDK/PayUmoney_SDK.h>
#import <CommonCrypto/CommonDigest.h>  //No need to import it in production app

@interface ViewController ()

@property (nonatomic, strong) PUMRequestParams *params;
@property (weak, nonatomic) IBOutlet UITextField *amount;
@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *productinfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startPaymentTapped:(id)sender {
    
    [self setPaymentParameters];
    
    //Start the payment flow
    PUMMainVController *paymentVC = [[PUMMainVController alloc] init];
    UINavigationController *paymentNavController = [[UINavigationController alloc] initWithRootViewController:paymentVC];
    
    [self presentViewController:paymentNavController
                       animated:YES
                     completion:nil];
}

- (void)setPaymentParameters {
    self.params = [PUMRequestParams sharedParams];
    self.params.environment = PUMEnvironmentProduction;
    self.params.amount = self.amount.text;
    self.params.key = @"mdyCKV";
    self.params.merchantid = @"4914106";
    self.params.txnid = [self  getRandomString:2];
    self.params.surl = @"https://www.payumoney.com/mobileapp/payumoney/success.php";
    self.params.furl = @"https://www.payumoney.com/mobileapp/payumoney/failure.php";
    self.params.delegate = self;
    self.params.firstname = self.firstname.text;
    self.params.productinfo = self.productinfo.text;
    self.params.email = self.email.text;
    self.params.phone = @"";
    
    //Below parameters are optional. It is to store any information you would like to save in PayU Database regarding trasnsaction. If you do not intend to store any additional info, set below params as empty strings.
    
    self.params.udf1 = @"";
    self.params.udf2 = @"";
    self.params.udf3 = @"";
    self.params.udf4 = @"";
    self.params.udf5 = @"";
    self.params.udf6 = @"";
    self.params.udf7 = @"";
    self.params.udf8 = @"";
    self.params.udf9 = @"";
    self.params.udf10 = @"";
    
    self.params.hashValue = [self getHash];
    
}

- (NSString *)getRandomString:(NSInteger)length {
    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
    NSString *numbers = @"0123456789";
    
    // First number cannot be 0
    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
    
    for (int i = 1; i < length; i++) {
        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
    }
    return returnString;
}


#pragma mark - Never Generate hash from app
/*!
    Keeping salt in the app is a big security vulnerability. Never do this. Following function is just for demonstratin purpose
    In code below, salt Je7q3652 is mentioned. Never do this in prod app. You should get the hash from your server.
 */

- (NSString*)getHash {
    NSString *hashSequence = [NSString stringWithFormat:@"mdyCKV|%@|%@|%@|%@|%@|||||||||||Je7q3652",self.params.txnid, self.params.amount, self.params.productinfo,self.params.firstname, self.params.email];
    
    NSString *rawHash = [[self createSHA512:hashSequence] description];
    NSString *hash = [[[rawHash stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return hash;
}

- (NSData *) createSHA512:(NSString *)source {
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    CC_SHA512(keyData.bytes, (CC_LONG)keyData.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    NSLog(@"out --------- %@",output);
    return output;
}



#pragma mark - Completeion callbacks

-(void)transactionCompletedWithResponse:(NSDictionary*)response
                       errorDescription:(NSError* )error {
  [self dismissViewControllerAnimated:YES completion:nil];
  [self showAlertViewWithTitle:@"Message" message:@"congrats! Payment is Successful"];
}

/*!
 * Transaction failure occured. Check Payment details in response. error shows any error
 if api failed.
 */
-(void)transactinFailedWithResponse:(NSDictionary* )response
                   errorDescription:(NSError* )error {
  [self dismissViewControllerAnimated:YES completion:nil];
  [self showAlertViewWithTitle:@"Message" message:@"Oops!!! Payment Failed"];
}

-(void)transactinExpiredWithResponse: (NSString *)msg {
  [self dismissViewControllerAnimated:YES completion:nil];
  [self showAlertViewWithTitle:@"Message" message:@"Trasaction expired!"];
}

/*!
 * Transaction cancelled by user.
 */
-(void)transactinCanceledByUser {
  [self dismissViewControllerAnimated:YES completion:nil];
  [self showAlertViewWithTitle:@"Message" message:@"Payment Cancelled!"];
}

#pragma mark - Helper methods

- (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                           message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [alertController addAction:ok];
  
  [self presentViewController:alertController animated:YES completion:nil];
}
@end
