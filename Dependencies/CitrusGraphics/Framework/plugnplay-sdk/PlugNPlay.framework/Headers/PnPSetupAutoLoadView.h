//
//  PnPSetupAutoLoadView.h
//  CitrusPay
//
//  Created by Raji Nair on 02/08/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PnPSetupAutoLoadView : UIView <UITextFieldDelegate>{
    NSLayoutConstraint *constraintCenterViewY;
    NSLayoutConstraint *constraintProceedButton;
    NSLayoutConstraint *constraintHeaderTop;
}

@property(nonatomic, strong)UIImageView *bankLogo;
@property(nonatomic, strong)UILabel *bankName;
@property(nonatomic, strong)UILabel *cardNumber;
@property(nonatomic, strong)UILabel *cardExpiryDate;
@property (nonatomic, strong)UIImageView *schemeLogo;
@property(nonatomic, strong)UILabel *cvvHeader;
@property(nonatomic, strong)NSMutableArray *cvvFields;
@property(nonatomic, strong)UIButton *proceedButton;
@property(nonatomic,strong)UIView *centerV,*headerV;
@property(nonatomic, strong)UIImageView *cardBackgroundImage;

- (void)viewUp;
- (void)viewDown;
-(NSString*)extractCvv;
@end
