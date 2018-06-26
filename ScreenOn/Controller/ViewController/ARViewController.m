//
//  ARViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 16/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "ARViewController.h"

@interface ARViewController ()

@end

@implementation ARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self->_arScnView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        [self.arScnView setDelegate:self];
        [self.view addSubview:self.arScnView];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
        [self.arScnView addGestureRecognizer:pan];
        [self.arScnView addGestureRecognizer:tap];
    }
    [self.snapShotBtn.imageView setTintColor:[UIColor whiteColor]];
    [self.videoRecordBtn.imageView setTintColor:[UIColor whiteColor]];
    [self.view bringSubviewToFront:self.snapShotBtn];
    [self.view bringSubviewToFront:self.videoRecordBtn];
    [[RPScreenRecorder sharedRecorder] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)) {
        ARWorldTrackingConfiguration *config = [ARWorldTrackingConfiguration new];
        [config setProvidesAudioData:YES];
        [config setLightEstimationEnabled:YES];
        [self.arScnView.session runWithConfiguration:config options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (@available(iOS 11.0, *)) {
        [self.arScnView.session pause];
    }
}

- (IBAction)takeSnapshot:(id)sender {
    if (@available(iOS 11.0, *)) {
        UIImage *shapShot = [self.arScnView snapshot];
        NSData *data = UIImagePNGRepresentation(shapShot);
        [[CoreDataManager sharedInstance] upsertForEntity:@"Record" withQuery:@"name=%@" andArgs:@[@"test"] targetParams: @{@"name": @"test", @"date": [NSDate date], @"data": data, @"format": @"png"}];
    }
}

- (IBAction)recordVideo:(UIButton *)sender {
    if (@available(iOS 11.0, *)) {
        if ([[RPScreenRecorder sharedRecorder] isAvailable]) {
            if (CGColorEqualToColor(sender.imageView.tintColor.CGColor, [UIColor whiteColor].CGColor)) {
                self->_assetWriter = [[AVAssetWriter alloc] initWithName:[NSString stringWithFormat:@"test_%@.mp4", [[NSDate date] toStringForFormat:@"yyyyMMddHHmmss"]] InRect:self.view.bounds];
                [[RPScreenRecorder sharedRecorder] startCaptureWithHandler:^(CMSampleBufferRef  _Nonnull sampleBuffer, RPSampleBufferType bufferType, NSError * _Nullable error) {
                    if (CMSampleBufferDataIsReady(sampleBuffer)) {
                        if (self.assetWriter.status == AVAssetWriterStatusUnknown) {
                            [self.assetWriter startWriting];
                            [self.assetWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
                        }
                    }
                    if (bufferType == RPSampleBufferTypeVideo && self.assetWriter.inputs.firstObject.isReadyForMoreMediaData) {
                        [self.assetWriter.inputs.firstObject appendSampleBuffer:sampleBuffer];
                    }
                } completionHandler:^(NSError * _Nullable error) {
                    if (error != nil) {
                        NSLog(@"Screen recording is failed to start due to : %@", [error localizedDescription]);
                    }
                }];
                [self.videoRecordBtn.imageView setTintColor:[UIColor redColor]];
            } else {
                [[RPScreenRecorder sharedRecorder] stopCaptureWithHandler:^(NSError * _Nullable error) {
                    [self.assetWriter finishWritingWithCompletionHandler:^{
                        if (error != nil) {
                            NSLog(@"Failed to start recording due to %@", [error localizedDescription]);
                        } else {
                            NSLog(@"Video is recorded in URL: %@", self.assetWriter.outputURL);
                            [VideoPlayer playVideoOfURL:self.assetWriter.outputURL OnViewController:self];
                        }
                    }];
                }];
                [self.videoRecordBtn.imageView setTintColor:[UIColor whiteColor]];
            }
        } else {
            NSLog(@"Failed to start/stop recording due to Screen recorder is not available");
        }
    }
}

#pragma private functions

- (void)panGestureHandler:(UIPanGestureRecognizer *)sender {
    if (@available(iOS 11.0, *)) {
        CGPoint position = [sender locationInView:self.arScnView];
        SCNHitTestResult *result = [self.arScnView hitTest:position options:nil].firstObject;
        switch (sender.state) {
            case UIGestureRecognizerStateBegan:
                self->_panningNode = result.node;
                break;
            case UIGestureRecognizerStateChanged:
                self.panningNode.position = [self.arScnView getVector3From:position withType:ARHitTestResultTypeFeaturePoint];
                break;
            case UIGestureRecognizerStateEnded:
                self->_panningNode = nil;
                break;
            default:
                break;
        }
    }
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)sender {
    if (@available(iOS 11.0, *)) {
        SCNBox *box = [SCNBox boxWithWidth:0.05 height:0.05 length:0.05 chamferRadius:0.005];
        [self.arScnView makeNodeFor:box atPoint:[sender locationInView:self.arScnView]];
        NSArray<SCNNode *> *nodes = self.arScnView.scene.rootNode.childNodes;
        if (nodes.count > 1) {
            SCNNode *nodeA = [nodes objectAtIndex:nodes.count - 2];
            SCNNode *nodeB = [nodes objectAtIndex:nodes.count - 1];
            CGFloat distanceInInch = [nodeA distanceFrom:nodeB unit:INCH];
            NSString *title = [NSString stringWithFormat:@"Distance from previous node is %f", distanceInInch];
            self.navigationItem.title = title;
        }
    }
}

#pragma ARSCNViewDelegate

- (void)session:(ARSession *)session didFailWithError:(NSError *)error NS_AVAILABLE_IOS(11.0) {
    NSLog(@"AR session is failed due to %@", error.localizedDescription);
}

- (void)sessionWasInterrupted:(ARSession *)session NS_AVAILABLE_IOS(11.0) {
    NSLog(@"AR session is interrupted");
}

- (void)sessionInterruptionEnded:(ARSession *)session NS_AVAILABLE_IOS(11.0) {
    NSLog(@"AR session is restored from interruption");
}

- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera NS_AVAILABLE_IOS(11.0) {
    switch (camera.trackingState) {
        case ARTrackingStateNotAvailable:
            NSLog(@"Camera tracking is not available");
            break;
        case ARTrackingStateLimited:
            NSLog(@"Camera tracking is limited");
            break;
        default:
            NSLog(@"Camera tracking is under normal circumference");
            break;
    }
}

- (void)session:(ARSession *)session didOutputAudioSampleBuffer:(CMSampleBufferRef)audioSampleBuffer NS_AVAILABLE_IOS(11.0) {
    
}

#pragma RPScreenRecorderDelegate

- (void)screenRecorderDidChangeAvailability:(RPScreenRecorder *)screenRecorder {
    NSLog(@"Screen recorder changes availability");
}

- (void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithError:(NSError *)error previewViewController:(RPPreviewViewController *)previewViewController {
    NSLog(@"Screen recorder stopped with error : %@", [error localizedDescription]);
}

- (void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithPreviewViewController:(RPPreviewViewController *)previewViewController error:(NSError *)error {
    NSLog(@"Screen recorder stopped with preview due to error : %@", [error localizedDescription]);
}

@end
