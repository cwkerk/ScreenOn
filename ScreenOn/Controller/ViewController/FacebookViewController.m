//
//  FacebookViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 02/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessTokenIsActive]) {
        NSLog(@"Current user is %@", [FBSDKProfile currentProfile].name);
        NSLog(@"Current token expires at %@", [[FBSDKAccessToken currentAccessToken].expirationDate toStringForFormat:@"dd/MM/yyyy hh:mm:ss a"]);
    } else {
        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
        loginButton.center = self.view.center;
        loginButton.readPermissions = @[@"public_profile", @"email"];
        [self.view addSubview:loginButton];
    }
}

@end
