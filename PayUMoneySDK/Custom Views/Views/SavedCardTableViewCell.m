//
//  SavedCardTableViewCell.m
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 2/15/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import "SavedCardTableViewCell.h"
#import "PayuMoneySDKSetUpCardDetails.h"

@implementation SavedCardTableViewCell

//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
-(void)configureCellItems : (NSDictionary *)dict
{
    self.lblCardName.text  = [dict valueForKey:@"cardName"];
    self.lblCardAccNo.text = [dict valueForKey:@"ccnum"];
    self.imgViewCardType.image = [PayuMoneySDKSetUpCardDetails getCardDrawable:[dict valueForKey:@"ccnum"]];
}
@end
