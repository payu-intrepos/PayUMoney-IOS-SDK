//
//  PUMUIConfig.h
//  PayUmoney_SDK
//
//  Created by Umang Arya on 4/25/17.
//  Copyright © 2017 PayUmoney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define defaultTopNavColor @"#A5C339"
#define defaultNavTitleColor @"FFFFFF"
#define defaultButtonColor @"#A5C339"
#define defaultButtonTextColor @"FFFFFF"
#define defaultMerchantName @"PayUmoney"
#define defaultLinkTextColor @"#A5C339"

@interface PUMUIConfig : NSObject


/**
 *   Set TopBarColor.
 *
 *  @param color The TopBarColor.
 */
+(void)setTopBarColor:(UIColor *)color;

/**
 *   Set TopTitleTextColor.
 *
 *  @param color The TopTitleTextColor.
 */
+(void)setTopTitleTextColor:(UIColor *)color;

/**
 *   Set ButtonColor.
 *
 *  @param color The ButtonColor.
 */
+(void)setButtonColor:(UIColor *)color;

/**
 *   Set ButtonTextColor.
 *
 *  @param color The ButtonTextColor.
 */
+(void)setButtonTextColor:(UIColor *)color;

//sets the Merchant display name of the Plug and  Play SDK UI
+(void) setMerchantDisplayName:(NSString *)merchantDisplayName;

//When Sent YES, it disables the exit alert on bank page, app gets back to merchant app immideatly after the back press
+(void)setExitAlertOnBankPageDisabled:(BOOL)isDisabled;

+(UIColor *)getTopBarColor;

+(UIColor *)getTopTitleTextColor;

+(UIColor *)getButtonColor;

+(UIColor *)getButtonTextColor;

+(NSString *)getMerchantDisplayName;

+(BOOL)isExitAlertOnBankPageDisabled;

+ (unsigned int)intFromHexString:(NSString *)hexStr;
@end
