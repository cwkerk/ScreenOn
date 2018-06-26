//
//  ARViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 16/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import "ARMenuViewController.h"
#import "ARMenuViewControllerDelegate.h"
#import "AudioPlayer.h"
#import "NSDate+ext.h"
#import "RoundedButton.h"
#import "VideoPlayer.h"

#ifdef __IPHONE_11_0

#import <ARKit/ARKit.h>
#import <ReplayKit/ReplayKit.h>
#import "ARSCNView+ext.h"
#import "UIViewController+ext.h"
#import "VideoRecorder.h"
#define DELEGATE ARSCNViewDelegate, RPScreenRecorderDelegate, ARMenuViewControllerDelegate

#elif __IPHONE_9_0

#import <ReplayKit/ReplayKit.h>
#define DELEGATE ARSCNViewDelegate, RPScreenRecorderDelegate, ARMenuViewControllerDelegate

#else

#define DELEGATE ARMenuViewControllerDelegate

#endif

@interface ARViewController : UIViewController <DELEGATE>

@property (strong, nonatomic, readonly) ARSCNView *arScnView NS_AVAILABLE_IOS(11.0);

@property (strong, nonatomic, readonly) SCNNode *panningNode NS_AVAILABLE_IOS(11.0);

@property (strong, nonatomic, readonly) AudioPlayer *audioPlayer;

@property (strong, nonatomic, readonly) VideoRecorder *recorder;

@property (weak, nonatomic) IBOutlet RoundedButton *menuButton;

@end
