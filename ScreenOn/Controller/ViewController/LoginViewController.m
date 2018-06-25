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
    LoginView *loginView = [NSBundle.mainBundle loadNibNamed:@"LoginView" owner:self options:nil].firstObject;
    [loginView setBounds:CGRectMake(0, 0, 270, 410)];
    [loginView setCenter:self.view.center];
    [loginView setDelegate:self];
    [loginView.fbLoginBtn setDelegate:self];
    [self.view addSubview:loginView];
    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(logoutApp:)]];
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
    NSString *token = [[PDKClient sharedInstance] oauthToken];
    if ([FBSDKAccessToken currentAccessTokenIsActive]) {
        [self performSegueWithIdentifier:@"enter" sender:nil];
    } else if ([[GIDSignIn sharedInstance] hasAuthInKeychain]) {
        [[GIDSignIn sharedInstance] signInSilently];
    } else {
        [[PDKClient sharedInstance] silentlyAuthenticatefromViewController:self withSuccess:^(PDKResponseObject *responseObject) {
            PDKUser *user = responseObject.user;
            NSLog(@"Boards count is %lu", (unsigned long)responseObject.boards.count);
            [[NSUserDefaults standardUserDefaults] setValue:user.image.url forKey:@"photo"];
            NSLog(@"Pinterest authentification is succeed with account : %@", user);
            [self performSegueWithIdentifier:@"enter" sender:nil];
            NSLog(@"Pin auth is %d with %@", [[PDKClient sharedInstance] authorized], token);
        } andFailure:^(NSError *error) {
            NSLog(@"Pinterest authentification is failed due to %@", [error localizedDescription]);
            // Use other non-tokenized login approaches if failed to login by Pinterest
            // Face ID/Touch ID login
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

#pragma FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    // TODO: response to user login
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,first_name,last_name,picture.width(1000).height(1000),birthday,gender"}] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (error) {
                NSLog(@"Failed to read user profile due to : %@", [error localizedDescription]);
            } else {
                NSString *path = result[@"picture"][@"data"][@"url"];
                [[NSUserDefaults standardUserDefaults] setValue:path forKey:@"pic"];
                NSLog(@"Facebook email is %@", path);
            }
        }];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    // TODO: response to user logout
}

#pragma LoginViewDelegate

- (void)pinterestLoginHandler {
    [[PDKClient sharedInstance] authenticateWithPermissions:@[
        PDKClientReadPublicPermissions, PDKClientWritePublicPermissions,
        PDKClientReadRelationshipsPermissions, PDKClientWriteRelationshipsPermissions
    ] fromViewController:self withSuccess:^(PDKResponseObject *responseObject) {
        PDKUser *user = responseObject.user;
        NSLog(@"Boards count is %lu", (unsigned long)responseObject.boards.count);
        [[NSUserDefaults standardUserDefaults] setValue:user.image.url forKey:@"photo"];
        NSLog(@"Pinterest authentification is succeed with account : %@", user);
        [self performSegueWithIdentifier:@"enter" sender:nil];
        NSString *token = [[PDKClient sharedInstance] oauthToken];
        NSLog(@"Pin auth is %d with %@", [[PDKClient sharedInstance] authorized], token);
        
    } andFailure:^(NSError *error) {
        NSLog(@"Pinterest authentification is failed due to %@", [error localizedDescription]);
    }];
}

@end
