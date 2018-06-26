//
//  VideoRecorder.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "VideoRecorder.h"

@implementation VideoRecorder

- (instancetype)init {
    if (self = [super init]) {
        [[RPScreenRecorder sharedRecorder] setDelegate:self];
    }
    return self;
}

- (void)startRecordVideoIn:(CGRect)rect completion:(void(^ _Nullable)(NSError * _Nullable))handler {
    if ([[RPScreenRecorder sharedRecorder] isAvailable]) {
        self->_assetWriter = [[AVAssetWriter alloc] initWithName:[NSString stringWithFormat:@"ar_%@.mp4", [[NSDate date] toStringForFormat:@"yyyyMMddHHmmss"]] InRect:rect];
        if (@available(iOS 11.0, *)) {
            [[RPScreenRecorder sharedRecorder] startCaptureWithHandler:^(CMSampleBufferRef _Nonnull sampleBuffer, RPSampleBufferType bufferType, NSError * _Nullable error) {
                if (error != nil) {
                    handler(error);
                    return;
                }
                if (CMSampleBufferDataIsReady(sampleBuffer)) {
                    if (self.assetWriter.status == AVAssetWriterStatusUnknown) {
                        [self.assetWriter startWriting];
                        [self.assetWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
                    }
                }
                if (bufferType == RPSampleBufferTypeVideo && self.assetWriter.inputs.firstObject.isReadyForMoreMediaData) {
                    [self.assetWriter.inputs.firstObject appendSampleBuffer:sampleBuffer];
                }
            } completionHandler:handler];
        }
    } else {
        handler([NSError errorWithDomain:NSItemProviderErrorDomain code:RPRecordingErrorFailedToStart userInfo:nil]);
    }
}

- (void)stopRecordVideoWithcompletion:(void(^ _Nullable)(NSURL * _Nullable, NSError * _Nullable))handler {
    if (@available(iOS 11.0, *)) {
        [[RPScreenRecorder sharedRecorder] stopCaptureWithHandler:^(NSError * _Nullable error) {
            [self.assetWriter finishWritingWithCompletionHandler:^{
                if (error != nil) {
                    handler(nil, error);
                } else {
                    NSLog(@"Video is recorded in URL: %@", self.assetWriter.outputURL);
                    handler(self.assetWriter.outputURL, nil);
                }
            }];
        }];
    }
}

@end
