//
//  PayuSDKTextField.m
//  PayuMoney
//
//  Created by Honey Lakhani on 12/4/15.
//  Copyright © 2015 PayuMoney. All rights reserved.
//

#import "PayuSDKTextField.h"

@implementation PayuSDKTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:))
        return NO;
    if (action == @selector(select:))
        return NO;
    if (action == @selector(selectAll:))
        return NO;
    return NO;
    return [super canPerformAction:action withSender:sender];

}

@end
