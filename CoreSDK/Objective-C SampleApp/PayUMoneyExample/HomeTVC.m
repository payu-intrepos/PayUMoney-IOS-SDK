//
//  HomeTVC.m
//  PayUMoneyExample
//
//  Created by Umang Arya on 6/28/17.
//  Copyright © 2017 PayU. All rights reserved.
//

#import "HomeTVC.h"
#import "HomeTableCell.h"
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>
#import "Utils.h"
#import "iOSDefaultActivityIndicator.h"
#import "APIListVC.h"
#import "Constants.h"

@interface HomeTVC () <UITextFieldDelegate>
{
    int envIndex;
}
@property (strong, nonatomic) NSArray *arrPaymentParamKey, *arrMerchantKey, *arrMerchantID, *arrMerchantSalt, *arrEnvironment;
@property (strong, nonatomic) NSMutableArray *arrPaymentParamValue;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;

@end

@implementation HomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrMerchantKey = [NSArray arrayWithObjects:@"mdyCKV",@"Aqryi8",@"", nil];
    self.arrMerchantID = [NSArray arrayWithObjects:@"4914106",@"397202",@"", nil];
    self.arrMerchantSalt = [NSArray arrayWithObjects:@"Je7q3652",@"ZRC9Xgru",@"", nil];
    self.arrEnvironment = [NSArray arrayWithObjects:@"0",@"4",@"", nil];
    
    id env = [[NSUserDefaults standardUserDefaults] valueForKey:@"PUMENVIRONMENT"];
    if (env) {
        envIndex = [env intValue];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"PUMENVIRONMENT"];
        envIndex = 0;
    }
    
    self.arrPaymentParamKey = [NSArray arrayWithObjects:@"key",@"merchantid",@"txnID",@"amount",@"phone",@"email",@"firstname",@"surl",@"furl",@"productInfo",@"udf1",@"udf2",@"udf3",@"udf4",@"udf5",@"udf6",@"udf7",@"udf8",@"udf9",@"udf10",@"Environment", nil];
    self.arrPaymentParamValue = [NSMutableArray arrayWithObjects:[self.arrMerchantKey objectAtIndex:envIndex],[self.arrMerchantID objectAtIndex:envIndex],[Utils getTxnID],@"11",@"9717410858",@"umangarya336@gmail.com",@"firstname",@"http://www.google.com",@"http://www.google.com",@"iPhone7",@"udf1",@"udf2",@"udf3",@"udf4",@"udf5",@"udf6",@"udf7",@"udf8",@"udf9",@"udf10",[self.arrEnvironment objectAtIndex:envIndex], nil];
    
    self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentCompletion:) name:PaymentCompletion object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dismissKeyboard{
    [self.view endEditing:NO];
}
- (IBAction)btnTappedChangeEnv:(id)sender {
    if (envIndex) {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"PUMENVIRONMENT"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"PUMENVIRONMENT"];
    }
    
    envIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"PUMENVIRONMENT"] intValue];
    
    HomeTableCell *cell = (HomeTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.tfValue.text = [self.arrMerchantKey objectAtIndex:envIndex];
    [self.arrPaymentParamValue replaceObjectAtIndex:0 withObject:[self.arrMerchantKey objectAtIndex:envIndex]];
    
    cell = (HomeTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.tfValue.text = [self.arrMerchantID objectAtIndex:envIndex];
    [self.arrPaymentParamValue replaceObjectAtIndex:1 withObject:[self.arrMerchantID objectAtIndex:envIndex]];

    cell = (HomeTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:20 inSection:0]];
    cell.tfValue.text = [self.arrEnvironment objectAtIndex:envIndex];
    [self.arrPaymentParamValue replaceObjectAtIndex:20 withObject:[self.arrEnvironment objectAtIndex:envIndex]];
    
    [PayUMoneyCoreSDK signOut];
//    [[PayUMoneyCoreSDK sharedInstance] signOut];
}

-(void)paymentCompletion:(NSNotification *) notification{
    [self.navigationController popToViewController:self animated:YES];
    NSDictionary *notiDict = notification.object;
    if ([[notiDict valueForKey:RESPONSE] allKeys].count > 0) {
        [Utils showMsgWithTitle:RESPONSE message:[NSString stringWithFormat:@"%@",[notiDict valueForKey:RESPONSE]]];
    }
    else if ([notiDict valueForKey:ERROR]){
        NSError *err = [notiDict valueForKey:ERROR];
        [Utils showMsgWithTitle:ERROR message:[NSString stringWithFormat:@"%@",err.localizedDescription]];
    }
    else{
        [Utils showMsgWithTitle:ERROR message:@"Report this error to Umang"];
    }
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
    return self.arrPaymentParamKey.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableCell *cell = (HomeTableCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.lblKey.text = [self.arrPaymentParamKey objectAtIndex:indexPath.row];
    cell.tfValue.text = [self.arrPaymentParamValue objectAtIndex:indexPath.row];
    cell.tfValue.tag = indexPath.row;
    // Configure the cell...
    
    return cell;
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.arrPaymentParamValue replaceObjectAtIndex:textField.tag withObject:textField.text];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnTappedNext:(id)sender {
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    
    [self.view endEditing:YES];
    
    PUMTxnParam *txnParam = [[PUMTxnParam alloc] init];
    txnParam.key = [self.arrPaymentParamValue objectAtIndex:0];
    txnParam.merchantid = [self.arrPaymentParamValue objectAtIndex:1];
    txnParam.txnID = [self.arrPaymentParamValue objectAtIndex:2];
    txnParam.amount = [self.arrPaymentParamValue objectAtIndex:3];
    txnParam.phone = [self.arrPaymentParamValue objectAtIndex:4];
    txnParam.email = [self.arrPaymentParamValue objectAtIndex:5];
    txnParam.firstname = [self.arrPaymentParamValue objectAtIndex:6];
    txnParam.surl = [self.arrPaymentParamValue objectAtIndex:7];
    txnParam.furl = [self.arrPaymentParamValue objectAtIndex:8];
    txnParam.productInfo = [self.arrPaymentParamValue objectAtIndex:9];
    txnParam.udf1 = [self.arrPaymentParamValue objectAtIndex:10];
    txnParam.udf2 = [self.arrPaymentParamValue objectAtIndex:11];
    txnParam.udf3 = [self.arrPaymentParamValue objectAtIndex:12];
    txnParam.udf4 = [self.arrPaymentParamValue objectAtIndex:13];
    txnParam.udf5 = [self.arrPaymentParamValue objectAtIndex:14];
    txnParam.udf6 = [self.arrPaymentParamValue objectAtIndex:15];
    txnParam.udf7 = [self.arrPaymentParamValue objectAtIndex:16];
    txnParam.udf8 = [self.arrPaymentParamValue objectAtIndex:17];
    txnParam.udf9 = [self.arrPaymentParamValue objectAtIndex:18];
    txnParam.udf10 = [self.arrPaymentParamValue objectAtIndex:19];
    txnParam.environment = [[self.arrPaymentParamValue objectAtIndex:20] integerValue];
    txnParam.hashValue = [Utils getHashForTxnParams:txnParam salt:[self.arrMerchantSalt objectAtIndex:envIndex]];
    
    NSError *err;
    
    [PayUMoneyCoreSDK initWithTxnParam:txnParam error:&err];
    if (err) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        [Utils showMsgWithTitle:@"Error" message:err.localizedDescription];
    }
    else{
        [[PayUMoneyCoreSDK sharedInstance] addPaymentAPIWithCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
            if (error) {
                [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                [Utils showMsgWithTitle:@"Error" message:error.localizedDescription];
            }
            else{
                APIListVC *APIVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([APIListVC class])];
                APIVC.addPaymentAPIResponse = response;
                if ([PayUMoneyCoreSDK isUserSignedIn]) {
                    [[PayUMoneyCoreSDK sharedInstance] fetchPaymentUserDataAPIWithCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
                        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                        if (error) {
                            [Utils showMsgWithTitle:@"Error" message:error.localizedDescription];
                        }
                        else{
                            APIVC.fetchPaymentUserDataAPIResponse = response;
                            [self.navigationController pushViewController:APIVC animated:YES];
                        }
                    }];
                }
                else{
                    if ([PUMHelperClass isNitroFlowEnabledForMerchant]) {
                        [[PayUMoneyCoreSDK sharedInstance] fetchUserDataAPIWithCompletionBlock:^(NSDictionary *response, NSError *error, id extraParam) {
                            [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                            if (error) {
                                [Utils showMsgWithTitle:@"Error" message:error.localizedDescription];
                            }
                            else{
                                APIVC.fetchUserDataAPIResponse = response;
                                [self.navigationController pushViewController:APIVC animated:YES];
                            }
                        }];
                    }
                    else{
                        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                        [self.navigationController pushViewController:APIVC animated:YES];
                    }
                }
            }
        }];
    }
}

@end
