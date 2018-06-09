//
//  AppDelegate.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 27/05/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "CoreDataManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

