//
//  AudioPlayer.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer

- (void)playAudio:(NSString * _Nonnull)audioName audioType:(NSString * _Nonnull)audioType {
    [self stopAudioPlay];
    NSString *path = [[NSBundle mainBundle] pathForResource:audioName ofType:audioType];
    if (path) {
        NSURL *url = [NSURL fileURLWithPath:path];
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (error) {
            NSLog(@"Failed to play audio due to %@", [error localizedDescription]);
        } else {
            [self.audioPlayer play];
        }
    } else {
        NSLog(@"Failed to play audio as the audio %@.%@ does not exist", audioName, audioType);
    }
}

- (void)stopAudioPlay {
    if (self.audioPlayer != nil && [self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    }
}

@end
