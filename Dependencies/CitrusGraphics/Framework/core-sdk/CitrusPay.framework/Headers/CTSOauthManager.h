//
//  CTSOauthManager.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 21/07/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSOauthTokenRes.h"
#import "OauthStatus.h"
#import "CTSKeyStore.h"

@protocol OauthHandler<NSObject>

@end


typedef enum{
    TokenPrivilegeTypeBind,
    TokenPrivilegeTypeSignin,
    TokenPrivilegeTypePrepaidSignin,
    TokenPrivilegeTypeSignUp,
    TokenPrivilegeTypeAny,
    TokenPrivilegeTypeAnyPasswordSignin

}
TokenPrevilageType;

@interface CTSOauthManager : NSObject
+ (NSString*)readPasswordSigninOauthToken;
+ (void)resetPasswordSigninOauthData;
+ (BOOL)hasPasswordSignInOauthExpired;
+ (void)savePasswordSigninOauthData:(CTSOauthTokenRes*)object;
+ (CTSOauthTokenRes*)readPasswordSigninOuthData;
/**
 *  read oauthToken with expiry check,nil in case of expiry
 *
 *  @return OauthToken or nil if expired
 */
+ (NSString*)readPasswordSigninOauthTokenWithExpiryCheck;

+ (NSString*)readBindSigninOauthTokenWithExpiryCheck;

/**
 *  whenever access token error is reported merchant should call this method to
 * get new token from server.
 */
+ (NSString*)readRefreshToken;

/**
 *  fetch oauth token
 *
 *  @return OauthStatus with proper error and valid oauth token
 */
+ (OauthStatus*)fetchPasswordSigninTokenStatus:(CTSKeyStore *)keyStore;

+ (OauthStatus*)fetchSignupTokenStatus:(CTSKeyStore *)keyStore;

+ (void)saveSignupToken:(NSString*)token;

+ (NSString*)readSignupToken;

+ (CTSOauthTokenRes*)readBindSignInOauthData;

+(void)saveBindSignInOauth:(CTSOauthTokenRes*)object;

+ (OauthStatus*)fetchBindSigninTokenStatus:(CTSKeyStore *)keyStore;

+ (void)resetBindSiginOauthData ;

+(void)resetSignupToken;

//prepaid token
+(void)resetPrepaidSigninToken;

+(NSString *)readPrepaidSignInRefreshToken;

+(NSString*)readPrepaidSigninOauthTokenWithExpiryCheck;

+(CTSOauthTokenRes*)readPrepaidSigninOuthData;

+ (void)savePrepaidSigninOauthData:(CTSOauthTokenRes*)object;

+(OauthStatus *)tokenWithPrivilege:(TokenPrevilageType)type;

+(void)saveToken:(CTSOauthTokenRes *)oauthToken privilege:(TokenPrevilageType)type;

+(BOOL)hasPrepaidSigninOauthTokenExpired;

@end
