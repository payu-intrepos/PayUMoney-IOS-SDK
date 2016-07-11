//
//  CouponViewCell.m
//  payuSDK
//
//  Created by Honey Lakhani on 9/2/15.
//  Copyright (c) 2015 Honey Lakhani. All rights reserved.
//

#import "CouponViewCell.h"

@implementation CouponViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (UINib*)nib
{
    // singleton implementation to get a UINib object
    static dispatch_once_t pred = 0;
    __strong static UINib* _sharedNibObject = nil;
    dispatch_once(&pred, ^{
        _sharedNibObject = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    });
    return _sharedNibObject;
}

- (NSString *)reuseIdentifier
{
    NSLog(@"%@",[[self class] reuseIdentifier]);
    return [[self class] reuseIdentifier];
}

+ (NSString *)reuseIdentifier
{
    // return any identifier you like, in this case the class name
    return @"couponCell";
}

- (id)initWithOwner:(id)owner
{
    return [[[[self class] nib] instantiateWithOwner:owner options:nil] objectAtIndex:0];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)radioBtnClicked:(UIButton *)sender {
    if ([UIImagePNGRepresentation([self.radioBtn backgroundImageForState:UIControlStateNormal]) isEqualToData: UIImagePNGRepresentation([UIImage imageNamed:@"selectedradio.png"])]) {
        [self.radioBtn setBackgroundImage:[UIImage imageNamed:@"unselectedradio.png"] forState:UIControlStateNormal];
    }
    else
        [self.radioBtn setBackgroundImage:[UIImage imageNamed:@"selectedradio.png"] forState:UIControlStateNormal];
}
@end
