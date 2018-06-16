//
//  TopRateViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "TopRateViewController.h"

@interface TopRateViewController ()

@end

@implementation TopRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self addInstitialAdmobWithAdID:@"ca-app-pub-1749500499268006/6074955007"];
    //[self startInstitialAdmob];
    [self addBannerAdmobWithAdID:@"ca-app-pub-1749500499268006/6482697858"];
    [self startBannerAdmob];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(swap:)];
    [self.navigationItem setRightBarButtonItem:btn];
    [self.navigationItem setTitle:@"First"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGRect rectA = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 150);
    DemoAViewController *demoA = [[DemoAViewController alloc] init];
    [self showContentViewController:demoA underRect:rectA inView:self.view];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)swap:(UIBarButtonItem *)btn {
    DemoAViewController *demoA = (DemoAViewController *)self.childViewControllers.firstObject;
    DemoBViewController *demoB = [[DemoBViewController alloc] init];
    [self swapContenViewControllersFrom:demoA to:demoB inView:self.view animateWith:UIViewAnimationOptionCurveEaseInOut];
}

@end
