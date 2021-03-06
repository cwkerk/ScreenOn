//
//  AppDelegate.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 27/05/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [[GIDSignIn sharedInstance] setClientID:@"997117142453-g07648sd279ntfnbm03vbddnkj46dsoq.apps.googleusercontent.com"];
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-1749500499268006~6194951492"];
    [PDKClient configureSharedInstanceWithAppId:@"4972534596330596383"];
    if (@available(iOS 10.0, *)) {
        [[UserNotificationManager sharedInstance] setupNotificationCenter];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[CoreDataManager sharedInstance] saveContext];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL fbhandled = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    BOOL ptHandled = [[PDKClient sharedInstance] handleCallbackURL:url];
    return fbhandled || ptHandled;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[PDKClient sharedInstance] handleCallbackURL:url];
}

@end
