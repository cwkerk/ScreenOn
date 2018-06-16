//
//  UIViewController+ext.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "UIViewController+ext.h"

@implementation UIViewController (ext)

- (void)showContentViewController:(UIViewController* _Nonnull)vc underRect:(CGRect)rect inView:(UIView * _Nonnull)view {
    [self addChildViewController:vc];
    [vc.view setBounds:rect];
    [view addSubview: vc.view];
    [vc didMoveToParentViewController:self];
}

- (void)hideContentViewController:(UIViewController* _Nonnull)vc {
    [vc willMoveToParentViewController:nil]; // counterpart of [self addChildViewController:vc] function
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController]; // this function also invoke [vc didMoveToParentViewController:nil] function
}

- (void)swapContenViewControllersFrom:(UIViewController* _Nonnull)from to:(UIViewController* _Nonnull)to inView:(UIView * _Nonnull)view animateWith:(UIViewAnimationOptions)opt {
    // removing old viewcontroller & adding new viewcontroller
    [from willMoveToParentViewController:nil];
    [self addChildViewController:to];
    // add new view to parent viewcontroller
    [view addSubview: to.view];
    // animate the swapping of two viewcontrollers
    [self transitionFromViewController:from toViewController:to duration:0.5 options:opt animations:^{
        // animate the swapping of two view frames
        [to.view setBounds:from.view.bounds];
        [from.view setBounds:CGRectZero];
    } completion:^(BOOL finished) {
        // notify parent viewcontroller for the completion
        [from removeFromParentViewController];
        [to didMoveToParentViewController:self];
    }];
}

@end
