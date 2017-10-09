//
//  ManageCradViewController.h
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 10/5/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import "BaseViewController.h"

@interface ManageCradViewController : BaseViewController

@property (nonatomic , weak) IBOutlet UITableView *saveCardsTableView;
@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;

@end
