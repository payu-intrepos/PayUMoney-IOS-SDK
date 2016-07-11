//
//  SavedCardTableViewCell.h
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 2/15/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewCardType;
@property (weak, nonatomic) IBOutlet UILabel *lblCardAccNo;

@property (weak, nonatomic) IBOutlet UILabel *lblCardName;
-(void)configureCellItems : (NSDictionary *)dict;
@end
