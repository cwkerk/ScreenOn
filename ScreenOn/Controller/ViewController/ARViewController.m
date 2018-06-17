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

- (SCNVector3)makeVector3From:(CGPoint)point withType:(ARHitTestResultType)type NS_AVAILABLE_IOS(11.0) {
    ARHitTestResult *result = [self.arScnView hitTest:point types:type].firstObject;
    return SCNVector3Make(result.worldTransform.columns[3].x, result.worldTransform.columns[3].y, result.worldTransform.columns[3].z);
}

- (void)makeBoxNodeFromPosition:(CGPoint)pos NS_AVAILABLE_IOS(11.0) {
    SCNBox *box = [SCNBox boxWithWidth:0.05 height:0.05 length:0.05 chamferRadius:0.005];
    SCNNode *node = [SCNNode nodeWithGeometry:box];
    node.position = [self makeVector3From:pos withType:ARHitTestResultTypeFeaturePoint];
    [self.arScnView.scene.rootNode addChildNode:node];
}

- (void)panGestureHandler:(UIPanGestureRecognizer *)sender {
    if (@available(iOS 11.0, *)) {
        CGPoint position = [sender locationInView:self.arScnView];
        SCNHitTestResult *result = [self.arScnView hitTest:position options:nil].firstObject;
        switch (sender.state) {
            case UIGestureRecognizerStateBegan:
                self.panningNode = result.node;
                break;
            case UIGestureRecognizerStateChanged:
                self.panningNode.position = [self makeVector3From:position withType:ARHitTestResultTypeFeaturePoint];
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
        [self makeBoxNodeFromPosition:[sender locationInView:self.arScnView]];
    }
}

@end
