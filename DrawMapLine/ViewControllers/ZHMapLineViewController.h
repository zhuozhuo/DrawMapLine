//
//  ZHMapLineViewController.h
//  TestDrawMapLine
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
