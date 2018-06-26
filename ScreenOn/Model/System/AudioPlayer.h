//
//  AudioPlayer.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : NSObject

@property (strong, nonatomic, nullable) AVAudioPlayer * audioPlayer;

- (void)playAudio:(NSString * _Nonnull)audioName audioType:(NSString * _Nonnull)audioType;

- (void)stopAudioPlay;

@end
