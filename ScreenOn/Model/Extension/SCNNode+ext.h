//
//  SCNNode+ext.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 18/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface SCNNode (ext)

typedef NS_ENUM(NSInteger, Unit) { INCH, METER };

- (CGFloat)distanceFrom:(SCNNode * _Nonnull)node unit:(Unit)unit;

@end
