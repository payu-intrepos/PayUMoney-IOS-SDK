//
//  PnPCardManagementTableViewCell.h
//  PlugNPlay
//
//  Created by Raji Nair on 29/09/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PnPCardManagementTableViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UIImageView *bankImage;
@property (nonatomic,strong) IBOutlet UILabel *bankName;
@property (nonatomic,strong) IBOutlet UILabel *cardNumber;
@property (nonatomic,strong) IBOutlet UILabel *cardExpiryDate;
@property (nonatomic,strong) IBOutlet UIImageView *cardschemeImage;
@property (nonatomic,strong) IBOutlet UIButton *deleteButton;
@end
