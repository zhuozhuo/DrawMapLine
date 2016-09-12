//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
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
