//
//  CreditCardView.h
//  DemoLayout
//
//  Created by Yadnesh Wankhede on 30/06/16.
//  Copyright © 2016 Yadnesh. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface PnPSavedCardView : UIImageView
//banklogo imageview
//cardschemelogo imageview
//cardnumber uilabel
//expiry date uilabel
//bank name uilabel
//cvvv static xxx
@property(nonatomic ,strong)IBInspectable UIImageView *imgBankLogo;
@property(nonatomic ,strong)IBInspectable UIImageView *imgCardScheme;
@property(nonatomic ,strong)IBInspectable UILabel *lblCardNumber;
@property(nonatomic ,strong)IBInspectable UILabel *lblExpiryDate;
@property(nonatomic ,strong)IBInspectable UILabel *lblBankName;
@property(nonatomic ,strong)IBInspectable UILabel *lblCvv;
@property(nonatomic ,strong)IBInspectable UIButton *btnAddCard;
@property(nonatomic, strong)UILabel *lblNoSavedCardsLabel;
@property(assign, atomic)int parentCardIndex;

-(id)initAddCardWithFrame:(CGRect)frame;
-(void)setSelected;
-(void)setUnselected;
-(void)showCardDetails;
-(void)showAddCard;
@end
