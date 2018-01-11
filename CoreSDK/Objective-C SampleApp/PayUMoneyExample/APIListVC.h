//
//  APIListVC.h
//  PayUMoneyExample
//
//  Created by Umang Arya on 6/28/17.
//  Copyright © 2017 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIListVC : UIViewController

@property (nonatomic, strong) NSDictionary *addPaymentAPIResponse;
@property (nonatomic, strong) NSDictionary *fetchPaymentUserDataAPIResponse;
@property (nonatomic, strong) NSDictionary *fetchUserDataAPIResponse;

@end
