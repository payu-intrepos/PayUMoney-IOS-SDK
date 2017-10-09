//
//  InitialViewController.h
//  CTS iOS Sdk
//
//  Created by Vikas Singh on 1/13/16.
//  Copyright © 2016 Citrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitialViewController : UIViewController
@property (nonatomic , weak) IBOutlet UIButton *signupOptionOneButton;
@property (nonatomic , weak) IBOutlet UIButton *signupOptionTwoButton;
@property (nonatomic , weak) IBOutlet UIButton *defaultLoginViewButton;
@property (nonatomic , weak) IBOutlet UILabel *versionLabel;
@end
