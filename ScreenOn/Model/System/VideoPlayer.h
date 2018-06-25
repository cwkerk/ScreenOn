//
//  VideoPlayer.h
//  ScreenOn
//
//  Created by Aaron Lee on 25/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __IPHONE_8_0

#import <AVKit/AVKit.h>

#else

#import <MediaPlayer/MediaPlayer.h>

#endif

#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayer : NSObject

+ (void)playVideoOfURL:(NSURL * _Nonnull)url OnViewController:(UIViewController * _Nonnull)viewController;

@end
