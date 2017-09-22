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
#import "CTSLoaderButton.h"

@class iCarousel, PnPSavedCardView;

#define CARD_STRIP_LEFT_LBL @"Credit/Debit Card"
#define CREDIT_STRIP_LEFT_LBL @"Credit Card"
#define DEBIT_STRIP_LEFT_LBL @"Debit Card"
#define NETBANK_STRIP_LEFT_LBL @"Net Banking"
#define PAYUMONEY_CASH_STR @"PayUMoney Cash (₹%@)"
#define CITRUS_CASH_STR @"Citrus Cash (₹%@)"
#define MERCHANT_CASH_STR @"%@ Wallet (₹%d)"
#define WALLET_DETAIL_LABLE_STR @"PayuMoney Wallet"
#define ERRORSHOW_STRIP_LEFT_LBL @"We're unable to connect to this bank.\nPlease select a different bank"

@class PnPSavedCardView;
@interface PnPWalletPayView : UIView {
    NSLayoutConstraint *constraintPayAmountDetailsOuterViewHeight;
    NSLayoutConstraint *constraintPayAmountDetailsHeight;
    NSLayoutConstraint *constraintWalletDetailsHeight;
    NSLayoutConstraint *constraintNetBankingDetailsHeight;
    NSLayoutConstraint *constraintCarosouleHeight;
    
    NSLayoutConstraint *constraintWalletAmountHeight;
    NSLayoutConstraint *constraintNetBankingHeight;
    NSLayoutConstraint *constraintCreditCardHeight;
    NSLayoutConstraint *constraintErrorMsgHeight;

}

@property(nonatomic,strong)UILabel *promoCode;
@property(nonatomic ,strong)LeftRightStrip *stripPayAmount;

@property(nonatomic ,strong)LeftRightStrip *stripPayAmountSubtotal;
@property(nonatomic ,strong)LeftRightStrip *stripPayAmountConvFee;
@property(nonatomic ,strong)LeftRightStrip *stripPayAmountTotal;
@property(nonatomic ,strong)LeftRightStrip *stripPayAmountHideDetails;

@property(nonatomic ,strong)LeftRightStrip *stripWalletBalances;
@property(nonatomic ,strong)LeftRightStrip *Strip_CreditDebit;
@property(nonatomic ,strong)LeftRightStrip *Strip_Netbanking;
@property(nonatomic ,strong)LeftRightStrip *Strip_ErrorShow;
@property(nonatomic ,strong)LeftRightStrip *stripMVCCash;
//@property(nonatomic ,strong)LeftRightStrip *stripCitrusCash;
@property(nonatomic ,strong)LeftRightStrip *stripPayUMoneyCash;
@property(nonatomic ,strong)LeftRightStrip *stripPayUsing;
@property(nonatomic ,strong)LeftRightStrip *stripPayUsingNetBanking;
@property(nonatomic ,strong)CTSLoaderButton *loginButton;
@property(nonatomic, strong)PnPSavedCardView *vAddCard;
@property(nonatomic ,strong)UIButton *btnPayAmount;
@property(nonatomic ,strong)UIButton *btnViewMoreBanks;

@property(nonatomic ,strong)UIView *viewPayAmount;
@property(nonatomic ,strong)UIView *viewPayAmountDetail;
@property(nonatomic ,strong)UIView *viewCitrusWalletDetail;
@property(nonatomic ,strong)UIView *viewCreditDetail;
@property(nonatomic ,strong)UIView *viewNetbankingDetail;

@property (nonatomic, strong)  iCarousel *carouselCardScroller;
@property (nonatomic, strong) UIPageControl *carouselPageControl;
@property (nonatomic,strong) NSArray *cards;
@property (nonatomic,strong) NSArray *banks;


@property (strong,atomic) UICollectionView* bankCollectionView;

@property(assign,atomic) BOOL isLoadMoneyView;

@property (assign, nonatomic) NSDecimalNumber* totalAmountPayable;
@property (assign, nonatomic) NSDecimalNumber* moneyWalletBalance;


@property (nonatomic,strong)  NSLayoutConstraint *constraintCreditDetailsHeight;
@property (nonatomic,strong)  NSLayoutConstraint *constraintPayUsingHeight;
@property (nonatomic,strong)  NSLayoutConstraint *constraintPayUsingNetBankingHeight;

-(void)populateCards:(NSArray *)cardsArg;
-(void)updateWalletBalancesCitrus:(NSDecimalNumber *)citrusBalance merchantBalance:(NSDecimalNumber *)merchantBalance;

-(void)putTickOn:(PNPTapType)payType;
-(void)putTickOff:(PNPTapType)payType;

-(void)showWalletDetails;
-(void)hideWalletDetails;

-(void)showPayAmountDetails;
-(void)hidePayAmountDetails;

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

-(void)showErrorMessage;
-(void)hideErrorMessage;
@end
