//
//  KeychainManager.h
//  ScreenOn
//
//  Created by Chin Wee Kerk on 25/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KeychainManager : NSObject

+ (KeychainManager *)sharedInstance;

- (BOOL)__unused createKeychainItemWithTag:(NSString *)name forValue:(NSString *)value;

- (NSString *) retrieveKeychainItemWithServiceName:(NSString *)name;

- (BOOL)__unused updateKeychainItemWithServiceName:(NSString *)name toNewValue:(NSString *)value;

- (BOOL)__unused deleteKeychainItemWithServiceName:(NSString *)name;

@end
