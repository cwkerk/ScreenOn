//
//  VideoRecorder.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 26/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//
// For IOS 11.0+

#import <Foundation/Foundation.h>
#import <ARKit/ARKit.h>
#import <ReplayKit/ReplayKit.h>
#import "AVAssetWriter+ext.h"
#import "NSDate+ext.h"

@interface VideoRecorder : NSObject <RPScreenRecorderDelegate>

@property (strong, nonatomic, readonly) AVAssetWriter *assetWriter;

@end
