//
//  FF_CoreDateManager.m
//  FF_SimpleWaterLayout
//
//  Created by 9188iMac on 16/5/25.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "FF_CoreDateManager.h"

static NSString * const FF_CoreDateManagerDBName = @"PersonCD";

@implementation FF_CoreDateManager

+ (instancetype)shareCoreDateManager{
    static FF_CoreDateManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (NSManagedObjectModel *)model{
    if (!_model) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:FF_CoreDateManagerDBName withExtension:@"momd"];
        NSAssert(url, @"没有得到coreData");
        _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    }
    return _model;
}

- (NSPersistentStoreCoordinator *)coordinator{
    if (!_coordinator) {
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        NSString *dbName = [NSString stringWithFormat:@"%@.sqlit", FF_CoreDateManagerDBName];
        NSURL * DBURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:dbName];
        NSError *error = nil;
        [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:DBURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    }
    return _coordinator;
}

- (NSManagedObjectContext *)context{
    if (!_context) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:self.coordinator];
    }
    return _context;
}

- (void)save{
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"数据库save操作失败 -> %@", error);
    }
}

- (NSManagedObject *)managedObjectWithCoreDataTableName:(NSString *)tableName{
    NSEntityDescription * description = [NSEntityDescription entityForName:tableName inManagedObjectContext:self.context];
    return [[NSManagedObject alloc] initWithEntity:description insertIntoManagedObjectContext:self.context];
}

- (void)write:(NSManagedObject *)object{
    [self.context insertObject:object];
    [self save];
}

- (NSArray<NSManagedObject *> *)readAllDataFromTable:(NSString *)tableName{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:tableName];
    NSError * error = nil;
    NSArray * arr = [self.context executeFetchRequest:request error:&error];
    [self save];
    if (error) {
        NSLog(@"数据读取失败 -> %@", error);
    }
    return arr;
}

@end
