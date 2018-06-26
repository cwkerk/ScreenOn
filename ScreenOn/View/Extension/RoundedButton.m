//
//  RoundedButton.m
//  ScreenOn
//
//  Created by Kerk Chin Wee on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:UIColor.clearColor];
    [self.layer setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5].CGColor];
    [self.layer setCornerRadius:0.3 * self.bounds.size.width];
    [self.layer setMasksToBounds:YES];
}

@end
