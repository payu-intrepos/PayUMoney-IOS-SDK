//
//  PUMBaseVC.h
//  PayUmoneyiOS_SDK
//
//  Created by Imran Khan on 6/17/16.
//  Copyright © 2016 PayUmoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PUMConstants.h"

@interface PUMBaseVC : UIViewController<UIAlertViewDelegate> {
    BOOL  isUserLoggedIn;
}

@property CGFloat deviceHeight,deviceWidth;

- (void)setUpLoginButton;
- (void)setUpImageBackButton;
- (void) addSepratorLine:(CGFloat) x y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height view:(UIView *) rootView;
- (UIView *) addSepratorLineOne:(CGFloat) x y:(CGFloat) y width:(CGFloat) width height:(CGFloat) height view:(UIView *) rootView;


- (void)setTextTitleForNav:(NSString*) title;


- (void)payBtnStatus:(UIButton *) payBtn isEnabled:(BOOL ) isEnabled;

- (void)fetchResponsefrom : (NSString *)strURL isPost : (BOOL)type body : (NSString *)strBody  tag : (SDK_REQUEST_TYPE)tag isAccessTokenRequired : (BOOL)tokenRequired;

- (void)processUserLogin:(NSString *)password;
- (void) requestRegisterAndLoginWithPassword: (NSString *)strOTP;
- (void) sendUserPaymentOTP;
- (void) enableOneClickTransaction:(NSString *) enable_status;


- (void)addUserOptionOnNavBarRightBarButton;

-(void) reSendUserPaymentOTP:(NSString *) userEmailID userMobileNum:(NSString*) userMobileNum;
- (NSString*) encryptCardNumberForEdgeRewards:(NSString*) mCardNumberString;
- (NSString*) NSStringWithoutSpace:(NSString*) string;
-(void) onUserOptionClick;

-(void)parseResponse:(id)object tag:(SDK_REQUEST_TYPE)tag;

@end
