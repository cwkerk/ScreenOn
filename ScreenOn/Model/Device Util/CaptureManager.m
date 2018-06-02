//
//  CaptureManager.m
//  ScreenOn
//
//  Created by Kerk Chin Wee on 30/5/18.
//  Copyright © 2018 Kerk Chin Wee. All rights reserved.
//

#import "CaptureManager.h"

@implementation CaptureManager

#pragma private functions

- (void)setupCaptureSessionAndPreviewFor:(inout UIView * _Nonnull)view ForPreset:(AVCaptureSessionPreset)preset {
    self->_session = [[AVCaptureSession alloc] init];
    self->_session.sessionPreset = preset;
    self->_previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self->_session];
    self->_previewLayer.frame = view.bounds;
    self->_previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [view.layer addSublayer:self->_previewLayer];
}

- (void)killCaptureSessionAndRemovePreview {
    [self->_previewLayer removeFromSuperlayer];
    self->_previewLayer = nil;
    [self->_session stopRunning];
    self->_session = nil;
}

- (void)addDeviceInputForMediaType:(AVMediaType)mediaType andPosition:(AVCaptureDevicePosition)position onComplete:(void(^)(BOOL))handler {
    AVCaptureDevice *device;
    if (mediaType != AVMediaTypeVideo || position == AVCaptureDevicePositionUnspecified) {
        device = [AVCaptureDevice defaultDeviceWithMediaType:mediaType];
    } else {
        for (AVCaptureDevice *dev in [AVCaptureDevice devicesWithMediaType:mediaType]) {
            if (dev.position == position) {
                device = dev;
                break;
            }
        }
    }
    NSError *inputError;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&inputError];
    if (inputError == nil && [self.session canAddInput:input]) {
        [self->_session addInput:input];
        handler(YES);
    } else {
        handler(NO);
    }
}

#pragma public functions

+ (instancetype)sharedInstance {
    static CaptureManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CaptureManager alloc] init];
    });
    return sharedInstance;
}

- (void)startPhotoCaptureInView:(inout UIView *)view {
    [self setupCaptureSessionAndPreviewFor:view ForPreset:AVCaptureSessionPresetPhoto];
    __weak typeof(self) myself = self;
    __block AVCaptureSession *mysession = self->_session;
    [self addDeviceInputForMediaType:AVMediaTypeVideo andPosition:AVCaptureDevicePositionBack onComplete:^(BOOL success) {
        if (success) {
            AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
            output.videoSettings = @{(NSString *)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA)};
            output.alwaysDiscardsLateVideoFrames = YES;
            if ([mysession canAddOutput:output]) {
                [mysession addOutput:output];
                dispatch_queue_t photoCaptureQueue = dispatch_queue_create("photoCaptureQueue", DISPATCH_QUEUE_SERIAL);
                [output setSampleBufferDelegate:myself queue:photoCaptureQueue];
                [mysession commitConfiguration];
                [mysession startRunning];
            } else {
                [myself killCaptureSessionAndRemovePreview];
            }
        } else {
            [myself killCaptureSessionAndRemovePreview];
        }
    }];
}

- (void)startVideoCaptureToFileURL:(NSURL *)url InView:(inout UIView *)view {
    [self setupCaptureSessionAndPreviewFor:view ForPreset:AVCaptureSessionPresetHigh];
    __weak typeof(self) myself = self;
    __block AVCaptureSession *mysession = self->_session;
    [self addDeviceInputForMediaType:AVMediaTypeAudio andPosition:AVCaptureDevicePositionUnspecified onComplete:^(BOOL success) {
        if (success) {
            [myself addDeviceInputForMediaType:AVMediaTypeVideo andPosition:AVCaptureDevicePositionBack onComplete:^(BOOL success) {
                if (success) {
                    AVCaptureMovieFileOutput *movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
                    if ([mysession canAddOutput:movieFileOutput]) {
                        [mysession addOutput:movieFileOutput];
                        [mysession commitConfiguration];
                        [mysession startRunning];
                        [movieFileOutput startRecordingToOutputFileURL:url recordingDelegate:myself]; // must be after session running
                    } else {
                        [myself killCaptureSessionAndRemovePreview];
                    }
                } else {
                    [myself killCaptureSessionAndRemovePreview];
                }
            }];
        } else {
            [myself killCaptureSessionAndRemovePreview];
        }
    }];
}

- (void)stopCaptureSession {
    if (self->_session.isRunning) {
        [self->_session stopRunning];
        [CATransaction begin];
        CALayer *flash = [CALayer layer];
        [flash setBackgroundColor:UIColor.whiteColor.CGColor];
        [flash setFrame:self.previewLayer.bounds];
        [self->_previewLayer addSublayer:flash];
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anim.duration = 0.3;
        anim.repeatCount = 1;
        anim.removedOnCompletion = YES;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.fromValue = @(0);
        anim.toValue = @(1);
        [CATransaction setCompletionBlock:^{
            [self killCaptureSessionAndRemovePreview];
        }];
        [flash addAnimation:anim forKey:@"fading"];
        [CATransaction commit];
    }
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        } else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
            connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
        }
    });
    if (self.session.inputs.count == 1 && ((AVCaptureDeviceInput *)self.session.inputs.firstObject).device.activeFormat.mediaType == AVMediaTypeVideo) { // image capture ONLY
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        CVPixelBufferLockBaseAddress(imageBuffer, 0);
        void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
        size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        CGImageRef quartzImage = CGBitmapContextCreateImage(context);
        CVPixelBufferUnlockBaseAddress(imageBuffer,0);
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        UIImage *image = [UIImage imageWithCGImage:quartzImage];
        CGImageRelease(quartzImage);
        if (self.delegate != nil) {
            [self.delegate processCapturedImage:image];
        }
    }
}

- (void)captureOutput:(nonnull AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(nonnull NSURL *)outputFileURL fromConnections:(nonnull NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error {
    if (self.delegate != nil) {
        [self.delegate processCapturedVideoAtFileURL:outputFileURL];
    }
}

- (void)switchCamera {
    if ([AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo].count < 2) {
        return;
    }
    AVCaptureDeviceInput *currInput = self.session.inputs.lastObject;
    AVCaptureDevicePosition position = currInput.device.position == AVCaptureDevicePositionBack ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    [self->_session stopRunning];
    [self->_session beginConfiguration];
    [self->_session removeInput:currInput];
    __block AVCaptureSession *mysession = self->_session;
    [self addDeviceInputForMediaType:AVMediaTypeVideo andPosition:position onComplete:^(BOOL success) {
        if (success) {
            [mysession commitConfiguration];
            [mysession startRunning];
        } else {
            [mysession addInput:currInput];
            [mysession commitConfiguration];
            [mysession startRunning];
        }
    }];
}

@end
