//
//  APIListVC.m
//  PayUMoneyExample
//
//  Created by Umang Arya on 6/28/17.
//  Copyright © 2017 PayU. All rights reserved.
//

#import "APIListVC.h"
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>
#import "Utils.h"
#import "iOSDefaultActivityIndicator.h"
#import "PaymentVC.h"
#import "Constants.h"
#import "VerifyOTPVC.h"

@interface APIListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *arrOfAPI;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation APIListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrOfAPI = [[NSMutableArray alloc]initWithObjects:
                     @"AddPaymentAPI",
                     @"FetchPaymentUserDataAPI",
                     @"IsUserLoggedIn",
                     @"LogOut",
                     @"Login",
                     @"PayViaCCDC",
                     @"PayViaNetBanking",
                     @"PayViaStoredCard",
                     @"PayViaWallet",
                     @"NitroFlags",
                     @"VerifyOTP",
                     @"FetchUserDataAPI",
                     nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrOfAPI.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"APIListCell" forIndexPath:indexPath];
    cell.textLabel.text = [self .arrOfAPI objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *msg;
    switch (indexPath.row) {
        case 0:
            msg = [NSString stringWithFormat:@"%@",self.addPaymentAPIResponse];
            [Utils showMsgWithTitle:RESPONSE message:msg];
            break;
        case 1:
            msg = [NSString stringWithFormat:@"%@",self.fetchPaymentUserDataAPIResponse];
            [Utils showMsgWithTitle:RESPONSE message:msg];
            break;
        case 2:
            if ([PayUMoneyCoreSDK isUserSignedIn]) {
                msg = @"YES";
            }
            else{
                msg = @"NO";
                
            }
            [Utils showMsgWithTitle:RESPONSE message:msg];
            break;
        case 3:
            [PayUMoneyCoreSDK signOut];
            [Utils showMsgWithTitle:RESPONSE message:@"Done"];
            self.fetchPaymentUserDataAPIResponse = nil;
            [self.tableView reloadData];
            break;
        case 4:
        {
            [[PayUMoneyCoreSDK sharedInstance] showLoginVCOnViewController:self withCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
                if (error) {
                    [Utils showMsgWithTitle:ERROR message:error.localizedDescription];
                }
                else{
                    [self fetchPaymentUserData];
                    
                }
            }];
        }
            break;
        case 5:
        {
            if (![[self.arrOfAPI objectAtIndex:indexPath.row] isEqualToString:BLANK]) {
                PaymentVC *paymentVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PaymentVC class])];
                paymentVC.paymentMode = PUMPaymentModeCCDC;
                [self.navigationController pushViewController:paymentVC animated:YES];
            }
        }
            break;
        case 6:
        {
            if (![[self.arrOfAPI objectAtIndex:indexPath.row] isEqualToString:BLANK]) {
                PaymentVC *paymentVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PaymentVC class])];
                paymentVC.paymentMode = PUMPaymentModeNetBanking;
                paymentVC.arrNetBank = [self getAvailableNB];
                [self.navigationController pushViewController:paymentVC animated:YES];
            }
        }
            break;
        case 7:
        {
            NSDictionary *dict = self.fetchPaymentUserDataAPIResponse ? self.fetchPaymentUserDataAPIResponse :self.fetchUserDataAPIResponse;
            NSArray *arrSavedCard = [[dict valueForKey:@"result"] valueForKey:@"savedCards"];
            PaymentVC *paymentVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PaymentVC class])];
            paymentVC.paymentMode = PUMPaymentModeStoredCard;
            paymentVC.arrStoredCard = arrSavedCard;
            [self.navigationController pushViewController:paymentVC animated:YES];
        }
            break;
        case 8:
        {
            PaymentVC *paymentVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PaymentVC class])];
            paymentVC.paymentMode = PUMPaymentModeNone;
            [self.navigationController pushViewController:paymentVC animated:YES];
        }
            break;
        case 9:
        {
            //            @"NitroFlags",
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [PUMUtils convertBoolToString:[PUMHelperClass isNitroFlowEnabledForMerchant]],@"isNitroFlowEnabledForMerchant",
                                  [PUMUtils convertBoolToString:[PUMHelperClass isUserAccountActive]],@"isUserAccountActive",
                                  [PUMUtils checkNullValue:[PUMHelperClass getUserNameFromFetchUserDataAPI]],@"getUserNameFromFetchUserDataAPI",
                                  [PUMUtils convertBoolToString:[PUMHelperClass isUserMobileNumberRegistered]],@"isUsersMobileNumberRegistered",
                                  [PUMUtils checkNullValue:[PUMHelperClass getUserMobileNumberFromFetchUserDataAPI]],@"getUserMobileNumberFromFetchUserDataAPI",
                                  [PUMUtils checkNullValue:[PUMHelperClass getUserEmailFromFetchUserDataAPI]],@"getUserEmailFromFetchUserDataAPI",
                                  nil];
            
            [Utils showMsgWithTitle:@"NitroFlags" message:[NSString stringWithFormat:@"%@",dict]];
        }
            break;
        case 10:
        {
            //            @"VerifyOTP",
            VerifyOTPVC *verifyOTPVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([VerifyOTPVC class])];
            [self.navigationController pushViewController:verifyOTPVC animated:YES];
        }
            break;
        case 11:
        {
            //            @"FetchUserDataAPI",
            msg = [NSString stringWithFormat:@"%@",self.fetchUserDataAPIResponse];
            [Utils showMsgWithTitle:RESPONSE message:msg];
        }
            break;
        default:
            break;
    }
    
}

- (void)fetchPaymentUserData{
    self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    [[PayUMoneyCoreSDK sharedInstance] fetchPaymentUserDataAPIWithCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (error) {
            [Utils showMsgWithTitle:ERROR message:error.localizedDescription];
        }
        else{
            self.fetchPaymentUserDataAPIResponse = response;
            [Utils showMsgWithTitle:RESPONSE message:[NSString stringWithFormat:@"%@",self.fetchPaymentUserDataAPIResponse]];
        }
    }];
}

-(NSMutableArray *)getAvailableNB{
    NSMutableArray *arrNB;
    NSString *str = [[[[self.addPaymentAPIResponse objectForKey:@"result"] objectForKey:@"paymentOptions"] objectForKey:@"options"] objectForKey:@"nb"];
    if (![str isEqualToString:@"-1"]) {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *ccoptions = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
        arrNB = [NSMutableArray new];
        [ccoptions enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [arrNB addObject:[NSDictionary dictionaryWithObject:obj forKey:key]];
        }];
    }
    return arrNB;
}
@end
