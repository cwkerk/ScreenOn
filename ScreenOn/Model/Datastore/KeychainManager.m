//
//  KeychainManager.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 25/6/18.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "KeychainManager.h"

@implementation KeychainManager

+ (KeychainManager *)sharedInstance {
    static KeychainManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KeychainManager alloc] init];
    });
    return sharedInstance;
}

- (NSMutableDictionary *)createKeychainAttributesWithServiceName:(NSString *)name {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:[name dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecAttrService];
    [attributes setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [attributes setObject:(__bridge id)kSecAttrAccessibleWhenUnlocked forKey:(__bridge id)kSecAttrAccessible];
    return attributes;
}

- (BOOL)__unused createKeychainItemWithTag:(NSString *)name forValue:(NSString *)value {
    NSMutableDictionary *attributes = [self createKeychainAttributesWithServiceName:name];
    if (SecItemCopyMatching((__bridge CFDictionaryRef)attributes, nil) == noErr) {
        // delete existing keychain to upsert keychain item as every keychain item must be unique
        SecItemDelete((__bridge CFDictionaryRef)attributes);
    }
    attributes[(__bridge id)kSecValueData] = [value dataUsingEncoding:NSUTF8StringEncoding];
    return SecItemAdd((__bridge CFDictionaryRef)attributes, nil) == noErr;
}

- (NSString *) retrieveKeychainItemWithServiceName:(NSString *)name {
    NSMutableDictionary *attributes = [self createKeychainAttributesWithServiceName:name];
    attributes[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    attributes[(__bridge id)kSecReturnAttributes] = (__bridge id)kCFBooleanTrue;
    CFDictionaryRef typeRef;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)attributes, (CFTypeRef *)&typeRef) == noErr) {
        NSDictionary *result = (__bridge_transfer NSDictionary *)typeRef;
        return [[NSString alloc] initWithData:[result objectForKey:(__bridge id)kSecValueData] encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

- (BOOL)__unused updateKeychainItemWithServiceName:(NSString *)name toNewValue:(NSString *)value {
    NSMutableDictionary *attributes = [self createKeychainAttributesWithServiceName:name];
    if (SecItemCopyMatching((__bridge CFDictionaryRef)attributes, nil) == noErr) {
        NSMutableDictionary *newAttributes = [NSMutableDictionary dictionary];
        newAttributes[(__bridge id)kSecValueData] = [value dataUsingEncoding:NSUTF8StringEncoding];
        return SecItemUpdate((__bridge CFDictionaryRef)attributes, (__bridge CFDictionaryRef)newAttributes) == noErr;
    } else {
        return NO;
    }
}

- (BOOL)__unused deleteKeychainItemWithServiceName:(NSString *)name {
    NSMutableDictionary *attributes = [self createKeychainAttributesWithServiceName:name];
    if (SecItemCopyMatching((__bridge CFDictionaryRef)attributes, nil) == noErr) {
        return SecItemDelete((__bridge CFDictionaryRef)attributes) == noErr;
    } else {
        return NO;
    }
}

@end
