//
//  CitrusPay.h
//  CTS iOS Sdk
//
//  Created by Yadnesh on 9/14/15.
//  Copyright (c) 2015 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Version.h"

// Layers
#import "CTSAuthLayer.h"
#import "CTSProfileLayer.h"
#import "CTSPaymentLayer.h"

// Models
#import "UIUtility.h"
#import "CTSCitrusLinkRes.h"
#import "CTSKeyStore.h"
#import "CTSDataCache.h"
#import "UserLogging.h"
#import "CTSOauthManager.h"
#import "HVDOverlay.h"
#import "PureLayout.h"
#import <CitrusGraphics/CitrusGraphics-Swift.h>

/**
 *   CTSEnvironment Constants.
 */
typedef enum{
    /**
     *   The CTSEnvSandbox Constant.
     */
    CTSEnvSandbox,
    /**
     *   The CTSEnvProduction Constant.
     */
    CTSEnvProduction
} CTSEnvironment;



/**
 *   CTSLogLevel NS_ENUM.
 */
typedef NS_ENUM(NSUInteger, CTSLogLevel) {
    /**
     *   The CTSLogLevelVerbose ENUM.
     */
    CTSLogLevelVerbose = 0,
    /**
     *   The CTSLogLevelDebug ENUM.
     */
    CTSLogLevelDebug = 1,
    /**
     *   The CTSLogLevelInfo ENUM.
     */
    CTSLogLevelInfo = 2,
    /**
     *   The CTSLogLevelNone ENUM.
     */
    CTSLogLevelNone = 3,
};

/**
 *   CitrusPaymentSDK Singleton Class.
 */
@interface CitrusPaymentSDK : NSObject

/**
 *   Initialize SDK With KeyStore i.e The signinId String, signUpId String, signinSecret String, signUpSecret String and vanity String.
 *
 *  @param signInID The signinId String.
 *  @param signInSecret The signInSecret String.
 *  @param signUpID The signUpID String.
 *  @param signUpSecret The signUpSecret String.
 *  @param vanityUrl The vanityUrl String.
 *  @param environment The CTSEnvSandbox or CTSEnvProduction.
 */
+ (void)initWithSignInID:(NSString *)signInID
            signInSecret:(NSString *)signInSecret
                signUpID:(NSString *)signUpID
            signUpSecret:(NSString *)signUpSecret
               vanityUrl:(NSString *)vanityUrl
             environment:(CTSEnvironment)environment;

/**
 *   Set CTSLogLevel - Default log level will be None unless set otherwise.
 *
 *  @param logLevel The logLevel CTSLogLevel.
 */
+ (void)setLogLevel:(CTSLogLevel)logLevel;


/**
 *   Initialize SDK With KeyStore.
 *
 *  @param keyStore The signinId String, signUpId String, signinSecret String, signUpSecret String and vanity String.
 *  @param env The CTSEnvSandbox or CTSEnvProduction.
 */
+(void)initializeWithKeyStore:(CTSKeyStore *)keyStore
                  environment:(CTSEnvironment)env __attribute__((deprecated("Please use initWithSignInID:signInSecret:signUpID:signUpSecret:vanityUrl:environment:logLevel: instead")));

/**
 *   Initialize SDK With KeyStore.
 *
 *  @param keyStore The signinId String, signUpId String, signinSecret String, signUpSecret String and vanity String.
 *  @param envPlist The CTSEnvSandbox or CTSEnvProduction.
 */
+(void)initializeWithKeyStore:(CTSKeyStore *)keyStore
              environmentPath:(NSString *)envPlist  __attribute__((deprecated("Please use initWithSignInID:signInSecret:signUpID:signUpSecret:vanityUrl:environment:logLevel: instead")));

/**
 *   Get the SDK version.
 *
 *  @return The SDK version string.
 */
+(NSString *)sdkVersion;


/**
 *   Fetch Shared AuthLayer.
 *
 *  @return The AuthLayer object.
 */
+(CTSAuthLayer *)fetchSharedAuthLayer;


/**
 *   Fetch Shared ProfileLayer.
 *
 *  @return The ProfileLayer object.
 */
+(CTSProfileLayer *)fetchSharedProfileLayer;


/**
 *   Fetch Shared PaymentLayer.
 *
 *  @return The PaymentLayer object.
 */
+(CTSPaymentLayer *)fetchSharedPaymentLayer;


/**
 *   Enable DEBUGLogs.
 */
+ (void)enableDEBUGLogs __attribute__((deprecated("Please use setLogLevel: instead")));


/**
 *   Disable OneTapPayment.
 */
+(void)disableOneTapPayment;


/**
 *   Enable OneTapPayment.
 */
+(void)enableOneTapPayment;


/**
 *   Check OneTap Payment Enabled.
 *
 *  @return The BOOL Value.
 */
+(BOOL)isOneTapPaymentEnabled;

/**
 *   Enable Push ViewController.
 */
+(void)enablePush;


/**
 *   Disable Push ViewController.
 */
+(void)disablePush;


/**
 *   Check is Push Enabled.
 *
 *  @return The BOOL Value.
 */
+(BOOL)isPushEnabled;


/**
 *   Disable Loader.
 */
+(void)disableLoader;


/**
 *   Enable Loader.
 */
+(void)enableLoader;


/**
 *   Check is Loader Enabled.
 *
 *  @return The BOOL Value.
 */
+(BOOL)isLoaderEnabled;


/**
 *   Set Loader Color.
 *
 *  @param loaderColor Passed Loader color.
 */
+(void)setLoaderColor:(UIColor *)loaderColor;


/**
 *   Get Loader Color.
 *
 *  @return Show the color passed in.
 */
+(UIColor *)getLoaderColor;

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
/**
 *   Set IndicatorTintColor.
 *
 *  @param color The IndicatorTintColor.
 */
+(void) setIndicatorTintColor:(UIColor *)color;

/**
 *   Check is Blaze Card Payment Enabled.
 *
 *  @return The BOOL Value.
 */
+ (BOOL)isBlazeCardPaymentEnabled;


/**
 *   Enable Blaze Card Payment.
 */
+ (void)enableBlazeCardPayment;


/**
 *   Disable Blaze Card Payment.
 */
+ (void)disableBlazeCardPayment;


/**
 *   Check is Blaze Net Payment Enabled.
 *
 *  @return The BOOL Value.
 */
+ (BOOL)isBlazeNetPaymentEnabled;


/**
 *   Enable Blaze Net Payment.
 */
+ (void)enableBlazeNetPayment;

/**
 *   Disable Blaze Net Payment.
 */
+ (void)disableBlazeNetPayment;

@end
