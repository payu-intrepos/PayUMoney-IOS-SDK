//
//  PnPToolbar.h
//  PlugNPlay
//
//  Created by Raji Nair on 31/08/16.
//  Copyright © 2016 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PnPToolbar;
@protocol PnPToolbarDelegate <NSObject>

@optional
- (void)PnPToolbarNextButtonClicked:(PnPToolbar *)PnPToolbar;

@optional
- (void)PnPToolbarpreviousButtonClicked:(PnPToolbar *)PnPToolbar;

@optional
- (void)pnpToolbarDoneButtonClicked:(PnPToolbar *)pnpToolbar;

@end

@interface PnPToolbar : UIView
- (instancetype)initWithFrame:(CGRect)frame withpreviousButtonTitle:(NSString *)cancel withNextButtonTitle:(NSString *)next;
- (instancetype)initWithFrame:(CGRect)frame  withNextButtonTitle:(NSString *)next;
- (instancetype)initWithFrame:(CGRect)frame withDoneButtonTitle:(NSString *)done;

@property (weak, nonatomic)id<PnPToolbarDelegate> delegate;

@property (strong, nonatomic) UIBarButtonItem *nextButton;
@property (strong, nonatomic) UIBarButtonItem *previousButton;
@property (strong, nonatomic) UIBarButtonItem *doneButton;
-(void) changeCancelToDone;
- (void)changeNextToActionButtonWithTitle:(NSString*)title;
- (void)changeDoneToActionButtonWithTitle:(NSString*)title;
@end
