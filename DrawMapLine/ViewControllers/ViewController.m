//
//  ViewController.m
//  TestDrawMapLine
//
//  Created by aimoke on 16/7/13.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ViewController.h"
#import "ZHRunViewController.h"
#import "ZHHistoryRunsViewController.h"


@interface ViewController ()
{
    NSArray *dataArray;
}

@end

@implementation ViewController

#pragma mark - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Run";
    self.showTableView.tableFooterView = [UIView new];
    dataArray = @[@"跑步",@"历史记录"];
    // Do any additional setup after loading the view, typically from a nib.
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - TableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZHRunViewController *runVC = [[ZHRunViewController alloc]initWithNibName:@"ZHRunViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:runVC animated:YES];
    }else if (indexPath.row == 1){
        ZHHistoryRunsViewController *historyRunVC = [[ZHHistoryRunsViewController alloc]initWithNibName:@"ZHHistoryRunsViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:historyRunVC animated:YES];
    }
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



@end
