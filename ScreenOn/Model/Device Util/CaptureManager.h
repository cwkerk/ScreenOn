//
//  CaptureManager.h
//  ScreenOn
//
//  Created by Kerk Chin Wee on 30/5/18.
//  Copyright © 2018 Kerk Chin Wee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

@protocol CaptureManagerDelegate <NSObject>

@optional

- (void)processCapturedImage:(UIImage * _Nonnull)image;

- (void)processCapturedVideoAtFileURL:(NSURL * _Nonnull)url;

@end

@interface CaptureManager : NSObject <AVCaptureFileOutputRecordingDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (readonly, copy, nonatomic, nonnull) AVCaptureSession *session;

@property (readonly, copy, nonatomic, nonnull) AVCaptureVideoPreviewLayer *previewLayer;

@property (weak, nonatomic, nullable) id<CaptureManagerDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)startPhotoCaptureInView:(inout UIView *)view;

- (void)startVideoCaptureToFileURL:(NSURL *)url InView:(inout UIView *)view;

- (void)stopCaptureSession;

- (void)switchCamera;

@end
