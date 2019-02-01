//
//  PnPWalletPayConstants.h
//  PlugNPlay
//
//  Created by Yadnesh Wankhede on 8/17/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#ifndef PnPWalletPayConstants_h
#define PnPWalletPayConstants_h
typedef enum{
    PNPTapTypeWallet,
    PNPTapTypeCard,
    PNPTapTypeNetBank,
    PNPTapTypeWalletAndCard,
    PNPTapTypeWalletAndNetBank,
    PNPTapTypeNone,
    PNPTapType3PWallet,
    PNPTapTypeEMI,
    PNPTapTypeUPI
} PNPTapType;

#endif /* PnPWalletPayConstants_h */
