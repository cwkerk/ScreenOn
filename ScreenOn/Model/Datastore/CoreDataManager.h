//
//  CoreDataManager.h
//  ScreenOn
//
//  Created by Kerk Chin Wee on 31/5/18.
//  Copyright © 2018 Kerk Chin Wee. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "NSPersistentStoreCoordinator+ext.h"

@interface CoreDataManager : NSObject

@property (readonly, strong, nonnull) NSManagedObjectContext *context;

+ (instancetype _Nonnull)sharedInstance;

- (void)saveContext;

- (void)insertForEntity:(NSString * _Nonnull)entityName withParams:(NSDictionary<NSString *, id> *  _Nonnull)params;

- (NSArray<NSManagedObject *> * _Nonnull)retrieveEntity:(NSString *  _Nonnull)entityName withQuery:(NSString *  _Nonnull)query andArgs:(NSArray * _Nullable)args;

- (void)updateForEntity:(NSString * _Nonnull)entityName withQuery:(NSString * _Nonnull)query andArgs:(NSArray * _Nullable)args targetParams:(NSDictionary<NSString *, id> *  _Nonnull)params;

- (void)deleteForEntity:(NSString * _Nonnull)entityName withQuery:(NSString * _Nonnull)query andArgs:(NSArray * _Nullable)args;

- (void)upsertForEntity:(NSString * _Nonnull)entityName withQuery:(NSString * _Nonnull)query andArgs:(NSArray * _Nullable)args targetParams:(NSDictionary<NSString *, id> * _Nonnull)params;

@end
