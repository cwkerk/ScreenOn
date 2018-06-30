//
//  NSPersistentStoreCoordinator+ext.m
//  ScreenOn
//
//  Created by Kerk Chin Wee on 31/5/18.
//  Copyright © 2018 Kerk Chin Wee. All rights reserved.
//

#import "NSPersistentStoreCoordinator+ext.h"

@implementation NSPersistentStoreCoordinator (ext)

- (instancetype)coordinatorWithName:(NSString *)name WithExt:(NSString *)ext {
    NSURL *dataModelUrl = [NSBundle.mainBundle URLForResource:name withExtension:ext];
    NSManagedObjectModel *dataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:dataModelUrl];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:dataModel];
    NSURL *url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] URLByAppendingPathComponent:[name stringByAppendingString:ext]];
    NSDictionary *options = [
        NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:YES],
        NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES],
        NSInferMappingModelAutomaticallyOption, nil
    ];
    NSError *err = nil;
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&err]) {
        NSLog(@"Unresolved error : %@", err.localizedDescription);
        abort();
    }
    return persistentStoreCoordinator;
}

@end
