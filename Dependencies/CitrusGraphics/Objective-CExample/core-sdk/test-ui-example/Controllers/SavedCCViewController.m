//
//  SavedCCViewController.m
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 2/12/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import "SavedCCViewController.h"
#import "AutoloadViewController.h"

@interface SavedCCViewController (){
    
    NSArray *saveCardsArray;
    BOOL isAlreadyActive;
    NSInteger selectedRow;
    NSString *cvvString;

}

@end

@implementation SavedCCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    saveCardsArray = [[NSMutableArray alloc]init];
    [self getSaveCards];
    [self getActiveSubs];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (void)getSaveCards{
    
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
            NSArray  *creditCardArray = [consumerProfile getSavedCCPaymentOptions];
            NSMutableString *toastString = [[NSMutableString alloc] init];
            if([creditCardArray count])
            {
                saveCardsArray = creditCardArray;
                // sleep(3);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.saveCardsTableView reloadData];
                });
            }
            else{
                toastString =(NSMutableString *) @"No saved credit cards, please save credit card first";
                [UIUtility toastMessageOnScreen:toastString];
            }
        }}];
}


-(void)getActiveSubs{
    
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
                isAlreadyActive = FALSE;
            }
            else{
                isAlreadyActive = TRUE;
            }
        }
    }];
}

#pragma mark - TableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return saveCardsArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    static NSString *simpleTableIdentifier = @"saveCardIdentifier";
    
    cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    [cell.contentView viewWithTag:1000].layer.cornerRadius = 5;
    NSDictionary *tempDict = [saveCardsArray objectAtIndex:indexPath.row];
    ((UILabel *) [cell.contentView viewWithTag:1001]).text = [tempDict valueForKey:@"name"];
    ((UILabel *) [cell.contentView viewWithTag:1002]).text = [tempDict valueForKey:@"cardNumber"];
    ((UILabel *) [cell.contentView viewWithTag:1003]).text = [tempDict valueForKey:@"owner"];
    NSMutableString *string = [[tempDict valueForKey:@"cardExpiryDate"] mutableCopy];
    [string insertString:@"/" atIndex:2];
    ((UILabel *) [cell.contentView viewWithTag:1004]).text = string;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
      //  ((UIImageView *) [cell.contentView viewWithTag:1005]).image = [CTSUtility fetchSchemeImageBySchemeType:[tempDict valueForKey:@"cardScheme"] forParentView:self.view];
        
        [((UIImageView *) [cell.contentView viewWithTag:1005]) setSystemActivity];
        [((UIImageView *) [cell.contentView viewWithTag:1005]) loadCitrusCardWithCardScheme:[tempDict valueForKey:@"cardScheme"]];
        
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedRow = indexPath.row;
    if (tableView == self.saveCardsTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (!isAlreadyActive) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *cvvAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter cvv." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
                cvvAlert.tag = 10001;
                cvvAlert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                UITextField * cvvTextField = [cvvAlert textFieldAtIndex:0];
                cvvTextField.keyboardType = UIKeyboardTypeNumberPad;
                cvvTextField.placeholder = @"cvv";
                [cvvAlert show];
            });
        }
        else{
            [UIUtility toastMessageOnScreen:@"Subscription for Autoload is already active"];
        
        }
        
        
    }
}



#pragma mark - AlertView Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.view endEditing:YES];
    
    if (alertView.tag ==10001){
        if (buttonIndex==1) {
            cvvString = [alertView textFieldAtIndex:0].text;
            [self performSegueWithIdentifier:@"AutoloadViewIdentifier" sender:self];
            
        }
    }
}

#pragma mark - StoryBoard Delegate Methods
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"AutoloadViewIdentifier"]) {
        
        AutoloadViewController *viewController = (AutoloadViewController *)segue.destinationViewController;
        
//        NSDictionary *tempDict = [saveCardsArray objectAtIndex:selectedRow];
//        
//        CTSPaymentDetailUpdate *cardInfo = [[CTSPaymentDetailUpdate alloc] init];
//        CTSElectronicCardUpdate *creditCard = [[CTSElectronicCardUpdate alloc] initCreditCard];
//        
//        creditCard.token = [tempDict valueForKey:@"token"];
//        
//        NSMutableString *expiryDate = [[tempDict valueForKey:@"expiryDate"] mutableCopy];
//        [expiryDate insertString:@"/" atIndex:2];
//        creditCard.expiryDate = expiryDate;
//        
//        creditCard.scheme =  [tempDict valueForKey:@"scheme"];
//        creditCard.ownerName = [tempDict valueForKey:@"owner"];
//        creditCard.cvv = cvvString;
//        
//        [cardInfo addCard:creditCard];
        
        
        JSONModelError* jsonError;
        CTSConsumerProfileDetails* consumerProfileDetails = [[CTSConsumerProfileDetails alloc]
                                                             initWithDictionary:[saveCardsArray objectAtIndex:selectedRow]
                                                             error:&jsonError];


        CTSPaymentOptions *creditCardInfo = [CTSPaymentOptions creditCardTokenized:consumerProfileDetails];
      creditCardInfo.cvv = cvvString;
        viewController.cardInfo = creditCardInfo;
        
    }
    
}

@end
