//
//  ManageCradViewController.m
//  PaymentSdk_GUI
//
//  Created by Vikas Singh on 8/26/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import "ManageCradViewController.h"


@interface ManageCradViewController () {
    NSMutableArray *_savedAccountsArray;
    NSMutableArray *_balancesArray;
}
@end

@implementation ManageCradViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _savedAccountsArray = [[NSMutableArray alloc] init];
    _balancesArray = [[NSMutableArray alloc] init];
    [self fetchConsumerProfile];
    self.saveCardsTableView.allowsMultipleSelectionDuringEditing = NO;

 }

- (void)fetchConsumerProfile {
    
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
            
            
            NSMutableString *toastString = [[NSMutableString alloc] init];
            if([consumerProfile.paymentOptionsList count])
            {
                for (NSDictionary *dict in [consumerProfile.paymentOptionsList mutableCopy]) {
                    if ([[dict valueForKey:@"paymentMode"] isEqualToString:@"MVC"]) {
                        [_balancesArray addObject:dict];
                    }
                    else if ([[dict valueForKey:@"paymentMode"] isEqualToString:@"PREPAID_CARD"]) {
                        [_balancesArray addObject:dict];
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



#pragma mark - TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    //
    if (tableView == self.saveCardsTableView) {
        if(section == 0) {
            return _balancesArray.count;
        }
        else if(section == 1){
            return _savedAccountsArray.count;
        }
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.saveCardsTableView) {
        if(section == 0 ) {
            return @"Balance Accounts details";
        }
        else if(section == 1){
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
    if (tableView == self.saveCardsTableView){
        
        if (indexPath.section == 0) {
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
                
            }
            else if ([balanceDict[@"paymentMode"]  isEqualToString:@"PREPAID_CARD"]) {
                ((UILabel *) [cell.contentView viewWithTag:1001]).text = balanceDict[@"paymentMode"];
                ((UILabel *) [cell.contentView viewWithTag:1002]).text = [NSString stringWithFormat:@"Your Current Balance is Rs : %.02f", [balanceDict[@"maxBalance"] floatValue]];
             }
        }
        else if (indexPath.section == 1){
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



- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //delete saved card
        NSDictionary  *dict = [_savedAccountsArray objectAtIndex:indexPath.row];
        [[CTSProfileLayer fetchSharedProfileLayer] requestDeleteCardWithToken:[dict valueForKey:@"savedCardToken"]
                                                               lastFourDigits:[dict valueForKey:@"cardNumber"]
                                                      andParentViewController:self
                           withCompletionHandler:^(NSError *error) {
                               
                               if (error == nil) {
                                   // Your code to handle success.
                                   if([_savedAccountsArray count]) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [_savedAccountsArray removeObjectAtIndex:indexPath.row];
                                           [self.saveCardsTableView reloadData];
                                       });
                                   }
                                   NSString *cardNum = [dict valueForKey:@"cardNumber"];
                                   
                                   if (cardNum && (cardNum != (id)[NSNull null])) {
                                       [UIUtility toastMessageOnScreen:@"Card deleted successfully."];
                                   } else {
                                       [UIUtility toastMessageOnScreen:@"Preferred Bank deleted successfully"];
                                   }
                               } else {
                                   // Your code to handle error.
                                   [UIUtility toastMessageOnScreen:[error localizedDescription]];
                               }
                           }];
    }
}

@end
