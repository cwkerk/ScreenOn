//
//  VideoPlayer.m
//  ScreenOn
//
//  Created by Aaron Lee on 25/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "VideoPlayer.h"

@implementation VideoPlayer

+ (void)playVideoOfURL:(NSURL * _Nonnull)url OnViewController:(UIViewController * _Nonnull)viewController {
    if (@available(iOS 8.0, *)) {
        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        [playerViewController setPlayer:[AVPlayer playerWithURL:url]];
        [viewController presentViewController:playerViewController animated:YES completion:nil];
    } else {
        MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [playerViewController.moviePlayer setFullscreen:YES];
        [playerViewController.moviePlayer setShouldAutoplay:YES];
        [viewController presentViewController:playerViewController animated:YES completion:nil];
    }
}

@end
