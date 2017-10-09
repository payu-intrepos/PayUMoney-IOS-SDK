//
//  PnPWalletManagementView.h
//  CitrusPay
//
//  Created by Raji Nair on 27/07/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftRightStrip.h"
#import "iCarousel.h"
#import "PnPSavedCardView.h"


@protocol PnPWalletManagementViewDelegate <NSObject>

- (void)manageCardsButtonClicked;
- (void)setUpAutoLoadViewClicked;
- (void)addMoneyButtonClicked;
- (void)changeButtonClicked;

@end
@interface PnPWalletManagementView : UIView<iCarouselDataSource, iCarouselDelegate, UICollectionViewDataSource, UICollectionViewDelegate>{
    NSLayoutConstraint *constraintWalletDetailsHeight;
    NSLayoutConstraint *constraintNetBankingDetailsHeight;
    NSLayoutConstraint *constraintAutoLoadViewHeight;
}
@property(nonatomic ,strong)LeftRightStrip *stripPayAmount;
@property(nonatomic ,strong)UIView *stripWalletBalances;
@property(nonatomic ,strong)UIView *stripAutoLoad;
@property(nonatomic ,strong)LeftRightStrip *Strip_CreditDebit;
@property(nonatomic ,strong)LeftRightStrip *Strip_Netbanking;
@property(nonatomic ,strong)LeftRightStrip *Strip_WalletDetail;
@property(nonatomic ,strong)LeftRightStrip *Strip_WalletDetailCash;
@property(nonatomic, strong)LeftRightStrip *Strip_WithdrawMoney;

@property(nonatomic, strong)PnPSavedCardView *vAddCard;
@property(nonatomic ,strong)UIButton *btnAddMoney;
@property(nonatomic ,strong)UIButton *btnManageCards;
@property(nonatomic ,strong)UIButton *btnWithdrawMoney;
@property(nonatomic ,strong)UIButton *btnChange;
@property(nonatomic, strong)UIImageView *bankLogo;
@property(nonatomic, strong)UIView *backgroundView;
@property(nonatomic, strong)UILabel *bankName;
@property(nonatomic, strong)UILabel *accountNumber;
@property(nonatomic, strong)UILabel *ownerName;
@property(nonatomic, strong)UIButton *change;
@property(nonatomic, strong)UIButton *addLinkedAccount;
@property (nonatomic, assign)id <PnPWalletManagementViewDelegate> delegate;




@property(nonatomic ,strong)UIView *viewCitrusWalletDetail;
@property(nonatomic, strong)UIView *viewCreditDetail;
@property(nonatomic, strong)UIView *viewNetbankingDetail;
@property(nonatomic, strong)UIView *viewWithdrawMoneyDetail;
@property(nonatomic ,strong)UIView *setUpAutoLoadView;

@property (nonatomic, strong)  iCarousel *carouselCardScroller;
@property (nonatomic, strong) UICollectionView *bankList;
@property (nonatomic, strong) UIPageControl *carouselPageControl;
@property (nonatomic,strong) NSArray *cards;
@property (nonatomic, strong)NSArray *banks;
@property (assign) BOOL isAutoLoadSubscribed;

@property (nonatomic,strong)  NSLayoutConstraint *constraintCreditDetailsHeight;
-(void)updateWalletBalancesCitrus:(NSDecimalNumber *)citrusBalance merchantBalance:(NSDecimalNumber *)merchantBalance;

- (void)updateAutoLoadBalanceSubscription:(NSString*)autoLoadAmount thresholdAmount:(NSString*)thresholdAmount;
@end
