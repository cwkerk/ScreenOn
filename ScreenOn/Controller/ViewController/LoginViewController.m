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
    if ([FBSDKAccessToken currentAccessTokenIsActive]) {
        NSLog(@"Current user is %@", [FBSDKProfile currentProfile].name);
        NSLog(@"Current token expires at %@", [[FBSDKAccessToken currentAccessToken].expirationDate toStringForFormat:@"dd/MM/yyyy hh:mm:ss a"]);
    } else {
        FBSDKLoginButton *fbLoginButton = [[FBSDKLoginButton alloc] init];
        [fbLoginButton setFrame:CGRectMake(0, 0, 190, 44)];
        fbLoginButton.center = self.view.center;
        fbLoginButton.readPermissions = @[@"public_profile", @"email"];
        [self.view addSubview:fbLoginButton];
    }
    [[GIDSignIn sharedInstance] setUiDelegate:self];
    [[GIDSignIn sharedInstance] signOut];
    //[[GIDSignIn sharedInstance] signInSilently];
    self.admocBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    [self addBannerViewToView:self.admocBannerView];
    self.admocBannerView.adUnitID = @"ca-app-pub-1749500499268006/5517677538";
    self.admocBannerView.rootViewController = self;
    [self.admocBannerView loadRequest:[GADRequest request]];
}

-(void)addBannerViewToView:(UIView *_Nonnull)bannerView {
    self.admocBannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.admocBannerView];
    [self positionBannerViewAtBottomOfView:self.admocBannerView];
}

- (void)positionBannerViewAtBottomOfView:(UIView *_Nonnull)bannerView {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.admocBannerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.admocBannerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
}

/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}

@end
