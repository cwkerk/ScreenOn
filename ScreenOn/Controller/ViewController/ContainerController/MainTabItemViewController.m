//
//  MainTabItemViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 25/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "MainTabItemViewController.h"

@interface MainTabItemViewController ()

@end

@implementation MainTabItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutApp:)];
    [self.navigationItem setLeftBarButtonItem:backButton];
}

- (void)logoutApp:(UIBarButtonItem *)sender {
    [[FBSDKLoginManager alloc] logOut];
    [[GIDSignIn sharedInstance] signOut];
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    [nav popToRootViewControllerAnimated:YES];
}

@end
