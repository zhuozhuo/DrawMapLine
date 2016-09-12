//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/7/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "RunModel.h"

@interface RunModel (RunModelCategory)

/**
 *  新建一个runmodel
 *
 *  @return runmodel instance
 */
+(RunModel *)createRunModel;

/**
 *  配置runmodel属性
 *
 *  @param block bock回调
 */
-(void)configureAttributeWithBlock:(void(^)(RunModel *runModelSelf))block;

@end
