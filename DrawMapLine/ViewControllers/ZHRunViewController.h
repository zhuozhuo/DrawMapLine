//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/7/15.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ZHRootViewController.h"

@interface ZHRunViewController : ZHRootViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *locations;
@property (assign, nonatomic) CGFloat totalDistance;//跑步的距离
@property (strong, nonatomic) NSDate *startRunTime;//跑步开始时间
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *runButton;

- (void)startOrStopRunAction:(id)sender;




@end
