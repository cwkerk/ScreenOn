//
//  ARSCNView+ext.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 18/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "ARSCNView+ext.h"

@implementation ARSCNView (ext)

- (SCNVector3)getVector3From:(CGPoint)point withType:(ARHitTestResultType)type NS_AVAILABLE_IOS(11.0) {
    ARHitTestResult *result = [self hitTest:point types:type].firstObject;
    return SCNVector3Make(result.worldTransform.columns[3].x, result.worldTransform.columns[3].y, result.worldTransform.columns[3].z);
}

- (void)makeNodeFor:(SCNGeometry * _Nonnull)geometry atPoint:(CGPoint)point NS_AVAILABLE_IOS(11.0) {
    SCNNode *node = [SCNNode nodeWithGeometry:geometry];
    node.position = [self getVector3From:point withType:ARHitTestResultTypeFeaturePoint];
    [self.scene.rootNode addChildNode:node];
}

- (CGFloat)getDistanceOfNewlyAddedNodeFromLastNode {
    NSArray<SCNNode *> *nodes = self.scene.rootNode.childNodes;
    if (nodes.count > 1) {
        SCNNode *nodeA = [nodes objectAtIndex:nodes.count - 2];
        SCNNode *nodeB = [nodes objectAtIndex:nodes.count - 1];
        return [nodeA distanceFrom:nodeB unit:INCH];
    } else {
        return 0;
    }
}

@end
