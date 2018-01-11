//
//  PaymentVC.h
//  PayUMoneyExample
//
//  Created by Umang Arya on 7/3/17.
//  Copyright © 2017 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>

@interface PaymentVC : UIViewController

@property (nonatomic,assign) PUMPaymentMode paymentMode;
@property (nonatomic, strong) NSArray *arrStoredCard;
@property (nonatomic, strong) NSArray *arrNetBank;

@end
