//
//  UIView+ext.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <objc/runtime.h>
#import <UIKit/UIKit.h>

static const void * _Nonnull loaderKey = &loaderKey;

@interface UIView (ext)

@property (readonly, strong, nonatomic, nonnull) UIActivityIndicatorView *loader;

- (void)addLoaderWithColor:(UIColor *_Nullable)color andBgColor:(UIColor *_Nullable)bgColor;

- (void)startLoader;

- (void)stopLoader;

- (void)fadeOutWithDuration:(NSTimeInterval)time onCompletion:(void(^_Nullable)(BOOL))handler;

@end
