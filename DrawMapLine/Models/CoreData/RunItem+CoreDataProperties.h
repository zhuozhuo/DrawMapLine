//
//  RunItem+CoreDataProperties.h
//  TestDrawMapLine
//
//  Created by aimoke on 16/7/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RunItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RunItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSNumber *timeStamp;
@property (nullable, nonatomic, retain) RunModel *runModel;

@end

NS_ASSUME_NONNULL_END
