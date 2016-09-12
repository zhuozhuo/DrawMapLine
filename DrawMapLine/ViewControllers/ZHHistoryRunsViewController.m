//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/7/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHHistoryRunsViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import <NSDate+DateTools.h>
#import "RunModel+CoreDataProperties.h"
#import "RunItem+CoreDataProperties.h"
#import "ZHMapLineViewController.h"
#import "NSDate+CustomDate.h"


@interface ZHHistoryRunsViewController (){
    NSArray *dataArray;
}

@end

@implementation ZHHistoryRunsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史记录";
    self.showTableView.tableFooterView = [UIView new];
    dataArray = [RunModel MR_findAll];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark － TableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    RunModel *model = [dataArray objectAtIndex:indexPath.row];
    long long timeStamp = [model.startTimeStamp longLongValue];
    NSDate *date = [NSDate getDateWithInterval:timeStamp];
    NSString *timeString = [date formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    double distance = model.distance.doubleValue;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%fm",distance];
    cell.textLabel.text = timeString;
    return cell;
}


#pragma mark - TableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RunModel *model = [dataArray objectAtIndex:indexPath.row];
    ZHMapLineViewController *lineVC = [[ZHMapLineViewController alloc]initWithNibName:@"ZHMapLineViewController" bundle:[NSBundle mainBundle]];
    lineVC.runModel = model;
    [self.navigationController pushViewController:lineVC animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
