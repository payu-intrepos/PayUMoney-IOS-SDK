//
//  EMISelectorViewController.m
//  PayUMoneyExample
//
//  Created by Rajvinder Singh on 4/13/18.
//  Copyright © 2018 PayU. All rights reserved.
//

#import "EMISelectorViewController.h"
#import "Utils.h"
#import "Constants.h"

@interface EMISelectorViewController () {
    NSArray *emiTypes;
    NSDictionary *emiTenures;
    __weak IBOutlet UITableView *emiTenuresTableView;
}

@end

@implementation EMISelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchEMITenures];
    
    [self setTitle:_bankCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods -

- (void)fetchEMITenures {
    __weak EMISelectorViewController *weakSelf = self;
    [[PayUMoneyCoreSDK sharedInstance] getEMIOptionsForBank:_bankCode completion:^(NSDictionary *response, NSError *error, id extraParam) {
        [weakSelf updateEMITenures:response];
    }];
}

- (void)updateEMITenures:(NSDictionary *)response {
    emiTenures = [[response allValues] firstObject];
    emiTypes = [emiTenures allKeys];
    [emiTenuresTableView reloadData];
}

-(void)proceedToPay{
    [[PayUMoneyCoreSDK sharedInstance] setOrderDetails:[self testOrderDetailsArray]];
    [[PayUMoneyCoreSDK sharedInstance] showWebViewWithPaymentParam:_paymentParams
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

- (NSArray *)testOrderDetailsArray {
    return @[@{@"From":@"Delhi"}, @{@"To":@"Pune"}];
}

#pragma mark - UITableView DataSource & Delegate -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return emiTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell.textLabel setText:[[emiTenures valueForKey:[emiTypes objectAtIndex:indexPath.row]] valueForKey:@"title"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    _paymentParams.objEMI.emiType = [emiTypes objectAtIndex:indexPath.row];
    _paymentParams.objEMI.bankCode = _bankCode;
    [self proceedToPay];
}

@end
