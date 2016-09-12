//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/7/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHRootViewController.h"
#import <MapKit/MapKit.h>
#import "RunModel.h"

struct lineColorStruct {
    double r;
    double g;
    double b;
};
typedef struct lineColorStruct colorStruct;

@interface ZHMapLineViewController : ZHRootViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) RunModel *runModel;
@property (nonatomic,strong) NSMutableArray *rePlayArray;

@end
