//
//  UIImage+ext.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 21/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ext)

- (void)setImageFrom:(NSURL * _Nonnull)url completionHandler:(void(^)(UIImage * _Nullable image, NSError * _Nullable error))handler;

@end
