//
//  PnPWalletPayViewController.h
//  CitrusPay
//
//  Created by Yadnesh Wankhede on 27/06/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PnPWalletPayView.h"
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>

@class PnPWalletPayView, CTSLoaderButton;

typedef enum  {
    PNPNoView,
    PNPWalletView,
    PNPNetBankingView,
    PNPCardDetailView,
    PNPShowPayAmountDetailView,
    PNPHidePayAmountDetailView
} PNPOpenView;

@interface PnPWalletPayViewController : UIViewController<UITabBarControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,iCarouselDataSource, iCarouselDelegate>{
    PnPWalletPayView *payView;
    
    int selectedCardIndex;
    int selectedBankIndexInCollection;
    PNPOpenView pnpOpenView;
    NSMutableArray *bankCodes;
    UIScrollView *scrollView;
    BOOL isWalletDetailShowing;
   
}
@property(nonatomic ,strong, nullable)CTSLoaderButton *btnPayAmount;
@property(strong, nullable) NSString *payAmount,*selectedBank;
@property(assign, nonatomic) PNPTapType selectedPayType;


#pragma mark- TRANSACTION COMPELTION CALLBACKS
#pragma mark-

-(void)transactionCompletedWithResponse:(NSDictionary* _Nullable)response
                       errorDescription:(NSError* _Nullable)error;

-(void)transactinFailedWithResponse:(NSDictionary* _Nullable)response
                   errorDescription:(NSError* _Nullable)error
                                tag:(SDK_REQUEST_TYPE) tag;

-(void)transactinCanceledByUser;


-(void)transactinExpiredWithResponse: (NSString * _Nullable)msg;

@end
