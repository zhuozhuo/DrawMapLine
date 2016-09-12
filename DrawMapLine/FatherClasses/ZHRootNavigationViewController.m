//
//  ZHRootNavigationViewController.m
//  TestDrawMapLine
//
//  Created by aimoke on 16/7/15.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHRootNavigationViewController.h"

@interface ZHRootNavigationViewController ()

@end

@implementation ZHRootNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithRed:50.0/255 green:54.0/255 blue:56.0/255 alpha:1.0];;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
