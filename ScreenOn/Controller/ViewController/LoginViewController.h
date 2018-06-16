//
//  FacebookViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 02/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <PersonalizedAdConsent/PersonalizedAdConsent.h>
#import "AdmobViewController.h"
#import "LAContext+ext.h"
#import "LoginView.h"
#import "NSDate+ext.h"

@interface LoginViewController : AdmobViewController <GIDSignInDelegate, GIDSignInUIDelegate, FBSDKLoginButtonDelegate>

@end
