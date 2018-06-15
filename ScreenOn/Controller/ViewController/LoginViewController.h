//
//  FacebookViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 02/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "AdmobViewController.h"
#import "NSDate+ext.h"
#import "LAContext+ext.h"

@interface LoginViewController : AdmobViewController <GIDSignInDelegate, GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet GIDSignInButton *googleSignInButton;

@end
