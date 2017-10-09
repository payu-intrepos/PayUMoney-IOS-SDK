//
//  PromoCodeView.h
//  DemoLayout
//
//  Created by Yadnesh Wankhede on 15/06/16.
//  Copyright © 2016 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftRightStrip.h"
#import "iCarousel.h"
#import "PnPWalletPayConstants.h"

@class iCarousel, PnPSavedCardView;

#define CARD_STRIP_LEFT_LBL @"Credit/Debit Card"
#define NETBANK_STRIP_LEFT_LBL @"Net Banking"

@class PnPSavedCardView;
@interface PnPWalletPayView : UIView {
    NSLayoutConstraint *constraintWalletDetailsHeight;
    NSLayoutConstraint *constraintNetBankingDetailsHeight;
    NSLayoutConstraint *constraintCarosouleHeight;
    
    NSLayoutConstraint *constraintWalletAmountHeight;
    NSLayoutConstraint *constraintNetBankingHeight;
    NSLayoutConstraint *constraintCreditCardHeight;


}

@property(nonatomic,strong)UILabel *promoCode;
@property(nonatomic ,strong)LeftRightStrip *stripPayAmount;
@property(nonatomic ,strong)LeftRightStrip *stripWalletBalances;
@property(nonatomic ,strong)LeftRightStrip *Strip_CreditDebit;
@property(nonatomic ,strong)LeftRightStrip *Strip_Netbanking;
@property(nonatomic ,strong)LeftRightStrip *stripMVCCash;
@property(nonatomic ,strong)LeftRightStrip *stripCitrusCash;
@property(nonatomic ,strong)LeftRightStrip *stripPayUsing;
@property(nonatomic ,strong)LeftRightStrip *stripPayUsingNetBanking;

@property(nonatomic, strong)PnPSavedCardView *vAddCard;
@property(nonatomic ,strong)UIButton *btnPayAmount;
@property(nonatomic ,strong)UIButton *btnViewMoreBanks;

@property(nonatomic ,strong)UIView *viewCitrusWalletDetail;
@property(nonatomic ,strong)UIView *viewCreditDetail;
@property(nonatomic ,strong)UIView *viewNetbankingDetail;

@property (nonatomic, strong)  iCarousel *carouselCardScroller;
@property (nonatomic, strong) UIPageControl *carouselPageControl;
@property (nonatomic,strong) NSArray *cards;
@property (nonatomic,strong) NSArray *banks;


@property (strong,atomic) UICollectionView* bankCollectionView;

@property(assign,atomic) BOOL isLoadMoneyView;

@property (nonatomic,strong)  NSLayoutConstraint *constraintCreditDetailsHeight;
@property (nonatomic,strong)  NSLayoutConstraint *constraintPayUsingHeight;
@property (nonatomic,strong)  NSLayoutConstraint *constraintPayUsingNetBankingHeight;


-(void)populateCards:(NSArray *)cardsArg;
-(void)updateWalletBalancesCitrus:(NSDecimalNumber *)citrusBalance merchantBalance:(NSDecimalNumber *)merchantBalance;
-(void)putTickOn:(PNPTapType)payType;
-(void)putTickOff:(PNPTapType)payType;

-(void)showWalletDetails;
-(void)hideWalletDetails;

-(void)showCardDetails;
-(void)hideCardDetails;

-(void)showNetBankingDetails;
-(void)hideNetBankingDetails;
-(id)initLoadMoneyViewWithFrame:(CGRect)frame;

-(void)showPayUsingCard;
-(void)hidePayUsingCard;

-(void)showPayUsingNetBanking;
-(void)hidePayUsingNetBanking;
-(void)checkActivePaymentModes;

@end
