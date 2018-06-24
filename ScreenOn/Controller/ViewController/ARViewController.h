//
//  ARViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 16/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __IPHONE_9_0

#import <ReplayKit/ReplayKit.h>
#define DELEGATE ARSCNViewDelegate, RPScreenRecorderDelegate

#else

#define DELEGATE NSObject

#endif

#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>
#import "ARSCNView+ext.h"
#import "SCNNode+ext.h"

@interface ARViewController : UIViewController <DELEGATE>

@property (strong, nonatomic, readonly) ARSCNView *arScnView NS_AVAILABLE_IOS(11.0);

@property (strong, nonatomic, readonly) SCNNode *panningNode NS_AVAILABLE_IOS(11.0);

@property (strong, nonatomic, readonly) AVAssetWriter *assetWriter;

@property (strong, nonatomic, readonly) UIImage *startRecordingIcon;

@property (strong, nonatomic, readonly) UIImage *stopRecordingIcon;

@property (weak, nonatomic) IBOutlet UIButton *videoRecordBtn;

@end
