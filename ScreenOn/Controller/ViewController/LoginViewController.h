//
//  FacebookViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 02/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <UIKit/UIKit.h>
#import "NSDate+ext.h"

@interface LoginViewController : UIViewController <GIDSignInUIDelegate, GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet GIDSignInButton *googleSignInButton;

@property(nonatomic, strong) GADBannerView *admocBannerView;

@end
