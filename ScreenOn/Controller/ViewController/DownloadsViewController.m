//
//  DownloadsViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "DownloadsViewController.h"

@interface DownloadsViewController ()

@end

@implementation DownloadsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBannerAdmobWithAdID:@"ca-app-pub-1749500499268006/6482697858"];
    [self startBannerAdmobWithdeviceID:@"763ea513d683f24535cbd93b1d0e2e7d"];
}

@end
