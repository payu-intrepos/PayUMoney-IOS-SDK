//
//  CouponViewCell.h
//  payuSDK
//
//  Created by Honey Lakhani on 9/2/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *couponName;
@property (weak, nonatomic) IBOutlet UILabel *couponDate;
@property (weak, nonatomic) IBOutlet UILabel *validUpto;

@property (weak, nonatomic) IBOutlet UIButton *radioBtn;
- (IBAction)radioBtnClicked:(UIButton *)sender;
+ (NSString *)reuseIdentifier;
- (id)initWithOwner:(id)owner;
@end
