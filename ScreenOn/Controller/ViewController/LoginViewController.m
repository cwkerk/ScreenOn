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
    [[GIDSignIn sharedInstance] setUiDelegate:self];
    [self addBannerAdmobWithAdID:@"ca-app-pub-1749500499268006/6482697858"];
    [self startBannerAdmobWithdeviceID:@"763ea513d683f24535cbd93b1d0e2e7d"];
    //[self addInstitialAdmobWithAdID:@"ca-app-pub-1749500499268006/6074955007"];
    //[self startInstitialAdmobWithdeviceID:@"763ea513d683f24535cbd93b1d0e2e7d"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    /*
    // Facebook auto-login
    if ([FBSDKAccessToken currentAccessTokenIsActive]) {
        NSLog(@"Current user is %@", [FBSDKProfile currentProfile].name);
        NSLog(@"Current token expires at %@", [[FBSDKAccessToken currentAccessToken].expirationDate toStringForFormat:@"dd/MM/yyyy hh:mm:ss a"]);
        [self performSegueWithIdentifier:@"enter" sender:nil];
    } else {
        FBSDKLoginButton *fbLoginButton = [[FBSDKLoginButton alloc] init];
        [fbLoginButton setFrame:CGRectMake(0, 0, 190, 44)];
        fbLoginButton.center = self.view.center;
        fbLoginButton.readPermissions = @[@"public_profile", @"email"];
        [self.view addSubview:fbLoginButton];
    }
    
    // Google auto-login
    [[GIDSignIn sharedInstance] signInSilently];
    
    // Apple Touch ID/Face ID login
    LAContext *context = [[LAContext alloc] init];
    [context authWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics reason:@"ScreenOn uses Touch ID/Face ID login." onCompleteHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"Face ID login successfully");
            [self performSegueWithIdentifier:@"enter" sender:nil];
        } else {
            NSLog(@"Face ID login failed due to %@", error.localizedDescription);
        }
    }];
    */
}

@end
