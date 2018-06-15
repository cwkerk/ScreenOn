//
//  UserNotificationManager.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __IPHONE_9_0

#import <UserNotifications/UserNotifications.h>
#define DELEGATE UNUserNotificationCenterDelegate

#else

#define DELEGATE NSObject

#endif

@interface UserNotificationManager : NSObject <DELEGATE>

@property (readonly, nonatomic) BOOL isPermitted;

+ (instancetype)sharedInstance;

- (void)setupNotificationCenter NS_AVAILABLE_IOS(10.0);

- (void)scheduleCalenderNotificationWithTitle:(NSString * _Nonnull)title andBody:(NSString * _Nonnull)body onCompleteHandler:(void(^ _Nullable)(NSError * _Nullable))handler onDate:(NSDate * _Nonnull)date underId:(NSString * _Nullable)identifier;

- (void)scheduleTimedNotificationWithTitle:(NSString * _Nonnull)title andBody:(NSString * _Nonnull)body onCompleteHandler:(void(^ _Nullable)(NSError * _Nullable))handler afterTime:(NSTimeInterval)time underId:(NSString * _Nullable)identifier;

@end
