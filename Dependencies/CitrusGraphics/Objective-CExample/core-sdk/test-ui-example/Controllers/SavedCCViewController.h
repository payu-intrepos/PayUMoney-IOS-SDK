//
//  SavedCCViewController.h
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 2/12/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import "BaseViewController.h"

@interface SavedCCViewController : BaseViewController

@property (nonatomic , weak) IBOutlet UITableView *saveCardsTableView;
@property (nonatomic , weak) IBOutlet UIActivityIndicatorView *indicatorView;

@end
