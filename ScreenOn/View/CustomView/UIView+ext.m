//
//  UIViewController+ext.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "UIView+ext.h"

@implementation UIView (ext)

-(UIActivityIndicatorView *)loader {
    return objc_getAssociatedObject(self, loaderKey);
}

-(void)setLoader:(UIActivityIndicatorView *)loader {
    objc_setAssociatedObject(self, loaderKey, self.loader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addLoaderWithColor:(UIColor *_Nullable)color andBgColor:(UIColor *_Nullable)bgColor {
    self.loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.loader setColor:color == nil ? UIColor.grayColor : color];
    [self.loader setBackgroundColor:bgColor == nil ? UIColor.whiteColor : bgColor];
    [self.loader setFrame:self.bounds];
    [self.loader setHidesWhenStopped:YES];
    [self addSubview:self.loader];
}

- (void)startLoader {
    [self bringSubviewToFront:self.loader];
    [self.loader startAnimating];
}

- (void)stopLoader {
    [self.loader stopAnimating];
}

- (void)fadeOutWithDuration:(NSTimeInterval)time onCompletion:(void(^)(BOOL))handler {
    [UIView animateWithDuration:time animations:^{
        [self setAlpha:0];
    } completion:handler];
}

@end
