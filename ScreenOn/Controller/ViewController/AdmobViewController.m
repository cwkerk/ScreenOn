//
//  AdmobViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "AdmobViewController.h"

@interface AdmobViewController ()

@end

@implementation AdmobViewController

- (void)addBannerAdmobWithAdID:(NSString * _Nonnull)adID { // @"ca-app-pub-1749500499268006/6482697858"
    self.bannerAdView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    [self.bannerAdView setAdUnitID:adID];
    [self.bannerAdView setDelegate:self];
    [self.bannerAdView setRootViewController:self];
    self.bannerAdView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bannerAdView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerAdView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerAdView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
}

- (void)startBannerAdmobWithdeviceID:(NSString * _Nullable)deviceID { // @"763ea513d683f24535cbd93b1d0e2e7d"
    GADRequest *request = [GADRequest request];
    request.testDevices = @[deviceID];
    [self.bannerAdView loadRequest:request];
}

#pragma public functions

- (void)addInstitialAdmobWithAdID:(NSString * _Nonnull)adID { // @"ca-app-pub-1749500499268006/6074955007"
    self.interstitialAdView = [[GADInterstitial alloc] initWithAdUnitID:adID];
    self.interstitialAdView.delegate = self;
}

- (void)startInstitialAdmobWithdeviceID:(NSString * _Nullable)deviceID { // @"763ea513d683f24535cbd93b1d0e2e7d"
    GADRequest *request = [GADRequest request];
    request.testDevices = @[deviceID]; // the line below is esential for testing
    [self.interstitialAdView loadRequest:request];
    [self.view fadeOutWithDuration:1.0 onCompletion:^(BOOL success) {
        if (success) {
            [self.view setHidden:YES];
        } else {
            [self.view setAlpha:1.0];
        }
    }];
}

#pragma GADBannerViewDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    // TODO: failure handling, either reload or ...
    NSLog(@"banner Ad is failed to load due to %@", error.localizedDescription);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startBannerAdmobWithdeviceID:@"763ea513d683f24535cbd93b1d0e2e7d"];
    });
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    // TODO: stop all user interactive functions in response to full-screen view presented due to user clicking on an ad
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    /// Tells the delegate that the full-screen view will be dismissed.
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    // TODO: resume all user interactive functions after full-screen view has been dismissed
}

- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    // TODO: stop all user interactive functions
}

# pragma GADInterstitial

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    [self.interstitialAdView presentFromRootViewController:self];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    // TODO: failure handling, either reload or ...
    NSLog(@"Interstitial Ad is failed to load due to %@", error.localizedDescription);
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    // TODO: stop all user interactive functions
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    [self.view setAlpha:1.0];
    [self.view setHidden:NO];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    // TODO: resume all user interactive functions
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    // TODO: stop all user interactive functions
}

@end
