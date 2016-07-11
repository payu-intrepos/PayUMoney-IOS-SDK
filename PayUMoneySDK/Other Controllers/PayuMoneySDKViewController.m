//
//  ViewController.m
//  PayU SDK
//
//  Created by Honey Lakhani on 9/28/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//
#include <CommonCrypto/CommonDigest.h>
#import "PayuMoneySDKViewController.h"
#import "PayuMoneySDKKeychainItemWrapper.h"
#import "PayuMoneySDKLoginService.h"
#import "PayuMoneySDKRequestParams.h"
#import "PayuMoneySDKLoginViewController.h"
#import "PayuMoneySDKPaymentViewController.h"
#import "PayuMoneySDKValidations.h"
#import "PayuMoneySDKRequestManager.h"
#import "PayuMoneySDKServiceParameters.h"
#import "NSString+Encode.h"
@interface PayuMoneySDKViewController () <UITextFieldDelegate,UIScrollViewDelegate,SendingResponseDelegate,LoginServiceDelegate>
{
    UITextField *activeField;
    PayuMoneySDKSession *session;
        PayuMoneySDKRequestParams *params;
  
}
@end

@implementation PayuMoneySDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SDK_APP_CONSTANT.keyChain resetKeychainItem];

    [self registerForKeyboardNotifications];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.amountTextField.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad{
    [self.amountTextField resignFirstResponder];
    self.amountTextField.text = @"";
}

-(void)doneWithNumberPad{
   
    [self.amountTextField resignFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.payNowBtn setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)payButtonClicked:(UIButton *)sender
{
 [PayuMoneySDKRequestParams initWithDict:[[NSDictionary alloc]init]];
    
    
   
    
    NSLog(@" amount --------------> %@",self.amountTextField.text);
    
    
   
    if(![self.amountTextField hasText])
    {
        ALERT(@"Specify Amount", @"");
        
    }
    else
    {
        if ([PayuMoneySDKValidations matchRegex:amountregex :self.amountTextField.text])
        {
            
        
        if ([self.amountTextField.text doubleValue] > 1000000) {
            ALERT(@"Amount Exceeding the limit: ", @"1000000");
            return;
        }
        else
        {
        params.amount = self.amountTextField.text;
        params.email = @"honeylakhani@gmail.com";
             params.email = @"piyush.jain@payu.in";
        params.txnid = @"0nf7";
        //params.merchantid = @"4825489";
           // params.merchantid = @"4831656";
        //    params.merchantid = @"4914106";//live
        //params.merchantid = @"4827862";
    params.merchantid = @"4827834";
          //  params.merchantid = @"4824899";
       // params.merchantid = @"4825269";
        params.phone = self.phoneTextField.text;
            params.phone = @"8882434664";
        params.productinfo = @"product_name";
        //params.firstname = @"honeylakhani@gmail.com";
             params.firstname = @"piyush";
        params.surl = @"https://test.payumoney.com/mobileapp/payumoney/success.php";
//            params.surl = @"https://payu.herokuapp.com/ios_success";
//            params.furl  = @"https://payu.herokuapp.com/ios_failure";
        params.furl = @"https://test.payumoney.com/mobileapp/payumoney/failure.php";
        NSError *err;
        NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:params.surl,params.furl, nil] forKeys:[NSArray arrayWithObjects:@"surl",@"furl", nil]];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted
                                                             error:&err];
        NSString *stt = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"url json ==== %@     %@",[jsonData description],stt);
        NSLog(@"params========== %@",params.amount);
       // params.key = @"ThjfRo";
           // params.key = @"mdyCKV";//live
      //  params.key = @"Vw997n";
        params.key = @"FCstqb"; //key for 4827834.
       //     params.key = @"tPJM2e";
           // params.key = @"1LCS8b"; //key for 4827862.
           // NSString *salt= @"B9nBxTFi"; // for 4825489.
          //  NSString *salt = @"Je7q3652";//live
           // NSString *salt = @"4z5sUWFC"; // salt for 4827862.
           // params.key = @"O50ARA";
            // params.key = @"J75LakGu";
        //NSString *salt = @"m0wYMzYv";
           NSString *salt = @"MBgjYaFG";//salt for 4827834
           // NSString *salt = @"x4rmTrFm";
           // NSString *salt = @"ftUjjzPp";
            // NSString *salt = @"43gpg1V0jq";
        NSString *hashSequence = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@||||||%@",params.key,params.txnid,params.amount,params.productinfo,params.firstname,params.email,salt];
      // NSString *hashSequence = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@||||||ftUjjzPp",params.key,params.txnid,params.amount,params.productinfo,params.firstname,params.email];
      //  NSString *hashSequence = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@||||||4womTBoq",params.key,params.txnid,params.amount,params.productinfo,params.firstname,params.email];
           // String hashSequence = "mdyCKV" + "|" + "0nf7" + "|" + amt.getText().toString() + "|" + "product_name" + "|" + "piyush" + "|"
            //+ "piyush.jain@payu.in" + "|" + "" + "|" + "" + "|" + "" + "|" + "" + "|" + "" + "|" + "Je7q3652";
          //  params.put(SdkConstants.KEY, "mdyCKV");
          //  params.put(SdkConstants.MERCHANT_ID, "4914106");
        NSString *hash = [[[[[self createSHA512:hashSequence] description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSLog(@"hash value====== %@,,%@",hash,[self createSHA512:hashSequence]);
        NSLog(@"hash sequence ------- > %@",hashSequence);
        params.hashValue = hash;
        params.udf1 = @"";
                params.udf2 = @"";
                params.udf3 = @"";
                params.udf4 = @"";
                params.udf5 = @"";
        
       //[session startPaymentProcess:params];
        
           // [self calculateHashFromServer];
        
        session = [PayuMoneySDKSession sharedSession];
        session.delegate = self;
        
//        NSLog(@"%@ email id",[SDK_APP_DELEGATE.keyChain objectForKey:(__bridge id)kSecAttrAccount] );
            
        }
    }
}
}




-(NSString*)checkNullValue:(id)text
{
    NSString *parsedText = @"";
    if([text isKindOfClass:[NSString class]])
    {
        if([text isEqualToString:@"<null>"])
            parsedText = @"";
        else{
            parsedText = text;
        }
    }
    else if ([text isKindOfClass:[NSNumber class]]){
        parsedText = [text stringValue];
    }
    return parsedText;
}

-(void)sendingMerchantParams:(NSArray *)merchantArr
{
    [PayuMoneySDKAppConstant hideLoader];
    UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PayuMoneySDKLoginViewController *loginVC = [sdkSB instantiateViewControllerWithIdentifier:@"loginVC"];

    loginVC.merchantParamsArr = merchantArr;
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)sendingResponseBack : (NSString *)msg
{
    [PayuMoneySDKAppConstant hideLoader];
    if ([msg isEqual:@"success"]) {
        UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
        PayuMoneySDKPaymentViewController *paymentVC = [sdkSB instantiateViewControllerWithIdentifier:@"payVC"];
        
        [self.navigationController pushViewController:paymentVC animated:YES];
    }
    else
    {
        
        [self.payNowBtn setUserInteractionEnabled:YES];
        [SDK_APP_CONSTANT.keyChain resetKeychainItem];
        UIStoryboard *sdkSB  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
         PayuMoneySDKLoginViewController *loginVC = [sdkSB instantiateViewControllerWithIdentifier:@"loginVC"];
         [self.navigationController pushViewController:loginVC animated:YES];
        
    }
}

- (NSData *) createSHA512:(NSString *)source {
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    
    CC_SHA512(keyData.bytes, keyData.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    NSLog(@"out --------- %@",output);
    return output;
}

//-(void)sendResponse:(NSDictionary *)responseDict tag:(REQUEST_TYPE)tag error:(NSError *)err
//{
//    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
//    [AppConstant hideLoader];
//    if (err)
//    {
//        loginVC.merchantParamsArr = [NSArray arrayWithObject:@"Login With Password"];
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }
//
//   else if (tag == REQUEST_PARAMS && [[responseDict valueForKey:@"status"]isEqual:[NSNumber numberWithLong:0]])
//    {
//        
//        NSLog(@"%@",responseDict);
//        NSArray *loginArr= [responseDict valueForKey:@"result"];
//        NSString *gc, *otp;
//        for (int i =0; i < loginArr.count; i++) {
//            if([[[loginArr objectAtIndex:i]valueForKey:@"paramKey"] isEqual:MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT_VALUE])
//            {
//                gc =[[loginArr objectAtIndex:i]valueForKey:@"paramValue"];
//            }
//            else if ([[[loginArr objectAtIndex:i]valueForKey:@"paramKey"] isEqual:OTP_LOGIN])
//            {
//                otp = [[loginArr objectAtIndex:i]valueForKey:@"paramValue"];
//            }
//        }
//        
//        if ((gc != nil && ![gc isEqual: @""]) || (otp != nil && ![otp isEqual:@""])) {
//            if ([gc isEqual:MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT]) {
//                loginVC.merchantParamsArr = [NSArray arrayWithObjects:@"Guest Login",@"Login With Password", nil];
//            }
//            else if ([gc isEqual:MERCHANT_PARAM_ALLOW_GUEST_CHECKOUT_ONLY])
//            {
//                loginVC.merchantParamsArr = [NSArray arrayWithObjects:@"Guest Login", nil];
//            }
//            else if ([otp isEqual:@"1"])
//            {
//                loginVC.merchantParamsArr = [NSArray arrayWithObjects:@"Login With OTP",@"Login With Password", nil];
//            }
//            else
//            loginVC.merchantParamsArr = [NSArray arrayWithObject:@"Login With Password"];
//        }
//        else
//        loginVC.merchantParamsArr = [NSArray arrayWithObject:@"Login With Password"];
//       // [AppConstant hideLoader];
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }
//      }
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
        activeField = nil;

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    return YES;
}

-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShown : (NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"%@",info);
    //271 is height and 414 is width of keyboard
    NSLog(@"%f and %f",keyboardSize.height,keyboardSize.width);
    
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height , 0.0);
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
    CGRect aRect = self.scrollView.bounds;
    NSLog(@"arect ---> %f",aRect.size.height);
    aRect.size.height = aRect.size.height - keyboardSize.height ;
    if(!CGRectContainsPoint(aRect, activeField.frame.origin))
    {
        NSLog(@"inside if");
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}
- (void)keyboardHide:(NSNotification *)notification
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
    
    
}


@end
