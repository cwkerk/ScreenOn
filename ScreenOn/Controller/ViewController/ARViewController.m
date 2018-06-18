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
        self.arScnView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        [self.arScnView setDelegate:self];
        [self.view addSubview:self.arScnView];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
        [self.arScnView addGestureRecognizer:pan];
        [self.arScnView addGestureRecognizer:tap];
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

#pragma private functions

- (void)panGestureHandler:(UIPanGestureRecognizer *)sender {
    if (@available(iOS 11.0, *)) {
        CGPoint position = [sender locationInView:self.arScnView];
        SCNHitTestResult *result = [self.arScnView hitTest:position options:nil].firstObject;
        switch (sender.state) {
            case UIGestureRecognizerStateBegan:
                self.panningNode = result.node;
                break;
            case UIGestureRecognizerStateChanged:
                self.panningNode.position = [self.arScnView getVector3From:position withType:ARHitTestResultTypeFeaturePoint];
                break;
            case UIGestureRecognizerStateEnded:
                self.panningNode = nil;
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

@end
