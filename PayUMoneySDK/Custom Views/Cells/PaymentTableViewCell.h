//
//  PaymentTableViewCell.h
//  PayU SDK
//
//  Created by Honey Lakhani on 9/29/15.
//  Copyright (c) 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property (weak, nonatomic) IBOutlet UILabel *paymentNameLbl;
- (IBAction)cellBtnClicked:(UIButton *)sender;

@end
