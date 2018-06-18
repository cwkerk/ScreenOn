//
//  SCNNode+ext.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 18/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "SCNNode+ext.h"

@implementation SCNNode (ext)

- (CGFloat)distanceFrom:(SCNNode * _Nonnull)node unit:(Unit)unit {
    CGFloat dx = self.position.x - node.position.x;
    CGFloat dy = self.position.y - node.position.y;
    CGFloat dz = self.position.z - node.position.z;
    CGFloat distance = sqrt(dx * dx + dy * dy + dz * dz);
    CGFloat unitValue = 1.0;
    switch (unit) {
        case INCH:
            unitValue = 39.3701;
            break;
        default:
            break;
    }
    return distance * unitValue;
}

@end
