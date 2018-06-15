//
//  LAContext+ext.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>

@interface LAContext (ext)

- (void)authWithPolicy:(LAPolicy)policy reason:(nonnull NSString *)reason onCompleteHandler:(void(^ _Nonnull)(BOOL, NSError * _Nullable))handler;

@end
