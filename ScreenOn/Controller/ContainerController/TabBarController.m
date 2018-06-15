//
//  TabBarController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:YES];
}

- (void)logoutFB {
    [[[FBSDKLoginManager alloc] init] logOut];
}

- (void)logoutGID {
    [[GIDSignIn sharedInstance] signOut];
}

@end
