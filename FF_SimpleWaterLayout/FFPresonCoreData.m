//
//  FFPresonCoreData.m
//  FF_SimpleWaterLayout
//
//  Created by 9188iMac on 16/5/25.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "FFPresonCoreData.h"
#import "PersonTB.h"
@implementation FFPresonCoreData
- (void)write{
    PersonTB *tb = (PersonTB *)[self managedObjectWithCoreDataTableName:@"PersonTB"];
    tb.age = [NSString stringWithFormat:@"%zi", arc4random() % 100 + 10];
    tb.name = @"小花";
    tb.aId = [NSString stringWithFormat:@"%zi", arc4random() % 100 + 1000];
    [self write:tb];
}

- (void)read{
    NSArray *arr = [self readAllDataFromTable:@"PersonTB"];
    for (NSManagedObject *object in arr) {
        PersonTB *tb = (PersonTB *)object;
        NSLog(@"aid = %@, name = %@, age = %@", tb.aId, tb.name, tb.age);
    }
}
@end
