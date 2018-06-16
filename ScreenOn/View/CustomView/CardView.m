//
//  CardView.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 16/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:UIColor.clearColor];
    [self.layer setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5].CGColor];
    [self.layer setCornerRadius:15.0];
    [self.layer setMasksToBounds:YES];
}

@end
