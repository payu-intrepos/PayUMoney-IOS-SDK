//
//  EMISelectorViewController.h
//  PayUMoneyExample
//
//  Created by Rajvinder Singh on 4/13/18.
//  Copyright © 2018 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>

@interface EMISelectorViewController : UIViewController

@property (nonatomic, strong) NSString *bankCode;
@property (nonatomic, strong) PUMPaymentParam *paymentParams;
@end
