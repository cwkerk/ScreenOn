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
    [self.fbLoginBtn setBackgroundColor:UIColor.clearColor];
    [self.fbLoginBtn setReadPermissions:@[@"email", @"public_profile"]];
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

@end
