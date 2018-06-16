//
//  LoginView.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 16/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "CardView.h"

@interface LoginView : CardView

@property (weak, nonatomic) IBOutlet UIImageView *appLogoView;
@property (weak, nonatomic) IBOutlet GIDSignInButton *gidSigninBtn;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginBtn;

@end
