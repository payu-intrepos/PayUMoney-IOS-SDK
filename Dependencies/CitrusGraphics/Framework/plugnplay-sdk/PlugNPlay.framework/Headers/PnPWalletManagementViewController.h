//
//  PnPWalletManagementViewController.h
//  CitrusPay
//
//  Created by Raji Nair on 27/07/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PnPWalletPayView.h"
#import "PnPWalletManagementView.h"

@interface PnPWalletManagementViewController : UIViewController<UITabBarControllerDelegate,iCarouselDataSource, iCarouselDelegate>{
    PnPWalletManagementView *walletManageView;
    

}
@property(strong) NSString *payAmount;

@end
