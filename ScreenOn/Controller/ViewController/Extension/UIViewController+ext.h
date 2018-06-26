//
//  UIViewController+ext.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ext) <UIPopoverPresentationControllerDelegate>

- (void)showContentViewController:(UIViewController* _Nonnull)vc underRect:(CGRect)rect inView:(UIView * _Nonnull)view;

- (void)hideContentViewController:(UIViewController* _Nonnull)vc;

- (void)swapContenViewControllersFrom:(UIViewController* _Nonnull)from to:(UIViewController* _Nonnull)to inView:(UIView * _Nonnull)view animateWith:(UIViewAnimationOptions)opt;

- (void) popoverWithViewController:(UIViewController * _Nonnull)viewCtrl ForView:(UIView * _Nonnull)sender InSize:(CGSize)size InDirection:(UIPopoverArrowDirection)direction;

@end
