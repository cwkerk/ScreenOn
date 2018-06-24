//
//  UIImage+ext.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 21/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "UIImageView+ext.h"

@implementation UIImageView (ext)

- (void)setImageFrom:(NSURL * _Nonnull)url completionHandler:(void(^)(UIImage * _Nullable image, NSError * _Nullable error))handler {
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (data && response && !error) {
            UIImage *image = [UIImage imageWithData:data];
            NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
            if (image && resp.statusCode == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setImage:image];
                    handler(image, error);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(image, error);
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, error);
            });
        }
    }] resume];
}

@end
