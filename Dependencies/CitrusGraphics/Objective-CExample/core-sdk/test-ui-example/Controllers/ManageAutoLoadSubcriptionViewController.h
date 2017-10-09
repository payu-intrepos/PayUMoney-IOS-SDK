//
//  ManageAutoLoadSubcriptionViewController.h
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 2/5/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ManageAutoLoadSubcriptionViewController : BaseViewController<UITextFieldDelegate>


@property (nonatomic , weak) IBOutlet UITableView *autoLoadSubcriptionTableView;
@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;


@end
