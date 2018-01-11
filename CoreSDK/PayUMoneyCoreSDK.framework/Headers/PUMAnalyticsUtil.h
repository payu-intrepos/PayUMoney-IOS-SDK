//
//  PUMAnalyticsUtil.h
//  PlugNPlayExample
//
//  Created by Umang Arya on 4/17/17.
//  Copyright © 2017 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUMAnalyticsUtil : NSObject

+(NSString *)getDeviceID;

+(NSString *)getUUID;

+(NSString *)getDeviceUserAgent;

+(NSDictionary *)getLatitudeAndLongitude;

+(NSString *)getAppID;

+(NSString *)getAppBundleIdentifier;

+(NSString *)getAppVersion;

+(NSString *)getAppBuildVersion;

+(NSString *)getDeviceLocale;

+(NSString *)getCountryCode;

+(NSString *)getDeviceLanguage;

+(NSString *)getDeviceModel;

//+(NSString *)getDeviceMarkettingName;

+(NSString *)getOSName;

+(NSString *)getOSVersion;

+(NSString *)getSDKVersion;

+(NSString *)getSDKBuildVersion;

+(NSString *)getDeviceManufacturer;

+(NSString *)getNetworktype;

+(NSString *)getNetworkSignalStrength;

+(NSString *)getScreenResolution;

+(NSString *)getScreenSize;

+(NSString *)getMerchantID;

+(NSString *)getMerchantKey;

+(NSString *)getIP;

+(NSString *)getAppName;

+(NSString *)getDeviceTime;

+(NSString *)getEnvironment;

+(NSString *)getDeviceName;

+(NSString *)getPnPVersion;

+(NSString *)deviceSupportFingerprint;

@end

