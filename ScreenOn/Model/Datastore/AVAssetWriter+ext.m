//
//  AVAssetWriter+ext.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 25/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "AVAssetWriter+ext.h"

@implementation AVAssetWriter (ext)

- (instancetype)initWithName:(NSString * _Nonnull)fileName InRect:(CGRect)rect {
    NSURL *assetURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    assetURL = [assetURL URLByAppendingPathComponent:fileName];
    NSError *error;
    NSDictionary *settings = @{
        AVVideoCodecKey: AVVideoCodecH264,
        AVVideoWidthKey: [NSNumber numberWithFloat:rect.size.width],
        AVVideoHeightKey: [NSNumber numberWithFloat:rect.size.height]
    };
    if (self = [self initWithURL:assetURL fileType:AVFileTypeMPEG4 error:&error]) {
        [self addInput:[[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:settings]];
    }
    return self;
}

@end
