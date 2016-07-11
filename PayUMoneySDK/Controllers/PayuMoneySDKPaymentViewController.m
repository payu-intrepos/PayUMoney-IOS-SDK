    
//
//  PaymentViewController.m
//  PayU SDK
//
//  Created by Honey Lakhani on 9/29/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import "PayuMoneySDKPaymentViewController.h"
#import "PayuMoneySDKPayUsingPointsAlert.h"
#import "PayuMoneySDKCouponView.h"
#import "PayuMoneySDKPaymentBreakdown.h"
#import "PayuMoneySDKRSA.h"
#import "NSString+Encode.h"
#import "PayuMoneySDKWebViewViewController.h"
#import "PayuMoneySDKFinalViewController.h"
#import "PayuMoneySDKPaymentUsingWallet.h"

#import "PayuMoneySDKPayUsingPointsViewController.h"
#import "PayuMoneySDKSetUpCardDetails.h"
#import "PayuMoneySDKNetBanking.h"
#import "PayuMoneySDKActivityView.h"
#import "PayuMoneySDKSetUpCardDetails.h"
#import "PayuMoneySDKLoginService.h"
#import "PayuMoneySDKLoginViewController.h"
#import "PayuMoneySDKReachability.h"
#import "SavedCardTableView.h"
#import "ConfigBO.h"
#define kGenericTag 777
#define rowGenericTag 999
#define savedcardheight 100


@interface PayuMoneySDKPaymentViewController ()<SendingResponseDelegate,PayUsingPointsDelegate,CouponViewDelegate,PaymentUsingWalletDelegate,NetBankingDelegate,CardViewData,SavedCardCvvDelegate,LoginServiceDelegate,UIAlertViewDelegate,SavedCardTableViewDelegate>
{
   PayuMoneySDKSession *session;
    NSArray *arrSavedCards;
    NSString *paymentMode,*cvvHash;
    NSInteger rowExpanded ;
    NSDictionary *response, *cardDetails;
    NSInteger currentExpandedSection;
    NSMutableArray *couponArray,*cellTitleArr;
    double emi,cc,dc,nb,wallet,cash,discount,payuPoints,amount;
    double userPoints;
    NSDictionary *selectedCouponDict;
    UILabel *couponLabel;
    double walletUsage,walletBal,amt_convenience;
    NSMutableDictionary *card;
    UIView *btnView;
    BOOL fromPayuMoneyApp;
    NSArray *availableCreditCards;
    NSArray *availableDebitCards;
    CGFloat tblHeight;
    CGPoint contentOffset;
    NSArray *arrBankList;
    ConfigBO *configBO;
    
}
@end

@implementation PayuMoneySDKPaymentViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"Payment";
   // self.navigationItem.hidesBackButton = YES;
    
    [self.view bringSubviewToFront:self.imgSecurity];
    
    cvvHash = @"";
    [self.useWalletLbl setHidden:YES];
    [self.useWalletBtn setHidden:YES];
    walletUsage = 0.00;
    PayuMoneySDKRequestParams *params = [PayuMoneySDKRequestParams sharedInstance];
    if (params.response) {
        fromPayuMoneyApp = YES;
        response = params.response;
        [self loadDataOnController];
        
     //   [SDK_APP_DELEGATE getAppVersionData];

        
    }
    else
    {
        fromPayuMoneyApp = NO;
        
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClicked:)];
        self.navigationItem.leftBarButtonItem = leftBtn;
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOutBtnPressed:)];
        self.navigationItem.rightBarButtonItem = rightBtn;

    session = [PayuMoneySDKSession sharedSession];
    session.delegate = self;

        if (SDK_APP_CONSTANT.isServerReachable) {
            [PayuMoneySDKAppConstant showLoader_OnView:self.view.window];
            [session createPayment];
        }
        
    else
    {
        ALERT(@"Internet not connected", @"Please connect");
    }
    }
    walletUsage = 0.00;
    rowExpanded = -1;
    currentExpandedSection = -1;
   // [self drawUnderLineButton:self.applyCoupon withColor:[UIColor blackColor] withCompleteTitle:@"Apply Coupon" andHighlightedText:@"Apply Coupon"];
   // [self drawUnderLineButton:self.viewDetailsBtn withColor:[UIColor blackColor] withCompleteTitle:@"View Details" andHighlightedText:@"View Details"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showPaymentView) name:@"ButtonPressed" object:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)popCurrentViewController
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to cancel the transaction" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}


-(void)backBtnClicked : (UIBarButtonItem *)sender
{
   // [self.navigationController popToRootViewControllerAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to cancel the transaction" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        NSString *requestBody = [PayuMoneySDKServiceParameters prepareBodyForCancelTransactionWithPaymentId:[[[response objectForKey:@"result"]objectForKey:@"payment" ]  objectForKey:@"paymentId"] withStatus:@"1"];
        
        [SDK_APP_CONSTANT cancelTransactionManuallyWithRequestBody:requestBody];

        if (!fromPayuMoneyApp) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationTxnCompleted object:kNotificationRejectTxn];
        }
    }
}

-(void)logOutBtnPressed : (UIBarButtonItem *)sender
{
    [SDK_APP_CONSTANT.keyChain resetKeychainItem];
    NSArray *viewControllers = [self.navigationController viewControllers];
    if (viewControllers.count == 3) {
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    else
    {
        if (SDK_APP_CONSTANT.isServerReachable) {
            
        
        
        PayuMoneySDKLoginService *loginService = [[PayuMoneySDKLoginService alloc]init];
        loginService.delegate = self;
        [PayuMoneySDKAppConstant showLoader_OnView:self.view.window];
        [loginService hitLoginParamsApi];
        
        }
    }

}

-(void)sendingMerchantParams:(NSArray *)merchantArr
{
    
    [PayuMoneySDKAppConstant hideLoader];
    UIStoryboard *sdkSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PayuMoneySDKLoginViewController *loginVC = [sdkSB instantiateViewControllerWithIdentifier:@"loginVC"];
    
    loginVC.merchantParamsArr = merchantArr;
   
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

-(void)viewDidAppear:(BOOL)animated
{
//    if (!fromPayuMoneyApp) {
//        
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callbackfromwebview:) name:@"passData" object:nil];
//    }
}


-(void)callbackfromwebview:(NSNotification *) notification
{
    UIStoryboard *sdkSB = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
    PayuMoneySDKFinalViewController *finalVC = [sdkSB instantiateViewControllerWithIdentifier:@"finalVC"];

    if([notification.object isEqual:@"success"])
    {
        
        finalVC.msg = @"congrats! Payment is successful!!";
    }
    else if ([notification.name isEqual:@"passData"] && [notification.object isEqual:@"failure"])
    {
        finalVC.msg = @"Oops!!! Payment Failed";
    }
   else if ([notification.object isEqual:@"reject"]) {
        finalVC.msg  = @"Payment Cancelled";
    }
    [self.navigationController pushViewController:finalVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)sendResponse:(NSDictionary *)responseDict tag:(SDK_REQUEST_TYPE)tag error:(NSError *)err
{
    [PayuMoneySDKActivityView removeViewAnimated:YES];
    
    session.delegate = nil;
    session = nil;
    if (err)
    {
        ALERT(@"Something went wrong", @"Please try again");
    }
    else    if(tag == SDK_REQUEST_PAYMENT && [[responseDict valueForKey:@"status"] isEqual:[NSNumber numberWithLong:0]]  )
    {
        response = responseDict;
        [self loadDataOnController];
          }
    else if (tag == SDK_REQUEST_PAYMENT && [[responseDict valueForKey:@"status"] isEqual:[NSNumber numberWithInt:-1]]  )
    {
                [self.paymentTableView setHidden:YES];
        ALERT(@"Something went wrong", @"Please try again");

    }
   else if(tag == SDK_REQUEST_GET_PAYMENT_MERCHANT && [[responseDict valueForKey:@"status"] isEqual:[NSNumber numberWithLong:0]]  )
   {
       [self doThePayment : responseDict];
           
 
   }
   else if(tag == SDK_REQUEST_GET_PAYMENT_MERCHANT && [[responseDict valueForKey:@"status"] isEqual:[NSNumber numberWithInt:-1]]  )
   {
       ALERT(@"Something went wrong", @"Please try again");
   }
    else if (tag == SDK_CANCEL_TRANSACTION )
    {
        
    }
    else if(tag == SDK_REQUEST_ONE_CLICK && ![[responseDict valueForKey:@"status"] isEqual:[NSNumber numberWithInt:-1]]  )
    {
        if ([[responseDict valueForKey:@"result"] isKindOfClass:[NSDictionary class]]) {
            configBO = [[ConfigBO alloc]initWithResponse:[[responseDict valueForKey:@"result"]valueForKey:@"configDTO"]];
            if ([configBO.oneClick isEqualToString:@"0"]) {
                [self.btnOneTap setSelected:NO];
            }
            else
                [self.btnOneTap setSelected:YES];
           
        }
    }

}


-(void)loadDataOnController
{
    // Save PaymentID and MerchantID
 
    //NSLog(@"%@",[AppSettings sharedInstance].dictCurrentTxn);
     [self calculateConvenienceCharges];
    amount = [[[[response valueForKey:@"result"] valueForKey:@"payment"]valueForKey:@"orderAmount"] doubleValue];
    [self checkIfPointsAreSupported];
//    NSString *points = [[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"points"];
//    amount = [[[[response valueForKey:@"result"] valueForKey:@"payment"]valueForKey:@"orderAmount"] doubleValue];
//    if (points == nil || [points isKindOfClass:[NSNull class]] || [points isEqual:@"<null>"]) {
//        userPoints = 0.0;
//    }
//    else{
//        userPoints = [[points valueForKey:@"amount"] doubleValue];
//    }
//    if (userPoints < 0.00) {
//        userPoints = 0.00;
//    }
//    
//    payuPoints = userPoints;
    if ([[[response valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"]  == nil || [[[[response valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"] isKindOfClass:[NSNull class]] || [[[[response valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"]  isEqual:@"<null>"]) {
        discount = 0.00;
    }
    else
     discount = [[[[[response valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerType" ] isEqualToString:@"Discount"] ? [[[[[response valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerAmount" ] doubleValue] : 0.00;
   
        
    
    if(payuPoints >= amount - discount + wallet )
    
    {
        amt_convenience  = wallet;
        [self payViaPoints];
    }
    
    else
    {
        [self loadingPaymentView];
            }
    
   // [self checkForOneClickTransaction : @"-1"];

}
-(void)checkForOneClickTransaction : (NSString *)enable
{
    session = [[PayuMoneySDKSession alloc]init];
    session.delegate = self;
    [session enableOneclickTransaction:enable];
}
-(void)checkForPoints
{
    NSString *points = [[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"points"];
    
    if (points == nil || [points isKindOfClass:[NSNull class]] || [points isEqual:@"<null>"]) {
        userPoints = 0.0;
    }
    else{
        userPoints = [[points valueForKey:@"amount"] doubleValue];
    }
    if (userPoints < 0.00) {
        userPoints = 0.00;
    }
    
    payuPoints = userPoints;
}

-(void)checkIfPointsAreSupported
{
    if ([[response valueForKey:@"result"]valueForKey:@"paymentOptions"]) {
        
        
        NSDictionary *paymentOptions = [[response valueForKey:@"result"]valueForKey:@"paymentOptions"];
        
        NSDictionary *options = [paymentOptions valueForKey:@"options"];
        
        if (paymentOptions &&  [options isKindOfClass:[NSDictionary class]]) {
            
            //NSError *err;
            if([self isValidString:[options valueForKey:@"points"]]){
                if ([[options valueForKey:@"points"]isEqualToString:@"true"]) {
                    [self checkForPoints];
                }
                else
                {
                    payuPoints = 0.00;
                    userPoints = 0.00;
                }
            }
        }
    }
  
}

-(void)checkForSupportedModes : (int)option
{
    if ([[response valueForKey:@"result"]valueForKey:@"paymentOptions"]) {
        
        
        NSDictionary *paymentOptions = [[response valueForKey:@"result"]valueForKey:@"paymentOptions"];
        
        NSDictionary *options = [paymentOptions valueForKey:@"options"];
        
        if (paymentOptions &&  [options isKindOfClass:[NSDictionary class]]) {
            NSError *err;
           
    switch (option)
            {
        case 0:
            if([self isValidString:[options valueForKey:@"cc"]]){
            
            //            if (options && [options valueForKey:@"cc"] && ![[options valueForKey:@"cc"] isEqualToString:@"<null>"]) {
            [cellTitleArr addObject:CREDIT];
            NSString *str = [options valueForKey:@"cc"];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *ccoptions = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            
            //availableCreditCards = [NSArray new];
            availableCreditCards = [ccoptions allKeys];
                //return YES;
                
        }
                  //  return NO;

            
            break;
                case 1:  if([self isValidString:[options valueForKey:@"dc"]]){
                    
                    //            if (options && [options valueForKey:@"dc"] && ![[options valueForKey:@"dc"] isEqualToString:@"<null>"]) {
                    NSString *str = [options valueForKey:@"dc"];
                    [cellTitleArr addObject:DEBIT];
                    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSDictionary *ccoptions = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
                    availableDebitCards = [ccoptions allKeys];
                   // return YES;
                    
                }
                   // return NO;
                    break;
                case 2:if ([self isValidString:[options valueForKey:@"points"]]) {
                    if ([[options valueForKey:@"points"]isEqualToString:@"true"]) {
                        [self checkForPoints];
                       // return YES;
                    }
                }
                    //return NO;
                    break;
                case 3:if ([self isValidString:[options valueForKey:@"wallet"]]) {
                    if ([[options valueForKey:@"wallet"]isEqualToString:@"true"]) {
                        [self checkForWallet];
                       // return YES;
                    }
                }
                    //return NO;
                    break;
            
        default:
                    //return NO;
            break;
    }
        }
    }
  //  return NO;
}

-(void)loadingPaymentView
{
    [self calculateAmount];
    
    
        cellTitleArr = [NSMutableArray new];
    //arrBankList = [self bankListNames];
    if (![[[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"savedCards"] isKindOfClass:[NSNull class]] )
    {
        [cellTitleArr addObject:SAVED];
    }
   
    [self findSupportedCCAndDCAndWallet];
//    if (arrBankList.count) {
//        [cellTitleArr addObject:NET_BANKING];
//    }
    
    
//        if (arrBankList.count) {
//            cellTitleArr = [NSArray arrayWithObjects:@"Saved Cards",@"Credit Cards",@"Debit Cards",@"Net Banking", nil];
//        }
//        else
//            cellTitleArr = [NSArray arrayWithObjects:@"Saved Cards",@"Credit Cards",@"Debit Cards", nil];
//        
//    }
//    else
//    {
//        if (arrBankList.count) {
//            cellTitleArr = [NSArray arrayWithObjects:@"Credit Cards",@"Debit Cards",@"Net Banking", nil];
//        }
//        else
//            cellTitleArr = [NSArray arrayWithObjects:@"Credit Cards",@"Debit Cards", nil];
//    }
    [self.paymentTableView reloadData];
    
    arrSavedCards = [self savedCardsList];
   
    //NSLog(@"---------------- %@",arrSavedCards);
    [self findingCouponData];
    //[self checkForOneClickTransaction:@"-1"];
}

-(BOOL)isValidDictionary:(id)content{
    
    BOOL isValid = NO;
    if([content isKindOfClass:[NSDictionary class]]){
        isValid = YES;
    }
    
    return isValid;
}
-(BOOL)isValidString:(id)content{
    
    BOOL isValid = NO;
    if([content isKindOfClass:[NSString class]] && ![content isEqualToString:@"<null>"]){
        isValid = YES;
    }
    
    return isValid;
}

-(void)findSupportedCCAndDCAndWallet
{
    if ([[response valueForKey:@"result"]valueForKey:@"paymentOptions"]) {
        
    
    NSDictionary *paymentOptions = [[response valueForKey:@"result"]valueForKey:@"paymentOptions"];
        
        NSDictionary *options = [paymentOptions valueForKey:@"options"];
        
        if (paymentOptions &&  [options isKindOfClass:[NSDictionary class]]) {
            
            NSError *err;
            if([self isValidString:[options valueForKey:@"cc"]]){
                
//            if (options && [options valueForKey:@"cc"] && ![[options valueForKey:@"cc"] isEqualToString:@"<null>"]) {
                [cellTitleArr addObject:CREDIT];
                NSString *str = [options valueForKey:@"cc"];
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *ccoptions = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
                
                //availableCreditCards = [NSArray new];
                availableCreditCards = [ccoptions allKeys];
                
            }
            if([self isValidString:[options valueForKey:@"dc"]]){

//            if (options && [options valueForKey:@"dc"] && ![[options valueForKey:@"dc"] isEqualToString:@"<null>"]) {
                NSString *str = [options valueForKey:@"dc"];
                [cellTitleArr addObject:DEBIT];
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *ccoptions = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
                availableDebitCards = [ccoptions allKeys];
                
            }
            if([self isValidString:[options valueForKey:@"nb"]]){
                
                //            if (options && [options valueForKey:@"dc"] && ![[options valueForKey:@"dc"] isEqualToString:@"<null>"]) {
                NSString *bankString = [options valueForKey:@"nb"];
                NSMutableArray *bankList = [[NSMutableArray alloc]init];
                NSError *err;
                NSData *bankData = [bankString dataUsingEncoding:NSUTF8StringEncoding];
                ////NSLog(@"horvnrev======== %@",bankData);
                NSDictionary *bankDict = [NSJSONSerialization JSONObjectWithData:bankData options:NSJSONReadingMutableLeaves error:&err];
                // //NSLog(@"horvnrev======== %@",bankDict);
                for (id key in bankDict){
                    //NSLog(@"key %@ value %@",key,[[bankDict valueForKey:key]valueForKey:@"title"]);
                    //[bankDetails setValue:[[bankDict valueForKey:key]valueForKey:@"title"] forKey:[bankDict valueForKey:key]];
                    [bankList addObject:key];
                    [bankList addObject:[[bankDict valueForKey:key]valueForKey:@"title"]];
                    
                }
                arrBankList = bankList;
                 [cellTitleArr addObject:NET_BANKING];
                
            }
            

         
            
            if ([self isValidString:[options valueForKey:@"wallet"]]) {
                if ([[options valueForKey:@"wallet"]isEqualToString:@"true"]) {
                    [self checkForWallet];
                }
            }

            
        }
    }
}
-(void)doThePayment : (NSDictionary *)responseDict
{
    if (![[[[responseDict objectForKey:@"result"]objectForKey:@"payment"] objectForKey:@"txnDetails"] isKindOfClass:[NSNull class]]) {
        
        // if (![[[[responseDict objectForKey:@"result"]objectForKey:@"cashbackAccumulated" ] objectForKey:@"paymentId"]isEqualToString:@"<null>"]) {
        NSString *paymentID = [NSString stringWithFormat:@"%@",[[[[responseDict objectForKey:@"result"]objectForKey:@"payment"]objectForKey:@"txnDetails" ]  objectForKey:@"paymentId"]];
        [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:[NSString stringWithFormat:@"%@",paymentID] forKey:KEY_PAYMENT_ID];
    }
    
    NSString *mID = [[[responseDict objectForKey:@"result"] objectForKey:@"payment"] objectForKey:@"merchantId"];
    [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:[NSString stringWithFormat:@"%@",mID] forKey:KEY_MERCHANT_ID];
    

    
//    if (![[[responseDict objectForKey:@"result"]objectForKey:@"cashbackAccumulated" ] isKindOfClass:[NSNull class]]) {
//        
//       // if (![[[[responseDict objectForKey:@"result"]objectForKey:@"cashbackAccumulated" ] objectForKey:@"paymentId"]isEqualToString:@"<null>"]) {
//    NSString *paymentID = [NSString stringWithFormat:@"%@",[[[responseDict objectForKey:@"result"]objectForKey:@"cashbackAccumulated" ]  objectForKey:@"paymentId"]];
//    
//    if([paymentID isKindOfClass:[NSString class]]){
//        [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:paymentID forKey:KEY_PAYMENT_ID];
//    }
//    }
//   // }
//    
//    NSString *mID = [[[responseDict objectForKey:@"result"] objectForKey:@"merchant"] objectForKey:@"merchantId"];
//    if([mID isKindOfClass:[NSString class]]){
//        [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn setObject:mID forKey:KEY_MERCHANT_ID];
//    }
     //NSLog(@"%@",[AppSettings sharedInstance].dictCurrentTxn);
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    //NSLog(@"card data --------> %@",cardDetails);
    
 
    
    
    if (![paymentMode isEqual:@"wallet"] && ![paymentMode isEqual:@"points"])
    {
        
        NSString *key = [cardDetails valueForKey:@"key"];
       
        NSDictionary *hashDict =[[[responseDict valueForKey:@"result"]valueForKey:@"transactionDto"]valueForKey:@"hash"];
        
       if(![paymentMode isEqual:@"NB"])
        {
            
            NSString *string = [NSString stringWithFormat:@"%@|payu|%@|%@|%@|",[cardDetails valueForKey:@"ccnum"],[cardDetails valueForKey:@"ccvv"],[cardDetails valueForKey:@"ccexpmon"],[cardDetails valueForKey:@"ccexpyr"]];
            //NSLog(@"++++++++++++++++ %@",string);
            NSString *encString = [RSA encryptString:string publicKey:key];
            //NSLog(@"encrypted string +++++++++++++ %@",encString);
            //                   NSData *base64Data = [encString dataUsingEncoding:NSUTF8StringEncoding ];
            //                    NSString *base64String =[base64Data base64EncodedStringWithOptions:0];
            [params setValue:[encString encodeString:NSUTF8StringEncoding] forKey:@"encrypted_payment_data"];
        }
        
        if(![hashDict isEqual:[NSNull null]])
        {
            NSArray *keys = [hashDict allKeys];
            for (int i = 0; i<keys.count; i++) {
                [params setValue:[hashDict valueForKey:keys[i]] forKey:keys[i]];
            }
        }
        [params setValue:paymentMode forKey:@"pg"];
        if([cardDetails valueForKey:@"bankcode"])
        {
            [params setValue:[cardDetails valueForKey:@"bankcode"] forKey:@"bankcode"];
        }
        else
        {
            [params setValue:paymentMode forKey:@"bankcode"];
        }
        if(![paymentMode isEqual:@"NB"])
        {
            if([cardDetails valueForKey:@"card_name"])
                [params setValue:[cardDetails valueForKey:@"card_name"] forKey:@"card_name"];
            if([cardDetails valueForKey:@"store_card"])
            {
                [params setValue:[cardDetails valueForKey:@"store_card"] forKey:@"store_card"];
//                if (self.btnOneTap.selected) {
//                    
//            
//                [params setValue:@"1" forKey:@"one_click_checkout"];
//                [params setValue:configBO.userToken forKey:@"userToken"];
//                    
//                }
                
            }
            
            if([cardDetails valueForKey:@"store_card"])
                [params setValue:[cardDetails valueForKey:@"store_card"] forKey:@"store_card"];
            
//            if (self.btnOneTap.isSelected) {
//                if ([cvvHash isEqualToString:@""]) {
//                    [params setValue:@"1" forKey:@"one_click_checkout"];
//                    if (configBO && configBO.userToken) {
//                        [params setValue:configBO.userToken forKey:@"userToken"];
//                    }
//                }
//                else
//                {
//                    [params setValue:cvvHash forKey:@"card_merchant_param"];
//                }
//            }
        }
        //converting to urlencoded format
        
        NSArray *paramsKeys = [params allKeys];
        NSMutableString *paramString = [[NSMutableString alloc]init];
        for (int i =0 ; i<paramsKeys.count; i++) {
            [paramString appendString:[NSString stringWithFormat:@"%@=%@",paramsKeys[i],[params valueForKey:paramsKeys[i]] ]];
            if(i <paramsKeys.count-1)
                [paramString appendString:@"&"];
        }
        
        if (SDK_APP_CONSTANT.isServerReachable) {
            
        
        UIStoryboard *sdkSB = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
        PayuMoneySDKWebViewViewController *webVC = [sdkSB instantiateViewControllerWithIdentifier:@"webVC"];
        webVC.paymentId = [[[response objectForKey:@"result"]objectForKey:@"payment" ]  objectForKey:@"paymentId"];
           // webVC.paymentId = [[PayuMoneySDKAppConstant sharedInstance].dictCurrentTxn valueForKey:KEY_PAYMENT_ID];
        webVC.urlString = Web_Payment_URL;
        webVC.type = @"post";
        webVC.bodyParams = paramString;
        [self.navigationController pushViewController:webVC animated:YES ];
        }
        else
        {
            ALERT(@"Internet not connected", @"Please connect");
        }
    }
}

-(void)calculateAmount
{

    if(payuPoints >= amount - discount)
    {
        [self setAmount:0.00];
    }
    else
    {
        [self calculateAmountForWallet];
        
                
    }
   
    if (selectedCouponDict) {
        self.savingsLbl.text = [NSString stringWithFormat:@"Savings : Rs.%0.2lf",[[selectedCouponDict valueForKey:@"couponAmount"]doubleValue] + payuPoints];
    }
    else
    {
    if (discount != 0.00 || payuPoints != 0.00)
        self.savingsLbl.text = [NSString stringWithFormat:@"Savings : Rs.%0.2lf",discount + payuPoints];
    else
        [self.savingsLbl setHidden:YES];
    }
}

-(void)payViaPoints
{
   
        PayuMoneySDKPayUsingPointsAlert *alert = [[ PayuMoneySDKPayUsingPointsAlert alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 123 , self.view.frame.size.height / 2 - 142  , 246, 300)];
        alert.delegate = self;
        [self prepareBackgroundView:alert];
        
   
    

}
-(void)presentSameControllerWithData
{
      // amt_convenience = 0.00;
    [self calculateConvenienceFee];
    payuPoints = 0.00;
    //userPoints = 0.00;
    [self loadingPaymentView];
}
-(void)presentOtherControllerWithData
{
    UIStoryboard *sdkSB = [UIStoryboard storyboardWithName:@"PayUSDK" bundle:nil];
    amt_convenience = wallet;
    PayuMoneySDKPayUsingPointsViewController *payUsingPointsVC =[sdkSB instantiateViewControllerWithIdentifier:@"payUsingPointsVC"];
    payUsingPointsVC.fromApp = fromPayuMoneyApp;
    payUsingPointsVC.amount = StringFromDouble(amount) ;
    payUsingPointsVC.convenienceCharge = amt_convenience;
   
    
    if (selectedCouponDict) {
        payUsingPointsVC.type = @"Coupon Disscount";
        payUsingPointsVC.discount = StringFromDouble([[selectedCouponDict valueForKey:@"couponAmount"] doubleValue]);
        payUsingPointsVC.netAmount =  StringFromDouble(amount  + amt_convenience - [[selectedCouponDict valueForKey:@"couponAmount"] doubleValue]);
    }
    else if(discount != 0.00)
    {
        payUsingPointsVC.type = @"Discount";
        payUsingPointsVC.discount = StringFromDouble(discount);
        payUsingPointsVC.netAmount =  StringFromDouble(amount - discount + amt_convenience);
    }
    else if([[[[[response valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerType" ] isEqualToString:@"CashBack"] )
    {
        payUsingPointsVC.type = @"Cashback";
        payUsingPointsVC.discount = [[[[response valueForKey:@"result"] valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerAmount" ] ;
        payUsingPointsVC.netAmount = StringFromDouble(amount + amt_convenience);
    }
    else
    {
         payUsingPointsVC.netAmount = StringFromDouble(amount + amt_convenience);
    }
    payUsingPointsVC.totalPoints = StringFromDouble(userPoints);
    payUsingPointsVC.responseDict = response;
    payUsingPointsVC.couponApplied = selectedCouponDict;
    [self.navigationController pushViewController:payUsingPointsVC animated:YES];
    
    
}

-(void)findingCouponData
{
    couponArray = [[NSMutableArray alloc]init];
    if(![[[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"coupons"] isKindOfClass:[NSNull class]])
    {
        [self.applyCoupon setHidden:NO];
        
        NSArray *arr = [[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"coupons"];
        
        for (int i =0; i<arr.count; i++) {
            NSLog(@"%@",[self checkNullValue:[[arr objectAtIndex:i]valueForKey:@"enabled"]]);
            if ([[self checkNullValue:[[arr objectAtIndex:i]valueForKey:@"enabled"] ] isEqualToString:@"1"] ) {
                [couponArray addObject:[arr objectAtIndex:i]];
            }
        }
    }
    //else
    if (couponArray.count == 0 ) {
         [self.applyCoupon setHidden:YES];
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

-(void)calculateConvenienceCharges
{
    if([[response valueForKey:@"result"] valueForKey:@"convenienceCharges"])
    {
        NSString *str = [[response valueForKey:@"result"] valueForKey:@"convenienceCharges"];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *charges = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
        //NSLog(@"%@",charges);
        cc = [[[charges valueForKey:@"CC"] valueForKey:@"DEFAULT" ] doubleValue];
        dc = [[[charges valueForKey:@"DC"] valueForKey:@"DEFAULT" ]doubleValue];
        emi = [[[charges valueForKey:@"EMI"]valueForKey:@"DEFAULT" ] doubleValue];
        cash = [[[charges valueForKey:@"CASH"] valueForKey:@"DEFAULT" ] doubleValue];
        wallet = [[[charges valueForKey:@"WALLET"] valueForKey:@"DEFAULT" ]doubleValue];
        nb = [[[charges valueForKey:@"NB"] valueForKey:@"DEFAULT" ] doubleValue];
        amt_convenience = 0.00;
    }
}
-(void)setAmount : (double)amt
{
    self.amountToPay.text = StringFromDouble(amt);
    [self.amountToPay setFont:[UIFont systemFontOfSize:15.0]];
     CGSize lblsize = [self.amountToPay.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]}];
    [self.amountToPay setFrame:CGRectMake(self.amountToPay.frame.origin.x, self.amountToPay.frame.origin.y, lblsize.width, self.amountToPay.frame.size.height)];
  // [self.amountToPay addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqual:@"text"])
    {
        id amt= [change objectForKey:NSKeyValueChangeNewKey];
        //NSLog(@"%@",amt);
    }
}

-(void)checkForWallet
{
    if (![[[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"wallet"] isKindOfClass:[NSNull class]] ) {
        
        double wallletamount = [[[[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"wallet"]valueForKey:@"amount"] doubleValue];
    if( wallletamount > 0.00  )
    {
      
        [self.useWalletLbl setHidden:NO];
        [self.useWalletBtn setHidden:NO];
        walletBal = [[[[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"wallet"] valueForKey:@"amount"] doubleValue];
        [self.initialBalLbl setHidden:NO];
        self.initialBalLbl.text = [NSString stringWithFormat:@"Wallet Balance : Rs.%0.2lf",walletBal];
    }
    }
}

-(BOOL)ifWalletIsSupported
{
    return YES;
}

//-(NSString*)checkNullValue:(id)text
//{
//    NSString *parsedText = @"";
//    if([text isKindOfClass:[NSString class]])
//    {
//        if([text isEqualToString:@"<null>"])
//            parsedText = @"";
//        else{
//            parsedText = text;
//        }
//    }
//    else if ([text isKindOfClass:[NSNumber class]]){
//        parsedText = [text stringValue];
//    }
//    return parsedText;
//}
-(void)viewTapped : (id)sender
{
    //NSLog(@"%@",sender);
    UIView *theSuperview = self.view;
    CGPoint touchPointInSuperview = [sender locationInView:theSuperview];
    UIView *touchedView = [theSuperview hitTest:touchPointInSuperview withEvent:nil];
    if(![touchedView isKindOfClass:[ PayuMoneySDKSavedCardCvv class]])
    {
    
        NSArray *arr =  [self.view subviews];
        for (int i =0; i<arr.count; i++)
        {
            if([[arr objectAtIndex:i] isKindOfClass:[ PayuMoneySDKSavedCardCvv class]])
            {
              //  [[[arr objectAtIndex:i] superview] removeFromSuperview];
                [[arr objectAtIndex:i]removeFromSuperview];
            }
        }
    }
}

//-(void)viewDetailsBtnClicked
//{
//    [self viewPaymentDetails];
//}
-(void)viewPaymentDetails
{
    CGFloat cashAmt;
//    if ([[[[[response valueForKey:@"result"]valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerType"]isEqualToString:@"Discount"] ) {
//        disAmt = [[[[[response valueForKey:@"result"]valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerAmount"] doubleValue];
//        cashAmt = 0.00;
//    }
    if ([[[[[response valueForKey:@"result"]valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerType"]isEqualToString:@"CashBack"] ) {
        cashAmt = [[[[[response valueForKey:@"result"]valueForKey:@"merchant"]valueForKey:@"offer"] valueForKey:@"offerAmount"] doubleValue];
//       disAmt = 0.00;
  }
    else
        cashAmt = 0.00;
//    else
//    {
//        disAmt = 0.00;
//        cashAmt = 0.00;
//    }
    PayuMoneySDKPaymentBreakdown *pay = [[ PayuMoneySDKPaymentBreakdown alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 136, self.view.frame.origin.y + self.navigationController.navigationBar.frame.size.height + (self.view.frame.size.height - 64)/2 - 175, 278 , 350) withAmount:StringFromDouble(amount) withConvenienceAmt:StringFromDouble(amt_convenience) withTotalAmt:StringFromDouble(amount + amt_convenience) withPoints:StringFromDouble(payuPoints) withDiscount:StringFromDouble(discount) withCouponDiscount:StringFromDouble([[selectedCouponDict valueForKey:@"couponAmount"]doubleValue]) withNetAmount:self.amountToPay.text withWallet:StringFromDouble(walletUsage) withCashBack:StringFromDouble(cashAmt)];
    
              [self prepareBackgroundView:pay];
}

-(void)prepareBackgroundView : (UIView *)pay
{
    
    pay.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    pay.layer.shadowColor = SDK_BROWN_COLOR.CGColor;
    pay.layer.shadowRadius = 3;
    pay.layer.shadowOpacity = 0.5;
    pay.layer.masksToBounds = NO;
    pay.layer.borderWidth = 1.0;
    pay.layer.borderColor = SDK_BROWN_COLOR.CGColor;

    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [backgroundView setBackgroundColor:[UIColor lightGrayColor]];
   // [self.paymentTableView setScrollEnabled:NO];
    [self.view addSubview:backgroundView];
    [backgroundView addSubview:pay];
    
    backgroundView.center = self.view.center;
   // view.center = backgroundView.center;
    
    
}





-(NSArray *)bankListNames
{
    if ([[[[response valueForKey:@"result"] valueForKey:@"paymentOptions"]valueForKey:@"options"] valueForKey:@"nb"]) {
       NSString *bankString = [[[[response valueForKey:@"result"] valueForKey:@"paymentOptions"]valueForKey:@"options"] valueForKey:@"nb"];
       NSMutableArray *bankList = [[NSMutableArray alloc]init];
        NSError *err;
        NSData *bankData = [bankString dataUsingEncoding:NSUTF8StringEncoding];
        ////NSLog(@"horvnrev======== %@",bankData);
        NSDictionary *bankDict = [NSJSONSerialization JSONObjectWithData:bankData options:NSJSONReadingMutableLeaves error:&err];
        // //NSLog(@"horvnrev======== %@",bankDict);
        for (id key in bankDict){
            //NSLog(@"key %@ value %@",key,[[bankDict valueForKey:key]valueForKey:@"title"]);
            //[bankDetails setValue:[[bankDict valueForKey:key]valueForKey:@"title"] forKey:[bankDict valueForKey:key]];
            [bankList addObject:key];
            [bankList addObject:[[bankDict valueForKey:key]valueForKey:@"title"]];
            
        }
        return bankList;

    }
    return nil;
}

-(NSArray * )savedCardsList
{
    //arrSavedCards = [[NSMutableArray alloc]init];
    
    if ([[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"savedCards"] )
    {
        
       return [[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"savedCards"];
    }
    return nil;
}






-(void)sendingDataToPayment:(NSString *)mode withData:(NSDictionary *)data
{
    paymentMode = mode;
    if(![data valueForKey:@"key"])
        [data setValue:[[[[[response valueForKey:@"result"]valueForKey:@"paymentOptions"]valueForKey:@"config"]valueForKey:@"publicKey"] stringByReplacingOccurrencesOfString:@"\\r" withString:@""] forKey:@"key"];
    cardDetails = data;
    
  
    if([mode isEqual:@"CC"])
        amt_convenience = cc;
    else if ([mode isEqual:@"DC"])
        amt_convenience = dc;
    else if ([mode isEqual:@"NB"])
    {
        
        
        amt_convenience = nb;
    }
    else if ([mode isEqual:@"Emi"])
        amt_convenience = emi;
    else if ([mode isEqual:@"wallet"])
        amt_convenience = wallet;
    else if ([mode isEqual:@"cash"])
        amt_convenience = cash;
    session = [PayuMoneySDKSession sharedSession];
    session.delegate = self;
    if (SDK_APP_CONSTANT.isServerReachable) {
    
        [ PayuMoneySDKActivityView activityViewForView:self.view.window withLabel:LOADER_MESSAGE];
        
    [session sendToPayUWithWallet:response :mode :data :payuPoints :walletUsage : selectedCouponDict : amt_convenience];
    }
    else
    {
        ALERT(@"Internet not connected", @"Please connect");
    }
}

-(void)dataFromNetBankingwithMode:(NSString *)mode withData:(NSDictionary *)data
{
    
   
        [self sendingDataToPayment:mode withData :data];
}


-(void)sendSelectedCoupon : (NSDictionary *)couponDict
{
        selectedCouponDict = couponDict;
   // [self.applyCoupon setTitle:@"Remove Coupon" forState:UIControlStateNormal];
    [self.applyCoupon setTitle:@"Remove Coupon" forState:UIControlStateNormal] ;
    CGSize lblsize = [[NSString stringWithFormat:@"%@",@"Remove Coupon"] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]}];
    [self.applyCoupon setFrame:CGRectMake(self.view.frame.size.width - lblsize.width - 5, self.applyCoupon.frame.origin.y, lblsize.width, self.applyCoupon.frame.size.height)];
    couponLabel = [[UILabel alloc]init];
    couponLabel.text = [NSString stringWithFormat:@"%@ Applied",[couponDict valueForKey:@"couponString"]];
    CGSize labelSize = [couponLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10.0]}];
    [couponLabel setFrame:CGRectMake(self.view.frame.size.width - labelSize.width, self.applyCoupon.frame.origin.y + self.applyCoupon.frame.size.height, labelSize.width, labelSize.height)];
    couponLabel.font = [UIFont systemFontOfSize:10.0];
    [self.headerView addSubview:couponLabel];

    if (amount + wallet - [[couponDict valueForKey:@"couponAmount" ] doubleValue] <= payuPoints ) {
        [self payViaPoints];
    }
else
{
    [self calculateAmountForWallet];
}
    self.savingsLbl.text = [NSString stringWithFormat:@"Savings : Rs.%0.2lf",payuPoints + [[selectedCouponDict valueForKey:@"couponAmount"] doubleValue]];
    [self.savingsLbl setHidden:NO];
}
- (IBAction)useWalletCheckboxBtnClicked:(UIButton *)sender {
    if(!self.useWalletBtn.selected)
    {
        self.useWalletBtn.selected = YES;
        
    }
    else
    {

        self.useWalletBtn.selected = NO;

        walletUsage = 0.0;
    }
    [self calculateAmountForWallet];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ButtonPressed" object:nil];
}

- (IBAction)viewDetailsBtnClicked:(UIButton *)sender {
   // [self.paymentTableView setScrollEnabled:NO];
    [self viewPaymentDetails];
}
- (IBAction)applyCouponBtnClicked:(UIButton *)sender {
    if([sender.titleLabel.text isEqual:@"Apply Coupon"])
    {
        //NSLog(@"origin y %f",self.paymentView.frame.origin.y);
        PayuMoneySDKCouponView *couponView = [[PayuMoneySDKCouponView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 135,  self.view.frame.size.height / 2 - 200, 271, 369) withArray: couponArray];
        couponView.couponDelegate = self;
        
        [self prepareBackgroundView:couponView];
    }
    else
   {


       
       // [self.applyCoupon setTitle:@"Apply Coupon" forState:UIControlStateNormal];
       [self.applyCoupon setTitle:@"Apply Coupon" forState:UIControlStateNormal] ;
        [couponLabel removeFromSuperview];
      //  [savingLabel removeFromSuperview];
      //  savingLabel = nil;
        couponLabel = nil;
        selectedCouponDict = nil;
              [self calculateAmountForWallet];
        if (discount  || payuPoints)
            self.savingsLbl.text = [NSString stringWithFormat:@"Savings : Rs.%0.2f",discount  + payuPoints];
        else
            [self.savingsLbl setHidden:YES];
        
    }
}

-(void)showPaymentView
{
    if (!self.useWalletBtn.selected || [self.amountToPay.text doubleValue] > 0.00) {
        
//        if (![[[[response valueForKey:@"result"] valueForKey:@"user"]valueForKey:@"savedCards"] isKindOfClass:[NSNull class]] )
//        {
//            cellTitleArr = [NSArray arrayWithObjects:@"Saved Cards",@"Credit Cards",@"Debit Cards",@"Net Banking", nil];
//        }
//        else
//            cellTitleArr = [NSArray arrayWithObjects:@"Credit Cards",@"Debit Cards",@"Net Banking", nil];
        [self.paymentTableView setHidden:NO];
        if (btnView) {
            [[btnView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [btnView removeFromSuperview];
            btnView = nil;
        }
        
        //[self.paymentTableView reloadData];
    }
    else if(self.useWalletBtn.selected && [self.amountToPay.text doubleValue] == 0.00)
    {
       // cellTitleArr = nil;
        
        //[self.paymentTableView reloadData];
        
        if (btnView) {
            [[btnView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [btnView removeFromSuperview];
            btnView = nil;
        }
        btnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.paymentTableView.frame.origin.y, self.paymentTableView.frame.size.width, self.paymentTableView.frame.size.height )];
        [btnView setBackgroundColor:[UIColor whiteColor]];
      
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [payBtn addTarget:self action:@selector(PayBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [payBtn setTitle:@"Pay Now" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn setBackgroundColor:SDK_BROWN_COLOR];
        [payBtn setFrame:CGRectMake(20, 20, btnView.frame.size.width - 40, 40)];
        [btnView addSubview:payBtn];
        payBtn.layer.cornerRadius = 3.0;
        [self.paymentTableView setHidden:YES];
        [self.view addSubview:btnView];
        [self.view bringSubviewToFront:self.imgSecurity];

        
    }
    
}
-(void)PayBtnClicked : (UIButton *)sender
{
    PayuMoneySDKPaymentUsingWallet *walletPayment = [[PayuMoneySDKPaymentUsingWallet alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 139,  ((self.view.frame.size.height - 64)/2) - 190  + 64, 278, 379) withResponse : response withCoupon : selectedCouponDict   withWalletUsage : walletUsage withConvenienceFee : wallet withPoints:StringFromDouble(payuPoints)];
    walletPayment.delegate = self;
    [self prepareBackgroundView:walletPayment];
}
-(void)sendingPaymentMode:(NSString *)mode
{
    if([mode isEqual:@"Credit Card"])
    {
        paymentMode = @"CC";
        amt_convenience = cc;
    }
    else if ([mode isEqual:@"Debit Card"])
    {
        paymentMode = @"DC";
        amt_convenience = dc;
    }
    else if ([mode isEqual:@"Net Banking"])
    {
        paymentMode = @"NB";
        amt_convenience = nb;
    }
    else if([mode isEqual:@"Saved Cards"])
        paymentMode = @"SC";
}

-(void)backToPaymentContollerWithWebView:(PayuMoneySDKWebViewViewController *)webView
{
    [self.navigationController pushViewController:webView animated:YES];
}
-(void)paymentDetailsView
{
    [self viewPaymentDetails];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    
    UIView *vwHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
   // vwHeader.backgroundColor = [UIColor lightGrayColor];
    
    
    UILabel *lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, vwHeader.frame.size.width-20, vwHeader.frame.size.height - 5)];
    lblHeaderTitle.text = cellTitleArr[section];
    lblHeaderTitle.textColor = [UIColor blackColor];
    lblHeaderTitle.font = [UIFont systemFontOfSize:15.0];
    [vwHeader addSubview:lblHeaderTitle];
    lblHeaderTitle = nil;
    
    UIButton *btnExpand = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnExpand setBackgroundImage:[UIImage imageNamed:@"button_billinfo"] forState:UIControlStateNormal];
    [btnExpand setTintColor:[UIColor clearColor]];
    [btnExpand setBackgroundImage:[UIImage imageNamed:@"button_billinfo_pressed"] forState:UIControlStateSelected];
    btnExpand.frame = CGRectMake(vwHeader.frame.size.width - 60, 5, 40, 40);
    btnExpand.tag = kGenericTag+section;
    [btnExpand addTarget:self action:@selector(btnExpandClicked:) forControlEvents:1];
    [vwHeader addSubview:btnExpand];
    
    btnExpand.selected = currentExpandedSection == section;
    if (section < cellTitleArr.count - 1) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, vwHeader.frame.size.height - 3, vwHeader.frame.size.width, 1)];
        imgView.backgroundColor = [UIColor lightGrayColor];
        [vwHeader addSubview:imgView];
        [vwHeader setBackgroundColor: [UIColor whiteColor]];
    }
    return vwHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[cellTitleArr objectAtIndex:indexPath.section]isEqualToString:@"Saved Cards"]) {
//        if(indexPath.row ==  rowExpanded)
//        {
        
            CGFloat height = self.view.frame.size.height - self.headerView.frame.size.height - 200 - 64 - 50;
        if (height < arrSavedCards.count * savedcardheight) {
            tblHeight = height;
        }
        else
            tblHeight = arrSavedCards.count * savedcardheight;
        return tblHeight;
//        if (height <= 160) {
//                tblHeight = 160;
//                return 160;
//            }
//            else
//            {
//                tblHeight = height;
//            return height;
//            }
//        }
//        else
//            return 100.0f;
    }
    
    return 300.0f;
    
    
    //    if (indexPath.row == rowExpanded) {
    //        return 300.0f;
    //    }
    //    else
    //        return 50.0f;
}

-(void)btnExpandClicked:(UIButton*)btnSender
{
    currentExpandedSection = (int) btnSender.tag - kGenericTag;
    
    if(btnSender.selected ){
     

        
        UITableViewCell *cell = [self.paymentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentExpandedSection]];
       [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        currentExpandedSection = -1;
       // btnSender.selected = !btnSender.selected;
    }
//    else{
//       
//        
//        
//    }
     btnSender.selected = !btnSender.selected;
    [self calculateAmountForWallet];
    [self.paymentTableView reloadData];

   
        if(currentExpandedSection >=0){
            
            
            [self.paymentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentExpandedSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            //[self.paymentTableView layoutIfNeeded];
           // contentOffset = self.paymentTableView.contentOffset;
            [self performSelector:@selector(updateCurrentContentOffset) withObject:nil afterDelay:1.0];
        }
        else{
            [self.paymentTableView setContentOffset:CGPointZero animated:YES];
        }
 
    
//    if (currentExpandedSection == -1) {
//        [self.paymentTableView setContentOffset:CGPointZero animated:YES];
//    }
//    else
//    {
//        CGRect rect = [self.paymentTableView rectForRowAtIndexPath:[[self.paymentTableView indexPathsForVisibleRows]objectAtIndex:0]];
//        NSLog(@"in cell %@",rect);
//        
//    }


}

-(void)updateCurrentContentOffset{
     contentOffset = self.paymentTableView.contentOffset;
}

// custom view for header. will be adjusted to default or specified header height


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return cellTitleArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentExpandedSection == section){
        
//        if([[cellTitleArr objectAtIndex:section] isEqualToString:@"Saved Cards"])
//            return arrSavedCards.count;
//        else{
            return 1;
        //}
    }
    return 0;
}
-(void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([[cellTitleArr objectAtIndex:indexPath.section]isEqualToString:@"Saved Cards"]) {
       
//        alertCVV = [[UIAlertView alloc] initWithTitle:nil message:@"Enter CVV" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Pay", nil];
        
        
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(controlCvvBG){
        [controlCvvBG removeFromSuperview];
        controlCvvBG = nil;
    }
    
    controlCvvBG = [[UIControl alloc] initWithFrame:self.view.bounds];
    controlCvvBG.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.5];
    [controlCvvBG addTarget:self action:@selector(tapOnBackgroundView) forControlEvents:1];
    //self.paymentTableView.scrollEnabled = NO;
    [self.view addSubview:controlCvvBG];
    
    
        PayuMoneySDKSavedCardCvv *cvv = [[PayuMoneySDKSavedCardCvv alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 108, 100, 217 , 150) withCardType : [PayuMoneySDKSetUpCardDetails findIssuer:[[arrSavedCards objectAtIndex:indexPath.row]valueForKey:@"ccnum"] :[[arrSavedCards objectAtIndex:indexPath.row]valueForKey:@"pg"] ]] ;

        cvv.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        cvv.layer.shadowColor = SDK_BROWN_COLOR.CGColor;
        cvv.layer.shadowRadius = 3;
        cvv.layer.shadowOpacity = 0.5;
        cvv.layer.masksToBounds = NO;
        cvv.layer.borderWidth = 2.0;
        cvv.layer.borderColor = SDK_BROWN_COLOR.CGColor;
      
    cvv.cvvLen = [self cvvLength:[[arrSavedCards objectAtIndex:indexPath.row]valueForKey:@"ccnum"]];
    cvv.index = (int) indexPath.row;
        if ([[[arrSavedCards objectAtIndex:indexPath.row]valueForKey:@"pg"] isEqualToString:@"CC"]) {
            amt_convenience = cc;
        }
        else
            amt_convenience = dc;
        if (self.useWalletBtn.selected)
        [self setAmount:[self.amountToPay.text doubleValue] + amt_convenience - wallet];
        else
            [self setAmount:[self.amountToPay.text doubleValue] + amt_convenience];
    //   self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    cvv.delegate = self;
    //[self.paymentTableView addSubview:cvv];
    //
    //    [cvv.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [cvv.payBtn setBackgroundColor:BROWN_COLOR];
    //
    [controlCvvBG addSubview:cvv];
        cvv.center = self.view.center;
    // //NSLog(@"card tapped %d ",view.j);
    }
    else
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellNew";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==  nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView addSubview:[self showViewForExpandedRow:indexPath]];
   

    if([[cellTitleArr objectAtIndex:indexPath.section]isEqualToString:@"Saved Cards"] && indexPath.row == rowExpanded)
    {
        tableView.separatorColor = SDK_APP_TEXT_COLOR;
    }
    cell.clipsToBounds = YES;
    return cell;
}


-(void)changeTableContentOffset : (CGFloat)value
{
    if (value != 0.00f) {
        //self.paymentTableView.scrollEnabled = NO;
       // self.paymentTableView.showsVerticalScrollIndicator = NO;
    }
    else
    {
        //self.paymentTableView.scrollEnabled = YES;
        // self.paymentTableView.showsVerticalScrollIndicator = YES;
    }
    if (value == 0) {
        [self.paymentTableView setContentOffset:contentOffset animated:YES];
    }
    else
    {
    CGPoint pt = self.paymentTableView.contentOffset;
    
    if (pt.y < value) {
        [self.paymentTableView setContentOffset:CGPointMake(0, value )];

    }
    }
    
   }
-(UIView *)showViewForExpandedRow : (NSIndexPath *)indexPath
{
    NSInteger yPos = 0;
    int index;
    if ([[cellTitleArr objectAtIndex:indexPath.section] isEqualToString:SAVED]) {
        index = 0;
    }
    else if ([[cellTitleArr objectAtIndex:indexPath.section] isEqualToString:CREDIT])
    {
        index = 1;
        
    }
    else if ([[cellTitleArr objectAtIndex:indexPath.section] isEqualToString:DEBIT])
    {
        index = 2;
        
    }
    else if ([[cellTitleArr objectAtIndex:indexPath.section] isEqualToString:NET_BANKING])
    {
        index = 3;
        
    }
    switch (index) {
        case 0:
        {
    SavedCardTableView *scard = [[SavedCardTableView alloc]initWithFrame:CGRectMake(0, 0, self.paymentTableView.frame.size.width, tblHeight) withArr:arrSavedCards withBO:configBO withUserId:[self checkNullValue:[[[response valueForKey:@"result"]valueForKey:@"user"]valueForKey:@"userId"]] withPaymentId:[self checkNullValue:[[response valueForKey:@"result"]valueForKey:@"paymentId"]]];
            scard.savedCardTbldelegate = self;

            return scard;
        }
            
        case 1:
        {
            PayuMoneySDKCardView *cardView = [[PayuMoneySDKCardView alloc]initWithFrame:CGRectMake(0, yPos, self.paymentTableView.frame.size.width, 280)withDelegate:self];
            cardView.loc = self.headerView.frame.origin.y + self.headerView.frame.size.height + 120 ;
           
           // amt_convenience = cc;
//            CGRect rect1 = [self.paymentTableView rectForRowAtIndexPath:[[self.paymentTableView indexPathsForVisibleRows]objectAtIndex:1]];
//            if (cardView.loc + 280 > CGRectGetHeight(self.view.frame) - 64) {
//                [self.paymentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentExpandedSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//                CGRect rect = [self.paymentTableView rectForRowAtIndexPath:indexPath];
//            }
            
            cardView.mode = @"CC";
            return cardView;
        }
            break;
        case 2:
        {
            PayuMoneySDKCardView *cardView = [[PayuMoneySDKCardView alloc]initWithFrame:CGRectMake(0, yPos, self.paymentTableView.frame.size.width, 280) withDelegate:self];
            
            cardView.loc = self.headerView.frame.origin.y + self.headerView.frame.size.height + 188  ;
            
//            if (cardView.loc + 280 > CGRectGetHeight(self.view.frame) - 64) {
//                [self.paymentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentExpandedSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//                 CGRect rect = [self.paymentTableView rectForRowAtIndexPath:indexPath];
//                NSLog(@"%@",rect);
//            
//            }
                      //  amt_convenience = dc;
          //  cardView.loc = (int)yPos;
            cardView.mode = @"DC";
            return cardView;
        }
        case 3:
        {
            PayuMoneySDKNetBanking *netBanking = [[PayuMoneySDKNetBanking alloc]initWithList:[self bankListNames] withFrame:CGRectMake(0, yPos, self.paymentTableView.frame.size.width, 300)];
            netBanking.nbDelegate = self;
            netBanking.loc = self.headerView.frame.origin.y + self.headerView.frame.size.height + 255  ;
            
//            if (netBanking.loc + 300 > CGRectGetHeight(self.view.frame) - 64) {
//                [self.paymentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentExpandedSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//            }
//           

           // amt_convenience = nb;
            return netBanking;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

#pragma SavedCardTableViewDelegate
-(void)hitApiForSavedCardOneClick : (NSString *)requestBody
{
    session = [PayuMoneySDKSession sharedSession];
    session.delegate = self;
//    [session
}

-(void)oneClickCardHash : (NSString *)hash withIndex : (NSInteger)index
{
    cvvHash = hash;
    [self setCardDict:(int)index];
    [self goToPayment:card :[[arrSavedCards objectAtIndex:index] valueForKey:@"pg"]];
}
-(void)savedCardSelectedRow:(NSInteger)index
{
    
    if(controlCvvBG){
        [controlCvvBG removeFromSuperview];
        controlCvvBG = nil;
    }
    
    controlCvvBG = [[UIControl alloc] initWithFrame:self.view.bounds];
    controlCvvBG.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.5];
    [controlCvvBG addTarget:self action:@selector(tapOnBackgroundView) forControlEvents:1];
    //self.paymentTableView.scrollEnabled = NO;
    [self.view addSubview:controlCvvBG];
    
    
    PayuMoneySDKSavedCardCvv *cvv = [[PayuMoneySDKSavedCardCvv alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 108, 100, 217 , 150) withCardType : [PayuMoneySDKSetUpCardDetails findIssuer:[[arrSavedCards objectAtIndex:index]valueForKey:@"ccnum"] :[[arrSavedCards objectAtIndex:index]valueForKey:@"pg"] ]] ;
    
    cvv.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    cvv.layer.shadowColor = SDK_BROWN_COLOR.CGColor;
    cvv.layer.shadowRadius = 3;
    cvv.layer.shadowOpacity = 0.5;
    cvv.layer.masksToBounds = NO;
    cvv.layer.borderWidth = 2.0;
    cvv.layer.borderColor = SDK_BROWN_COLOR.CGColor;
    
    cvv.cvvLen = [self cvvLength:[[arrSavedCards objectAtIndex:index]valueForKey:@"ccnum"]];
    cvv.index = (int)index;
    if ([[[arrSavedCards objectAtIndex:index]valueForKey:@"pg"] isEqualToString:@"CC"]) {
        amt_convenience = cc;
    }
    else
        amt_convenience = dc;
    if (self.useWalletBtn.selected)
        [self setAmount:[self.amountToPay.text doubleValue] + amt_convenience - wallet];
    else
        [self setAmount:[self.amountToPay.text doubleValue] + amt_convenience];
    //   self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    cvv.delegate = self;
    //[self.paymentTableView addSubview:cvv];
    //
    //    [cvv.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [cvv.payBtn setBackgroundColor:BROWN_COLOR];
    //
    [controlCvvBG addSubview:cvv];
    cvv.center = self.view.center;
    // //NSLog(@"card tapped %d ",view.j);
}


//-(void)btnCardSavedForClicked : (UIButton *)sender
//{
//    sender.selected = !sender.selected;
//    if(rowExpanded == sender.tag - kGenericTag)
//        rowExpanded = -1;
//    else
//        rowExpanded = (int)sender.tag - kGenericTag;
//    for (int i= 0; i < arrSavedCards.count; i++) {
//        UIButton *btn = (UIButton *)[self.paymentTableView viewWithTag:kGenericTag + i];
//        if (btn.tag != sender.tag && btn.selected) {
//            btn.selected = !btn.selected;
//        }
//    }
//    [self.paymentTableView reloadData];
//}

-(void)viewWillAppear:(BOOL)animated
{
   // [self setUpImageBackButton];
}

//-(void)savedCardPayCLicked : (UIButton *)sender
//{
//    long index = sender.tag - rowGenericTag;
//    
//    if(controlCvvBG){
//        [controlCvvBG removeFromSuperview];
//        controlCvvBG = nil;
//    }
//    
//    controlCvvBG = [[UIControl alloc] initWithFrame:self.view.bounds];
//    controlCvvBG.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.5];
//    [controlCvvBG addTarget:self action:@selector(tapOnBackgroundView) forControlEvents:1];
//    self.paymentTableView.scrollEnabled = NO;
//    [self.paymentTableView addSubview:controlCvvBG];
//    
//    
//     PayuMoneySDKSavedCardCvv *cvv = [[PayuMoneySDKSavedCardCvv alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 108, self.paymentTableView.bounds.origin.y + 130, 217 , 150)];
//    cvv.cvvLen = [self cvvLength:[[arrSavedCards objectAtIndex:index]valueForKey:@"ccnum"]];
//    cvv.index = (int) index;
//    //   self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
//    cvv.delegate = self;
//    //[self.paymentTableView addSubview:cvv];
////    
////    [cvv.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
////    [cvv.payBtn setBackgroundColor:BROWN_COLOR];
////   
//    [controlCvvBG addSubview:cvv];
//    // //NSLog(@"card tapped %d ",view.j);
//    
//}

-(void)tapOnBackgroundView
{
    if(controlCvvBG){
        //self.paymentTableView.scrollEnabled = YES;
        [controlCvvBG removeFromSuperview];
        controlCvvBG = nil;
        
        if (self.useWalletBtn.selected) {
            [self setAmount:[self.amountToPay.text doubleValue] - amt_convenience + wallet];
            amt_convenience = wallet;
            
        }
        else
        {
            [self setAmount:[self.amountToPay.text doubleValue] - amt_convenience];
             amt_convenience = 0.00;
        }
        
    }
}

-(int)cvvLength : (NSString *)cardNum
{
    if([[cardNum substringWithRange:NSMakeRange(0, 2)] isEqual:@"34"] || [[cardNum substringWithRange:NSMakeRange(0, 2)] isEqual:@"37"])
    {
        
        return 4;
        
    }
    else
    {
        
        return 3;
    }
}
-(void)setCardDict : (int)index
{
    card = [[NSMutableDictionary alloc]init];
    [card setValue:[[arrSavedCards objectAtIndex:index]valueForKey:@"ccnum"] forKey:@"ccnum"];
    [card setValue:[[arrSavedCards objectAtIndex:index]valueForKey:@"cardId"] forKey:@"storeCardId"];
    [card setValue:[[arrSavedCards objectAtIndex:index]valueForKey:@"cardToken"] forKey:@"store_card_token"];
    [card setValue:[[arrSavedCards objectAtIndex:index]valueForKey:@"cardName"] forKey:@"card_name"];
   // [card setValue:@"" forKey:@"ccnum"];
    NSString *mode;
    if([[[arrSavedCards objectAtIndex:index]valueForKey:@"pg"] isEqual:@"CC"])
        mode = @"CC";
    else
        mode = @"DC";
//    NSString *tempIssuer = [PayuMoneySDKSetUpCardDetails findIssuer:[[arrSavedCards objectAtIndex:index]valueForKey:@"ccnum"] :mode];
//    
//    if ([[self savedCardMode:index ] isEqualToString:@"CC"] && (![tempIssuer isEqualToString:@"AMEX"] || ![tempIssuer isEqualToString:@"DINR"] || ![tempIssuer isEqualToString:@"CC"] || ![tempIssuer isEqualToString:@"CC-C"] || ![tempIssuer isEqualToString:@"CC-M"] || ![tempIssuer isEqualToString:@"CC-O"]))
//        tempIssuer = @"CC";
    
    [card setValue:[[arrSavedCards objectAtIndex:index]valueForKey:@"cardType"] forKey:@"bankcode"];
//    [card setValue:[PayuMoneySDKSetUpCardDetails findIssuer:[[arrSavedCards objectAtIndex:index]valueForKey:@"ccnum"] :mode] forKey:@"bankcode"];
    [card setValue:@"" forKey:@"ccexpyr"];
    [card setValue:@"" forKey:@"ccexpmon"];
}


-(void)payBtnClicked:(NSString *)text index:(int)index
{
    [self setCardDict:index];
    [card setValue:text forKey:@"ccvv"];
    [self tapOnBackgroundView];

    [self goToPayment:card :[[arrSavedCards objectAtIndex:index] valueForKey:@"pg"]];
}
-(NSString *)savedCardMode : (int)index
{
    return  [[[arrSavedCards objectAtIndex:index]valueForKey:@"cardType"] isEqual:@"CC"] ? @"CC" : @"DC";
}

-(void)goToPayment:(NSDictionary *)cardData :(NSString *)mode
{
//    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(sendingDataToPayment : withData : )])
//    {
    if ([mode isEqualToString:@"NB"] && [[cardData valueForKey:@"bankcode"]isEqualToString:@"CITNB"]) {
        ALERT(@"Citi bank does't provide Net Banking!", @"");
        
    }
   else if ([mode isEqualToString:@"DC"] && ![availableDebitCards containsObject:[cardData valueForKey:@"bankcode"]]) {
        NSString *msg = [NSString stringWithFormat:@"The merchant doesnot support %@ Debit Cards",[cardData valueForKey:@"bankcode"]];
        ALERT(msg, @"");
    }
    else if ([mode isEqualToString:@"CC"] && ![availableCreditCards containsObject:[cardData valueForKey:@"bankcode"]]) {
        NSString *msg = [NSString stringWithFormat:@"The merchant doesnot support %@ Credit Cards",[cardData valueForKey:@"bankcode"]];
        ALERT(msg, @"");
    }
    else
        [self sendingDataToPayment : mode withData : cardData];
    //}
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    //[self.amountToPay removeObserver:self forKeyPath:@"text" context:NULL];
}


#pragma new code

-(void)applyCoupon : (double)amt
{
    if (selectedCouponDict) {
        amt -= [[selectedCouponDict valueForKey:@"couponAmount"]doubleValue];
        
    }
    else
        amt += [[selectedCouponDict valueForKey:@"couponAmount"]doubleValue];
}
-(void)calculateAmountForWallet
{
    if (self.useWalletBtn.selected)
    {
        if (selectedCouponDict) {
            [self calculatingWalletAmountWithDisAmt:[[selectedCouponDict valueForKey:@"couponAmount"] doubleValue]];
        }
        else
        {
            [self calculatingWalletAmountWithDisAmt:discount];
        }
        
    }
    else
    {
        
        [self calculateConvenienceFee];
        if (selectedCouponDict) {
            amount - [[selectedCouponDict valueForKey:@"couponAmount"]doubleValue] - payuPoints + amt_convenience  > 0.00 ?  [self setAmount:amount - [[selectedCouponDict valueForKey:@"couponAmount"]doubleValue] - payuPoints + amt_convenience] : [self setAmount:0.00];
        }
        else
        {
            amount - discount - payuPoints + amt_convenience > 0.00 ?  [self setAmount:amount - discount - payuPoints + amt_convenience] : [self setAmount:0.00];
            
        }
        if (walletBal > 0.00) {
            self.initialBalLbl.text = [NSString stringWithFormat:@"Wallet Balance : Rs.%0.2lf",walletBal];
        }
        [self showPaymentView];

    }
}
//calculates amount when wallet is selected
-(void)calculatingWalletAmountWithDisAmt : (double)dis
{
    //wallet not sufficient to pay
    if (walletBal < amount - dis - payuPoints + wallet) {
        [self calculateConvenienceFee];
        amount - dis - payuPoints  + amt_convenience - walletBal > 0.00 ? [self setAmount:amount - dis - payuPoints  + amt_convenience - walletBal] : [self setAmount:0.00];
        walletUsage = walletBal;
     
        self.initialBalLbl.text =@"Wallet Balance : Rs.0.00";
        //paymentMode = @"wallet";
    }
    else
    {
        amt_convenience = wallet;
        [self setAmount:0.00];
        walletUsage = amount - dis - payuPoints + wallet;
     
        self.initialBalLbl.text  = [NSString stringWithFormat:@"Wallet Balance : Rs.%0.2lf",walletBal -  walletUsage];
        paymentMode = @"wallet";
       
    }
     [self showPaymentView];
}
-(void)calculateConvenienceFee
{
    
    if (currentExpandedSection != -1) {
        if ([[cellTitleArr objectAtIndex:currentExpandedSection]isEqualToString:CREDIT]) {
            amt_convenience = cc;
        }
        else  if ([[cellTitleArr objectAtIndex:currentExpandedSection]isEqualToString:DEBIT]) {
            amt_convenience = dc;
        }
        else if ([[cellTitleArr objectAtIndex:currentExpandedSection]isEqualToString:NET_BANKING]) {
            amt_convenience = nb;
        }
        else
            amt_convenience = self.useWalletBtn.selected ? wallet : 0.00;
    }
    else
        amt_convenience = self.useWalletBtn.selected ? wallet : 0.00;
    
}

- (IBAction)btnOneTapClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    session = [PayuMoneySDKSession sharedSession];
    session.delegate = self;
    [session enableOneclickTransaction:btn.selected ? @"1" : @"0"];
}


@end
