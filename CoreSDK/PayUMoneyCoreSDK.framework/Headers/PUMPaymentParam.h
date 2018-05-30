//
//  PUMPaymentParam.h
//  PayUmoney_SDK
//
//  Created by Umang Arya on 5/8/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUMSaveCardBO.h"
#import "PUMNetBankingBO.h"
#import "PUMCCDC.h"
#import "PUMEMI.h"

typedef NS_ENUM(NSInteger, PUMPaymentMode) {
    PUMPaymentModeNone = 0,
    PUMPaymentModeCCDC,
    PUMPaymentModeNetBanking,
    PUMPaymentModeStoredCard,
    PUMPaymentMode3PWallet,
    PUMPaymentModeEMI
};
@interface PUMPaymentParam : NSObject

// SavedCard, NetBanking CCDC model objects
@property (strong, nonatomic) PUMSaveCardBO * objSavedCard;
@property (strong, nonatomic) PUMNetBankingBO * objNetBanking;
@property (strong, nonatomic) PUMCCDC * objCCDC;
@property (strong, nonatomic) PUMNetBankingBO * obj3PWallet;
@property (strong, nonatomic) PUMEMI * objEMI;

/**
 Set payment mode
 */
@property (nonatomic,assign) PUMPaymentMode paymentMode;


@property BOOL useWallet;

@end
