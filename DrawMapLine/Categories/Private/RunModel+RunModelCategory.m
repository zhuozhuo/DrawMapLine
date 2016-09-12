//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
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
