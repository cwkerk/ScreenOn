//
//  LAContext+ext.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "LAContext+ext.h"

@implementation LAContext (ext)

- (void)authWithPolicy:(LAPolicy)policy reason:(nonnull NSString *)reason onCompleteHandler:(void(^ _Nonnull)(BOOL, NSError * _Nullable))handler {
    NSError *err = nil;
    if([self canEvaluatePolicy:policy error:&err]){
        [self evaluatePolicy:policy localizedReason:reason reply:handler];
    } else {
        handler(false, err);
    }
}

@end
