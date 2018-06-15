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
    FBSDKLoginButton *fbLoginButton = [[FBSDKLoginButton alloc] init];
    [fbLoginButton setFrame:CGRectMake(0, 0, 190, 44)];
    fbLoginButton.center = self.view.center;
    fbLoginButton.readPermissions = @[@"public_profile", @"email"];
    [self.view addSubview:fbLoginButton];
    [[GIDSignIn sharedInstance] setDelegate:self];
    [[GIDSignIn sharedInstance] setUiDelegate:self];
    [self addBannerAdmobWithAdID:@"ca-app-pub-1749500499268006/6482697858"];
    [self startBannerAdmobWithdeviceID:@"763ea513d683f24535cbd93b1d0e2e7d"];
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

@end
