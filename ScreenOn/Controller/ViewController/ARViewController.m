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
        if ([ARWorldTrackingConfiguration isSupported]) {
            self->_arScnView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
            [self.arScnView setDelegate:self];
            [self.view addSubview:self.arScnView];
            [self.view bringSubviewToFront:self.menuButton];
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
            [self.arScnView addGestureRecognizer:pan];
            [self.arScnView addGestureRecognizer:tap];
            self->_audioPlayer = [[AudioPlayer alloc] init];
            [[RPScreenRecorder sharedRecorder] setDelegate:self];
        } else {
            [self exitViewController];
        }
    } else {
        [self exitViewController];
    }
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

- (IBAction)openMenu:(id)sender {
    ARMenuViewController *menu = [[ARMenuViewController alloc] init];
    [menu setDelegate:self];
    [self popoverWithViewController:menu ForView:self.menuButton InSize:CGSizeMake(self.view.bounds.size.width, 84) InDirection:UIPopoverArrowDirectionUp];
}

#pragma private functions

- (void)exitViewController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"System error" message:@"This device do not support Augment Reality features" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isEqual:UIApplication.sharedApplication.delegate.window.rootViewController]) {
            exit(0);
        } else if (self.navigationController != nil) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    [self.audioPlayer playAudio:@"alert" audioType:@"mp3"];
}

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
        CGPoint position = [sender locationInView:self.arScnView];
        SCNHitTestResult *result = [self.arScnView hitTest:position options:nil].firstObject;
        if (result == nil) {
            SCNBox *box = [SCNBox boxWithWidth:0.05 height:0.05 length:0.05 chamferRadius:0.005];
            [self.arScnView makeNodeFor:box atPoint:[sender locationInView:self.arScnView]];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete this object!?" message:@"Reminder: his action cannot be undone" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *proceed = [UIAlertAction actionWithTitle:@"Proceed" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [result.node removeFromParentNode];
            }];
            [alert addAction:proceed];
            [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            [self.audioPlayer playAudio:@"alert" audioType:@"mp3"];
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

#pragma ARMenuViewControllerDelegate

- (NSArray<MenuItem *> * _Nonnull)getMenuItems {
    MenuItem *itemA = [[MenuItem alloc] init];
    itemA.imageName = @"FaceDetect";
    itemA.onSelectHandler = ^{
        if (@available(iOS 11.0, *)) {
            if ([ARFaceTrackingConfiguration isSupported]) {
                ARFaceTrackingConfiguration *config = [[ARFaceTrackingConfiguration alloc] init];
                [config setProvidesAudioData:YES];
                [config setLightEstimationEnabled:YES];
                [self.arScnView.session pause];
                [self.arScnView.session runWithConfiguration:config options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];
            } else {
                // TODO: alert for failure
            }
        }
    };
    MenuItem *itemB = [[MenuItem alloc] init];
    itemB.imageName = @"Record";
    itemB.onSelectHandler = ^{
        NSLog(@"handler B is calling!!!");
        [self.audioPlayer playAudio:@"alert" audioType:@"mp3"];
    };
    MenuItem *itemC = [[MenuItem alloc] init];
    itemC.imageName = @"Camera";
    itemC.onSelectHandler = ^{
        NSLog(@"handler C is calling!!!");
    };
    NSArray<MenuItem *> *list = [NSArray arrayWithObjects:itemA, itemB, itemC, nil];
    return list;
}

@end
