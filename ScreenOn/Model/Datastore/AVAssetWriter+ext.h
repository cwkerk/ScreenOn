//
//  AVAssetWriter+ext.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 25/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAssetWriter (ext)

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)fileName InBound:(CGRect)rect;

@end
