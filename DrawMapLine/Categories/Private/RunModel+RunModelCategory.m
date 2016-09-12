//
//  RunModel+RunModelCategory.m
//  TestDrawMapLine
//
//  Created by aimoke on 16/7/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "RunModel+RunModelCategory.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation RunModel (RunModelCategory)

+(RunModel *)createRunModel
{
    RunModel *runModel = [RunModel MR_createEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    return runModel;
}


-(void)configureAttributeWithBlock:(void (^)(RunModel *))block
{
     block(self);
     [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}
@end
