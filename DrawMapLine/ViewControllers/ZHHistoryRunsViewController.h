//
//  ZHHistoryRunsViewController.h
//  TestDrawMapLine
//
//  Created by aimoke on 16/7/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHRootViewController.h"

@interface ZHHistoryRunsViewController : ZHRootViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *showTableView;

@end
