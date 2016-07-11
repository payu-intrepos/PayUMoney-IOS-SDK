//
//  SavedCardTableView.h
//  PayUMoneySDK
//
//  Created by Honey Lakhani on 2/15/16.
//  Copyright © 2016 Kuldeep Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigBO.h"
@protocol SavedCardTableViewDelegate <NSObject>

-(void)savedCardSelectedRow : (NSInteger)index;
//-(void)oneClickCardHash : (NSString *)hash withIndex : (NSInteger)index;
@end



@interface SavedCardTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame  withArr : (NSArray *)arr withBO : (ConfigBO *)bo withUserId : (NSString *)uid withPaymentId : (NSString *)pid;
@property id<SavedCardTableViewDelegate> savedCardTbldelegate;

//@property NSArray *arrSavedCards;
@end
