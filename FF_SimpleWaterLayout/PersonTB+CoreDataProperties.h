//
//  PersonTB+CoreDataProperties.h
//  FF_SimpleWaterLayout
//
//  Created by 9188iMac on 16/5/25.
//  Copyright © 2016年 9188iMac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonTB.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonTB (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *aId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *age;

@end

NS_ASSUME_NONNULL_END
