//
//  Reachability.h
//  WebService
//
//  Created by Mayank Goyal on 09/05/15.
//  Copyright (c) 2015 Mayank Goyal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef enum {
	NotReachable = 0,
	ReachableViaWiFi,
	ReachableViaWWAN
} NetworkStatus;
#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"

@interface PayuMoneySDKReachability: NSObject
{
	BOOL localWiFiRef;
	SCNetworkReachabilityRef reachabilityRef;
}

//reachabilityWithHostName- Use to check the reachability of a particular host name. 
+ (PayuMoneySDKReachability*) reachabilityWithHostName: (NSString*) hostName;

//reachabilityWithAddress- Use to check the reachability of a particular IP address. 
+ (PayuMoneySDKReachability*) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress;

//reachabilityForInternetConnection- checks whether the default route is available.  
// PayuMoneySDK Should be used by applications that do not connect to a particular host
+ (PayuMoneySDKReachability*) reachabilityForInternetConnection;

//reachabilityForLocalWiFi- checks whether a local wifi connection is available.
+ (PayuMoneySDKReachability*) reachabilityForLocalWiFi;

//Start listening for reachability notifications on the current run loop
- (BOOL) startNotifier;
- (void) stopNotifier;

- (NetworkStatus) currentReachabilityStatus;
//WWAN may be available, but not active until a connection has been established.
//WiFi may require a connection for VPN on Demand.
- (BOOL) connectionRequired;
@end


