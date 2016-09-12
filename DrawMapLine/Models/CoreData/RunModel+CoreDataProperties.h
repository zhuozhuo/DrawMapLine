//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/7/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RunModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RunModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *averageSpeed;
@property (nullable, nonatomic, retain) NSNumber *startTimeStamp;
@property (nullable, nonatomic, retain) NSNumber *distance;
@property (nullable, nonatomic, retain) NSNumber *endTimeStamp;
@property (nullable, nonatomic, retain) NSSet<RunItem *> *items;

@end

@interface RunModel (CoreDataGeneratedAccessors)

- (void)addItemsObject:(RunItem *)value;
- (void)removeItemsObject:(RunItem *)value;
- (void)addItems:(NSSet<RunItem *> *)values;
- (void)removeItems:(NSSet<RunItem *> *)values;

@end

NS_ASSUME_NONNULL_END
