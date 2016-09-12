//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/7/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ZHMapPolylineManager : NSObject
+(ZHMapPolylineManager *)shareZHMapPolylineManager;

/*国内地图使用的坐标系统是GCJ-02而iOS SDK中所用到的是国际标准的坐标系统WGS-84,所以需要把国际标准转换为国内标准*/

//判断是否已经超出中国范围
+ (BOOL)outOfChina:(CLLocation *)location;

//转GCJ-02 CLLocation
+ (CLLocation *)transformToMars:(CLLocation *)location;

//转GCJ-02 CLLocationCoordinate2D
+(CLLocationCoordinate2D)transFormToMarsCLLocationCoordinate2D:(CLLocationCoordinate2D )coordinate;

@end
