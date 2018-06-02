//
//  CoreDataManager.m
//  ScreenOn
//
//  Created by Kerk Chin Wee on 31/5/18.
//  Copyright © 2018 Kerk Chin Wee. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

@synthesize context = _context;
- (NSManagedObjectContext *)context {
    NSString *datastoreName = @"ScreenOn";
    @synchronized(self) {
        if (_context == nil) {
            if (@available(iOS 10, *)) {
                NSPersistentContainer *container = [[NSPersistentContainer alloc] initWithName:datastoreName];
                [container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                    if (error != nil) {
                        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                        abort();
                    }
                }];
                _context = container.viewContext;
                _context.name = datastoreName;
            } else {
                _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
                _context.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] coordinatorWithName:datastoreName WithExt:@".sqlite"];
            }
        }
    }
    return _context;
}

#pragma public functions

+ (instancetype _Nonnull)sharedInstance {
    static CoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataManager alloc] init];
    });
    return sharedInstance;
}

- (void)saveContext {
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)insertForEntity:(NSString * _Nonnull)entityName withParams:(NSDictionary<NSString *, id> *  _Nonnull)params {
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSManagedObject *target = [[NSManagedObject alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:self->_context];
    for (NSString *key in params.allKeys) {
        [target setValue:[params objectForKey:key] forKey:key];
    }
    [self->_context insertObject:target];
}

- (NSArray<NSManagedObject *> * _Nonnull)retrieveEntity:(NSString *  _Nonnull)entityName withQuery:(NSString *  _Nonnull)query andArgs:(NSArray * _Nullable)args {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (![query isEqualToString:@""]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:query argumentArray:args];
        [fetchRequest setPredicate:predicate];
    }
    NSError *error;
    NSArray<NSManagedObject *> *fetchResult = [self.context executeFetchRequest:fetchRequest error:&error];
    return (fetchResult != nil && error == nil) ? fetchResult : [NSArray array];
}

- (void)updateForEntity:(NSString * _Nonnull)entityName withQuery:(NSString * _Nonnull)query andArgs:(NSArray * _Nullable)args targetParams:(NSDictionary<NSString *, id> *  _Nonnull)params {
    NSArray<NSManagedObject *> *fetchResult = [self retrieveEntity:entityName withQuery:query andArgs:args];
    for (NSManagedObject *target in fetchResult) {
        for (NSString *key in params.allKeys) {
            [target setValue:[params objectForKey:key] forKey:key];
        }
    }
}

- (void)deleteForEntity:(NSString * _Nonnull)entityName withQuery:(NSString * _Nonnull)query andArgs:(NSArray * _Nullable)args {
    NSArray<NSManagedObject *> *fetchResult = [self retrieveEntity:entityName withQuery:query andArgs:args];
    for (NSManagedObject *target in fetchResult) {
        [self->_context deleteObject:target];
    }
}

- (void)upsertForEntity:(NSString * _Nonnull)entityName withQuery:(NSString * _Nonnull)query andArgs:(NSArray * _Nullable)args targetParams:(NSDictionary<NSString *, id> * _Nonnull)params {
    NSArray<NSManagedObject *> *fetchResult = [self retrieveEntity:entityName withQuery:query andArgs:args];
    if (fetchResult.count > 0) {
        for (NSManagedObject *target in fetchResult) {
            for (NSString *key in params.allKeys) {
                [target setValue:[params objectForKey:key] forKey:key];
            }
        }
    } else {
        [self insertForEntity:entityName withParams:params];
    }
}

@end
