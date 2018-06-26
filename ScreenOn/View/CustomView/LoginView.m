//
//  LoginView.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 16/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.appLogoView.layer setCornerRadius:10.0];
    [self.fbLoginBtn setBackgroundColor:UIColor.clearColor];
    [self.fbLoginBtn setReadPermissions:@[@"email", @"public_profile"]];
    [self.pinterestLoginBtn.layer setCornerRadius:3.0];
    //[self.pinterestLoginBtn.imageView setTintColor:UIColor.whiteColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    for (NSLayoutConstraint *c in self.fbLoginBtn.constraints) {
        if (c.firstAttribute == NSLayoutAttributeHeight && c.constant == 28) {
            [c setActive:NO];
            [self.fbLoginBtn removeConstraint:c];
        }
    }
}

- (IBAction)pinterestLogin:(id)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(pinterestLoginHandler)]) {
        [self.delegate pinterestLoginHandler];
    }
}

@end
