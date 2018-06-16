//
//  FacebookViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 02/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.redColor];
    LoginView *loginView = [NSBundle.mainBundle loadNibNamed:@"LoginView" owner:self options:nil].firstObject;
    [loginView setBounds:CGRectMake(0, 0, 350, 350)];
    [loginView setCenter:self.view.center];
    [loginView.fbLoginBtn setDelegate:self];
    [self.view addSubview:loginView];
    [[GIDSignIn sharedInstance] setDelegate:self];
    [[GIDSignIn sharedInstance] setUiDelegate:self];
    [self addBannerAdmobWithAdID:@"ca-app-pub-1749500499268006/6482697858"];
    [self startBannerAdmob];
    [PACConsentInformation.sharedInstance requestConsentInfoUpdateForPublisherIdentifiers:@[ @"pub-1749500499268006" ] completionHandler:^(NSError *_Nullable error) {
        if (error) {
            NSLog(@"Consent is failed due to %@", error.localizedDescription);
        } else {
            NSLog(@"Consent is completed");
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if ([FBSDKAccessToken currentAccessTokenIsActive]) {
        [self performSegueWithIdentifier:@"enter" sender:nil];
    } else if ([[GIDSignIn sharedInstance] hasAuthInKeychain]) {
        [[GIDSignIn sharedInstance] signInSilently];
    } else {
        // TODO: Face ID/Touch ID Authentification
        // NOTE: No token return from Face ID/Touch ID Authentification system
        // RISK: User account maybe out of sync as no verification information
        /*
        LAContext *context = [[LAContext alloc] init];
        [context authWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics reason:@"ScreenOn uses Touch ID/Face ID login." onCompleteHandler:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    NSLog(@"Face ID login successfully");
                    [self performSegueWithIdentifier:@"enter" sender:nil];
                } else {
                    NSLog(@"Face ID login failed due to %@", error.localizedDescription);
                }
            });
        }];
         */
    }
}

#pragma GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    // Getting user profiles here
    NSLog(@"Google sign in: %@", user.description);
    NSLog(@"Google sign token: %@", user.authentication.idToken);
    NSLog(@"Google email: %@", user.profile.email);
    [self performSegueWithIdentifier:@"enter" sender:nil];
}

#pragma FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    // TODO: response to user login
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    // TODO: response to user logout
}

@end
