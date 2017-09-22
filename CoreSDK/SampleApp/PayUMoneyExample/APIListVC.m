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

@interface APIListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *arrOfAPI;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation APIListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrOfAPI = [[NSMutableArray alloc]initWithObjects:@"AddPaymentAPI",@"FetchPaymentUserDataAPI",@"IsUserLoggedIn",@"LogOut",@"Login", nil];
    NSDictionary *paymentOptions = [[[_addPaymentAPIResponse valueForKey:@"result"] valueForKey:@"paymentOptions"] valueForKey:@"options"];
    //For CCDC
//    if ([paymentOptions objectForKey:@"cc"] &&
//        [paymentOptions objectForKey:@"dc"] &&
//        ![[paymentOptions objectForKey:@"dc"] isEqualToString:@"-1"] &&
//        ![[paymentOptions objectForKey:@"cc"] isEqualToString:@"-1"]) {
//        [self.arrOfAPI addObject:@"PayViaCCDC"];
//    }
//    else if ([paymentOptions objectForKey:@"cc"] &&
//             ![[paymentOptions objectForKey:@"cc"] isEqualToString:@"-1"]){
//        [self.arrOfAPI addObject:@"PayViaCC"];
//    }
//    else if ([paymentOptions objectForKey:@"dc"] &&
//             ![[paymentOptions objectForKey:@"dc"] isEqualToString:@"-1"]){
//        [self.arrOfAPI addObject:@"PayViaDC"];
//    }
//    else{
//        [self.arrOfAPI addObject:BLANK];
//    }
    [self.arrOfAPI addObject:@"PayViaCCDC"];

    //For NB
    [self.arrOfAPI addObject:@"PayViaNetBanking"];

//    if ([paymentOptions objectForKey:@"nb"] &&
//        ![[paymentOptions objectForKey:@"nb"] isEqualToString:@"-1"]){
//        [self.arrOfAPI addObject:@"PayViaNetBanking"];
//    }
//    else{
//        [self.arrOfAPI addObject:BLANK];
//    }
    //For SC
    [self.arrOfAPI addObject:@"PayViaStoredCard"];
    
    //Wallet
    [self.arrOfAPI addObject:@"PayViaWallet"];
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
            [Utils showMsgWithTitle:@"Response" message:msg];
            break;
        case 1:
            msg = [NSString stringWithFormat:@"%@",self.fetchPaymentUserDataAPIResponse];
            [Utils showMsgWithTitle:@"Response" message:msg];
            break;
        case 2:
            if ([PayUMoneyCoreSDK isUserSignedIn]) {
                msg = @"YES";
            }
            else{
                msg = @"NO";
                
            }
            [Utils showMsgWithTitle:@"Response" message:msg];
            break;
        case 3:
            [PayUMoneyCoreSDK signOut];
            [Utils showMsgWithTitle:@"Response" message:@"Done"];
            self.fetchPaymentUserDataAPIResponse = nil;
            [self.tableView reloadData];
            break;
        case 4:
        {
            [[PayUMoneyCoreSDK sharedInstance] showLoginVCOnViewController:self withCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
                if (error) {
                    [Utils showMsgWithTitle:@"Error" message:error.localizedDescription];
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
                [self.navigationController pushViewController:paymentVC animated:YES];
            }
        }
            break;
        case 7:
        {
            NSArray *arrSavedCard = [[self.fetchPaymentUserDataAPIResponse valueForKey:@"result"] valueForKey:@"savedCards"];
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
            [Utils showMsgWithTitle:@"Error" message:error.localizedDescription];
        }
        else{
            self.fetchPaymentUserDataAPIResponse = response;
            [Utils showMsgWithTitle:@"Response" message:[NSString stringWithFormat:@"%@",self.fetchPaymentUserDataAPIResponse]];
        }
    }];
}

@end
