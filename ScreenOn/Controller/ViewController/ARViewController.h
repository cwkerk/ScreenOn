//
//  ARViewController.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 16/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <ARKit/ARKit.h>

@interface ARViewController : UIViewController

@property (strong, nonatomic) ARSCNView *arScnView NS_AVAILABLE_IOS(11.0);

@property (strong, nonatomic) SCNNode *panningNode NS_AVAILABLE_IOS(11.0);

@end
