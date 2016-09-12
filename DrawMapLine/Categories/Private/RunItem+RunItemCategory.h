//
//  RunItem+ZHRunItemCategory.h
//  TestDrawMapLine
//
//  Created by aimoke on 16/7/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "RunItem.h"

@interface RunItem (RunItemCategory)
/**
 *  新建一个RunItem
 *
 *  @return runItem instance
 */
+(RunItem *)createRunItem;

/**
 *  配置runItem属性
 *
 *  @param block bock回调
 */
-(void)configureAttributeWithBlock:(void(^)(RunItem *runItemSelf))block;

@end
