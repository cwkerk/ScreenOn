//
//  ARSCNView+ext.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 18/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <ARKit/ARKit.h>
#import "SCNNode+ext.h"

@interface ARSCNView (ext)

- (SCNVector3)getVector3From:(CGPoint)point withType:(ARHitTestResultType)type NS_AVAILABLE_IOS(11.0);

- (void)makeNodeFor:(SCNGeometry * _Nonnull)geometry atPoint:(CGPoint)point NS_AVAILABLE_IOS(11.0);

- (CGFloat)getDistanceOfNewlyAddedNodeFromLastNode;

@end
