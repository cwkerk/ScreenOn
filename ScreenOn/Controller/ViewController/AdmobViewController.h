//
//  AdmobViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "UIView+ext.h"

@interface AdmobViewController : UIViewController <GADBannerViewDelegate, GADInterstitialDelegate>

@property(strong, nonatomic, nullable) GADBannerView *bannerAdView;

@property(strong, nonatomic, nullable) GADInterstitial *interstitialAdView;

- (void)addBannerAdmobWithAdID:(NSString * _Nonnull)adID;

- (void)addInstitialAdmobWithAdID:(NSString * _Nonnull)adID;

- (void)startBannerAdmobWithdeviceID:(NSString * _Nullable)deviceID;

- (void)startInstitialAdmobWithdeviceID:(NSString * _Nullable)deviceID;

@end
