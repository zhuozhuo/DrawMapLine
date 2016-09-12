//
//  ZHRunViewController.h
//  TestDrawMapLine
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
