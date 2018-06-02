//
//  NSPersistentStoreCoordinator+ext.h
//  ScreenOn
//
//  Created by Kerk Chin Wee on 31/5/18.
//  Copyright © 2018 Kerk Chin Wee. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSPersistentStoreCoordinator (ext)

- (instancetype)coordinatorWithName:(NSString *)name WithExt:(NSString *)ext;

@end
