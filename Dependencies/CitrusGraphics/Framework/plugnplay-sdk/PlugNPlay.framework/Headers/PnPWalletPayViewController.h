//
//  PnPWalletPayViewController.h
//  CitrusPay
//
//  Created by Yadnesh Wankhede on 27/06/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlugAndPlayPayment.h"
#import "PnPWalletPayView.h"

@class PnPWalletPayView, CTSLoaderButton;

typedef enum  {
    PNPNoView,
    PNPWalletView,
    PNPNetBankingView,
    PNPCardDetailView
} PNPOpenView;

@interface PnPWalletPayViewController : UIViewController<UITabBarControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,iCarouselDataSource, iCarouselDelegate>{
    PnPWalletPayView *payView;
    PNPTapType selectedPayType;
    int selectedCardIndex;
    int selectedBankIndexInCollection;
    PNPOpenView pnpOpenView;
    NSMutableArray *bankCodes;
    UIScrollView *scrollView;
    BOOL isWalletDetailShowing;
   
}
@property(nonatomic ,strong)CTSLoaderButton *btnPayAmount;
@property(strong) NSString *payAmount,*selectedBank;
@property(assign,atomic) BOOL isLoadMoneyView;


@end
