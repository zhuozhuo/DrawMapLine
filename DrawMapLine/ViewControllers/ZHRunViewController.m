//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/7/15.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHRunViewController.h"
#import "ZHMapPolylineManager.h"
#import <MagicalRecord/MagicalRecord.h>
#import "RunModel+CoreDataProperties.h"
#import "RunModel+RunModelCategory.h"
#import "RunItem+CoreDataProperties.h"
#import "RunItem+RunItemCategory.h"
#import "RunModel.h"
#import "RunItem.h"
#import "NSDate+CustomDate.h"

@interface ZHRunViewController (){
    RunModel *currentRunModel;
}

@end

@implementation ZHRunViewController


#pragma mark - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跑步";
    self.showLabel.text = @"还未开始跑步";
    self.locations = [NSMutableArray array];
    [self.runButton addTarget:self action:@selector(startOrStopRunAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.runButton setTitle:@"开始跑步" forState:UIControlStateNormal];
    [self.runButton setTitle:@"停止跑步" forState:UIControlStateSelected];
    [self.runButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.runButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AppBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(APPEnterBackGroud:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if (self.locationManager) {
        self.locationManager.delegate = nil;
    }
}

#pragma mark - Private Methods
-(void)saveRunDatas
{
    NSDate *date = [NSDate date];
    long long startTimeStamp = [self.startRunTime getTimeIntervalSince1970Millisecond];
    long long endTimeStamp = [date getTimeIntervalSince1970Millisecond];
    RunModel *runModel = [RunModel MR_createEntity];
    runModel.startTimeStamp = [NSNumber numberWithLongLong:startTimeStamp];
    runModel.endTimeStamp = [NSNumber numberWithLongLong:endTimeStamp];
    for (CLLocation *location in self.locations) {
        double latitude = location.coordinate.latitude;
        double longitude = location.coordinate.longitude;
        long long timeStamp = [location.timestamp getTimeIntervalSince1970Millisecond];
        RunItem *item = [RunItem MR_createEntity];
        item.latitude = [NSNumber numberWithDouble:latitude];
        item.longitude = [NSNumber numberWithDouble:longitude];
        item.timeStamp = [NSNumber numberWithLongLong:timeStamp];
        item.runModel = runModel;
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

-(void)startLocationServer
{
    //定位服务
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.activityType = CLActivityTypeFitness;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;//该模式是抵抗iOS在后台杀死程序设置，iOS会根据当前手机使用状况会自动关闭某些应用程序的后台刷新，该语句申明不能够被暂停，但是不一定iOS系统在性能不佳的情况下强制结束应用刷新
    //定位服务尚未打开
    if (![CLLocationManager locationServicesEnabled]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示", @"提示") message:NSLocalizedString(@"定位服务没打开,请前往设置里面进行设置!", @"定位服务没打开,请前往设置里面进行设置!") delegate:self cancelButtonTitle:NSLocalizedString(@"取消", @"取消") otherButtonTitles:NSLocalizedString(@"前往设置", @"前往设置"), nil];
        alertView.tag = 502;
        [alertView show];
        return;
    }
    CGFloat iOSVersion = [[UIDevice currentDevice].systemVersion floatValue];
    //如果没有授权则请求用户授权 系统8.0＋
    if (iOSVersion>=8.0) {
        // for iOS 8
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [self.locationManager requestWhenInUseAuthorization];
        }

        // for iOS 9
        if ([self.locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)])
        {
            [self.locationManager setAllowsBackgroundLocationUpdates:YES];
        }
    }
    //代理
    self.locationManager.delegate = self;
    //设置精确度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //定位频率，每隔多少米定位一次
    CLLocationDistance distance = 5.0;
    self.locationManager.distanceFilter = distance;
    //启动跟踪定位
    [self.locationManager startUpdatingLocation];
}



#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 502) {
        if (buttonIndex == 1) {//设置
            float systemVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
            if (systemVersion <8.0) {
                NSURL *url = [NSURL URLWithString:@"perfs:root=LOCATION_SERVICES"];
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    [[UIApplication sharedApplication]openURL:url];
                }
            }else{
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }
                
            }
            
        }
        
    }
}


#pragma mark 
#pragma mark －CoreLocationDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];//取出最后一个位置
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSString *string = [NSString stringWithFormat:@"正在跑步更新经纬度longtitude:%f---latitude:%f",coordinate.longitude,coordinate.latitude];
    self.showLabel.text = string;
    NSDate *date = [NSDate date];
    long long timeStamp = [date getTimeIntervalSince1970Millisecond];
    CLLocation *lastLocation = [self.locations lastObject];
    if (!lastLocation) {
        [self.locations addObject:location];
    }else{
        long long lastTimeStamp = [lastLocation.timestamp getTimeIntervalSince1970Millisecond];
        if (lastTimeStamp != timeStamp) {//时间相同不存储
            [self.locations addObject:location];
            CGFloat distance = [location distanceFromLocation:lastLocation];
            self.totalDistance += distance;
        }
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
#pragma mark - User Interact
- (void)startOrStopRunAction:(id)sender {
    UIButton *button = sender;
    if (!button.selected) {
        if (self.locationManager) {
            [self.locationManager startUpdatingLocation];
        }else{
            [self startLocationServer];
        }
        self.startRunTime = [NSDate date];
        
    }else{
        if (self.locationManager) {
            [self.locationManager stopUpdatingLocation];
            [self saveRunDatas];
        }
       
    }
    button.selected = !button.selected;
    
}



#pragma mark - Notification
-(void)AppBecomeActive:(NSNotification *)notification
{
    if ([CLLocationManager significantLocationChangeMonitoringAvailable])
    {
        [self.locationManager stopMonitoringSignificantLocationChanges];
        [self.locationManager startUpdatingLocation];
    }
}

-(void)APPEnterBackGroud:(NSNotification *)notification
{
    
    if (CLLocationManager.significantLocationChangeMonitoringAvailable) {
        if (self.locationManager) {
            [self.locationManager stopUpdatingLocation];
            [self.locationManager startMonitoringSignificantLocationChanges];
        }
        
    }else{
        
        NSLog(@"Significant location change monitoring is not available.");
        
    }
    
}
@end
