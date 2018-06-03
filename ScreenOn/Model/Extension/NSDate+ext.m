//
//  NSDate+ext.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 03/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "NSDate+ext.h"

@implementation NSDate (ext)

- (NSString * _Nonnull)toStringForFormat:(NSString * _Nonnull)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:NSLocale.currentLocale];
    [formatter setTimeZone:NSTimeZone.defaultTimeZone];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

@end
