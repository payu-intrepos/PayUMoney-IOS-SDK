//
//  PnPAddCardView.h
//  CitrusPay
//
//  Created by Yadnesh Wankhede on 07/07/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTSLoaderButton.h"
#import "PnPErrorTextField.h"

@interface PnPAddCardView : UIView
@property (strong, nonatomic) IBOutlet UIView *vCardBg;
@property (strong, nonatomic) IBOutlet UIImageView *imgCardScheme;
@property (strong, nonatomic) IBOutlet PnPErrorTextField *tfCvv;
@property (strong, nonatomic) IBOutlet PnPErrorTextField *tfExpiryDate;
@property (strong, nonatomic) IBOutlet PnPErrorTextField *tfCardNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblBankName;
@property (strong, nonatomic) IBOutlet UIImageView *imgIssuingBank;
@property (strong, nonatomic) IBOutlet CTSLoaderButton *btnPayNow;
@property (strong, nonatomic) NSString *strCardSheme;
@property (strong, nonatomic) NSString *strBankCode;

-(void)setIssuingBankImage:(UIImage*)image withBankCode:(NSString*)bankCode;
-(void)setCardSchemeImage:(UIImage*)image withCardScheme:(NSString*)cardSheme;
-(void)setCardSchemeImageViewWithCardScheme:(NSString*)cardSheme;
-(void)setIssuingBankImageViewWithBankCode:(NSString*)bankCode;
@end
