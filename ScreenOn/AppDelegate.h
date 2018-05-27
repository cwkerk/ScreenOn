//
//  AppDelegate.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 27/05/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

