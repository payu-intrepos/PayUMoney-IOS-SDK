//
//  CitrusLoginViewController.h
//  CitrusPay
//
//  Created by Yadnesh Wankhede on 24/05/16.
//  Copyright © 2016 CitrusPay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CTSMasterLinkRes;
#define KUserClickedDone @"CitrusUserClickedDone"
@interface CitrusLoginViewController : UIViewController<UITextFieldDelegate>
@property CTSMasterLinkRes *linkResponse;
- (void)reloadCitrusLoginView;
- (void)resetCitrusLoginView;
@end
