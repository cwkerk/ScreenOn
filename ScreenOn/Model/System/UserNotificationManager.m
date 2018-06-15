//
//  UserNotificationManager.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "UserNotificationManager.h"

@implementation UserNotificationManager

+ (instancetype)sharedInstance {
    static UserNotificationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserNotificationManager alloc] init];
    });
    return sharedInstance;
}

- (void)setupNotificationCenter NS_AVAILABLE_IOS(10.0) {
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL success, NSError * _Nullable error) {
        self->_isPermitted = success && error == nil;
    }];
}

- (void)scheduleCalenderNotificationWithTitle:(NSString * _Nonnull)title andBody:(NSString * _Nonnull)body onCompleteHandler:(void(^ _Nullable)(NSError * _Nullable))handler onDate:(NSDate * _Nonnull)date underId:(NSString * _Nullable)identifier {
    if (self.isPermitted) {
        if(@available(iOS 10, *)) {
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = title;
            content.body = body;
            content.sound = UNNotificationSound.defaultSound;
            NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
            content.badge = [NSNumber numberWithInteger:badgeNumber];
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setTimeZone: [NSTimeZone defaultTimeZone]];
            NSCalendarUnit units = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
            [[NSCalendar currentCalendar] components:units fromDate:date toDate:date options:NSCalendarWrapComponents];
            UNNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:NO];
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:handler];

        } else {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            if (@available(iOS 8.2, *)) {
                notification.alertTitle = title;
            }
            notification.alertBody = body;
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
            notification.fireDate = date;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)scheduleTimedNotificationWithTitle:(NSString * _Nonnull)title andBody:(NSString * _Nonnull)body onCompleteHandler:(void(^ _Nullable)(NSError * _Nullable))handler afterTime:(NSTimeInterval)time underId:(NSString * _Nullable)identifier {
    if (self.isPermitted) {
        if(@available(iOS 10, *)) {
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = title;
            content.body = body;
            content.sound = UNNotificationSound.defaultSound;
            NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
            content.badge = [NSNumber numberWithInteger:badgeNumber];
            UNNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:false];
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:handler];
        } else {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            if (@available(iOS 8.2, *)) {
                notification.alertTitle = title;
            }
            notification.alertBody = body;
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
            notification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:time];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma UNUserNotificationCenterDelegate

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler NS_AVAILABLE_IOS(10) {
    completionHandler(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound);
}


-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(10) {
    if([response.actionIdentifier isEqualToString:UNNotificationDefaultActionIdentifier]){
        NSLog(@"User launch app upon notification");
    } else if([response.actionIdentifier isEqualToString:UNNotificationDismissActionIdentifier]){
        NSLog(@"User dismiss notification");
    } else {
        NSLog(@"User do whatever upon notification");
    }
    completionHandler();
}

@end
