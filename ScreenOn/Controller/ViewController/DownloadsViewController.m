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
    [self startBannerAdmob];
}

@end
