//
//  CTSAppDelegate.m
//  CitrusPay
//
//  Created by Mukesh Patil on 12/30/2015.
//  Copyright © 2015 CitrusPay. All rights reserved.
//

#import "CTSAppDelegate.h"
//#import <Fabric/Fabric.h>
//#import <Crashlytics/Crashlytics.h>

@implementation CTSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [Fabric with:@[[Crashlytics class]]];

    // Override point for customization after application launch.
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.0, 0.0);
    shadow.shadowColor = [UIColor lightGrayColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSShadowAttributeName:shadow,
       NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0]
       }
     forState:UIControlStateNormal];
    
    // setup for Nevigation Bar
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:245/255.0 green:133/255.0 blue:42/255.0 alpha:1]];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0], NSFontAttributeName, nil]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
