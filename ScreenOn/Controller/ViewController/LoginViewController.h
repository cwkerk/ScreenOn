//
//  LoginViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 02/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKGraphRequest.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <PersonalizedAdConsent/PersonalizedAdConsent.h>
#import <PinterestSDK.h>
#import <PDKUser.h>
#import <PDKImageInfo.h>
#import "AdmobViewController.h"
#import "LAContext+ext.h"
#import "LoginView.h"
#import "NSDate+ext.h"
#import "UserNotificationManager.h"

@interface LoginViewController : AdmobViewController <GIDSignInDelegate, GIDSignInUIDelegate, FBSDKLoginButtonDelegate, LoginViewDelegate>

@end
