//
//  FF_CoreDateManager.h
//  FF_SimpleWaterLayout
//
//  Created by 9188iMac on 16/5/25.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface FF_CoreDateManager : NSObject
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, strong) NSManagedObjectModel *model;
+ (instancetype)shareCoreDateManager;
- (void)save;
/**
 *  从表名得到Object
 */
- (NSManagedObject *)managedObjectWithCoreDataTableName:(NSString *)tableName;
/**
 *  保存
 */
- (void)write:(NSManagedObject *)object;
/**
 *  读取
 */
- (NSArray<NSManagedObject *> *)readAllDataFromTable:(NSString *)tableName;
@end
