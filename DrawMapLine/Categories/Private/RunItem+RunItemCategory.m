//
//  RunItem+ZHRunItemCategory.m
//  TestDrawMapLine
//
//  Created by aimoke on 16/7/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "RunItem+RunItemCategory.h"
#import <MagicalRecord/MagicalRecord.h>
@implementation RunItem (ZHRunItemCategory)

+(RunItem *)createRunItem
{
    RunItem *item = [RunItem MR_createEntity];
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    return item;
}


-(void)configureAttributeWithBlock:(void (^)(RunItem *))block
{
    block(self);
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}


@end
