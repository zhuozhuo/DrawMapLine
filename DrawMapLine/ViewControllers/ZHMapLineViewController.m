//
//  GitHub:https://github.com/zhuozhuo

//  博客：http://www.jianshu.com/users/39fb9b0b93d3/latest_articles

//  欢迎投稿分享：http://www.jianshu.com/collection/4cd59f940b02
//
//  Created by aimoke on 16/7/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHMapLineViewController.h"
#import "RunModel+CoreDataProperties.h"
#import "RunItem+CoreDataProperties.h"
#import "ZHMapAnnotation.h"
#import "ZHPolyline.h"
#import "ZHMapPolylineManager.h"


@interface ZHMapLineViewController ()
{
    MKPolyline *routeLine;
    MKPolylineView *routeLineView;
    NSMutableArray *speeds;//所有线路的速度集合
    double minSpeed;
    double maxSpeed;
    double meanSpeed;// now knowing the slowest+fastest, we can get mean too
   
}

@end

@implementation ZHMapLineViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"路线";
    
    
    self.rePlayArray = [NSMutableArray array];
    speeds = [NSMutableArray array];
    minSpeed = 0.0;
    maxSpeed = 0.0;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.delegate = self;
    [self initialData];//画线
    
    // Do any additional setup after loading the view from its nib.
}


#pragma mark initalData
-(void)initialData
{
    if (self.runModel) {
        NSSet *items = self.runModel.items;
        NSLog(@"itemsCount:%ld",(long)items.count);
       
        if (items.count>0) {
            NSSortDescriptor *sd = [[NSSortDescriptor alloc]initWithKey:@"timeStamp" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObjects:sd, nil];
            NSArray *sortedArray = [items sortedArrayUsingDescriptors:sortDescriptors];
            
            //[self drawLineWithLocationArray:sortedArray];
            [self getAllSeepsWithLocationArray:sortedArray];//此函数一定得在画线前面调用
            
            [self addAnnotationWithArray:sortedArray];
            [self setMapReginWithArray:sortedArray];
            NSArray *polylines = [self getAllMapPolylineWithLocationArray:sortedArray];
            [self.mapView addOverlays:polylines];
        }
    }

}

-(void)dealloc
{
    self.mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark draw map line Not Use this function
-(void)drawLineWithLocationArray:(NSArray *)items
{
    double beginLongitudes = 0.0;
    double beginlatitudes = 0.0;
    // create a c array of points.
    MKMapPoint *pointArray = malloc(sizeof(CLLocationCoordinate2D)*items.count);
    for(int idx = 0; idx < items.count; idx++)
    {
        RunItem *item = [items objectAtIndex:idx];
        CLLocationDegrees latitude  = item.latitude.doubleValue;
        CLLocationDegrees longitude = item.longitude.doubleValue;
        long long timeStamp = item.timeStamp.longLongValue;
        NSLog(@"timeStamp:%lld",timeStamp);
        // create our coordinate and add it to the correct spot in the array
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        pointArray[idx] = point;
        //起始点作为中心点展示
        if (idx == 0) {
            beginlatitudes = latitude;
            beginLongitudes = longitude;
        }
    }
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(beginlatitudes, beginLongitudes);
    // 设置地图的显示范围
    MKCoordinateSpan span = MKCoordinateSpanMake(0.001, 0.001);//数值越小地图放的越大（地理位置越详细），位置越精确
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);//设置地图中心点为当前定位到的位置
    [self.mapView setRegion:region animated:YES];
    
    if (routeLine) {
        [_mapView removeOverlay:routeLine];
    }
    routeLine = [MKPolyline polylineWithPoints:pointArray count:items.count];
    // add the overlay to the map
    if (nil != routeLine) {
        [_mapView addOverlay:routeLine];
    }
    // clear the memory allocated earlier for the points
    free(pointArray);
}


#pragma mark Set Map center
-(void)setMapReginWithArray:(NSArray *)items
{
    RunItem *firstItem = [items firstObject];
    double minLat = firstItem.latitude.doubleValue;
    double minLng = firstItem.longitude.doubleValue;
    double maxLat = minLat;
    double maxLng = minLng;
    
    for (RunItem *item in items) {
        double lat = item.latitude.doubleValue;
        double lng = item.longitude.doubleValue;
        minLat = MIN(minLat, lat);
        minLng = MIN(minLng, lng);
        maxLat = MAX(maxLat, lat);
        maxLng = MAX(maxLng, lng);
    }
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((minLat + maxLat)/2.0, (minLng + maxLng)/2.0);
    NSLog(@"minLat:%f---maxLat:%f----minLng:%f---maxLng:%f---centerLat:%f---centerLng:%f",minLat,maxLat,minLng,maxLng,center.latitude,center.longitude);
    
    center = [ZHMapPolylineManager transFormToMarsCLLocationCoordinate2D:center];
    
    MKCoordinateSpan span = MKCoordinateSpanMake((maxLat-minLat)*1.3, (maxLng-minLng)*1.3);
    [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
}



#pragma mark - Add Annotation
-(void)addAnnotationWithArray:(NSArray *)items
{
    NSMutableArray *annotations = [NSMutableArray array];
    for(int idx = 0; idx < items.count; idx++)
    {
        if (idx == 0 || idx == (items.count-1))//其实和结束添加Annotation
        {
            RunItem *item = [items objectAtIndex:idx];
            CLLocationDegrees latitude  = item.latitude.doubleValue;
            CLLocationDegrees longitude = item.longitude.doubleValue;
            // create our coordinate and add it to the correct spot in the array
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            coordinate = [ZHMapPolylineManager transFormToMarsCLLocationCoordinate2D:coordinate];
            
            ZHMapAnnotation *mapAnnotation = [[ZHMapAnnotation alloc]initWithTitle:[NSString stringWithFormat:@"%ld",(long)(idx+1)] subtitle:nil andCoordinate:coordinate];
            [annotations addObject:mapAnnotation];
        }
    }
    [self.mapView addAnnotations:annotations];
}



#pragma mark MKMapViewDelegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *annotationIdentifier = @"DZNMapViewAnnotation";
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    view.canShowCallout = NO;
    view.pinColor = MKPinAnnotationColorRed;
    view.animatesDrop = YES;
    return view;
}



- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    ZHPolyline *polyline = (ZHPolyline *)overlay;
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:polyline];
    renderer.strokeColor = polyline.color;
    renderer.lineWidth = 4.0;
    return  renderer;
}



#pragma mark - Private Methods
-(void)getAllSeepsWithLocationArray:(NSArray *)items
{
    for(int idx = 1; idx < items.count; idx++)
    {
        RunItem *preItem = [items objectAtIndex:(idx-1)];
        RunItem *laterItem = [items objectAtIndex:idx];
        CLLocationDegrees PreLatitude  = preItem.latitude.doubleValue;
        CLLocationDegrees PreLongitude = preItem.longitude.doubleValue;
        long long PreTimeStamp = preItem.timeStamp.longLongValue;
        
        CLLocationDegrees laterLatitude  = laterItem.latitude.doubleValue;
        CLLocationDegrees laterLongitude = laterItem.longitude.doubleValue;
        long long laterTimeStamp = laterItem.timeStamp.longLongValue;
        
        CLLocation *preLocation = [[CLLocation alloc]initWithLatitude:PreLatitude longitude:PreLongitude];
        CLLocation *laterLocation = [[CLLocation alloc]initWithLatitude:laterLatitude longitude:laterLongitude];
        preLocation = [ZHMapPolylineManager transformToMars:preLocation];
        laterLocation = [ZHMapPolylineManager transformToMars:laterLocation];
        
        double distance = [laterLocation distanceFromLocation:preLocation];
        distance = fabs(distance);
        long long seconds = (laterTimeStamp - PreTimeStamp)/1000;
        double speed = distance/seconds;
        minSpeed = MIN(minSpeed, speed);
        maxSpeed = MAX(maxSpeed, speed);
        [speeds addObject:[NSNumber numberWithDouble:speed]];
    }
    meanSpeed = (minSpeed + maxSpeed)/2;
}



-(NSArray *)getAllMapPolylineWithLocationArray:(NSArray *)items
{
//    colorStruct red = {255.0/255,20.0/255.0,44.0/255.0};
//    colorStruct yellow = {255.0/255,215.0/255.0,0.0/255.0};
//    colorStruct green = {0.0/255,146.0/255.0,78.0/255.0};
    colorStruct red = {255.0/255,106.0/255.0,106.0/255.0};
    colorStruct yellow = {255.0/255,144.0/255.0,0.0/255.0};
    colorStruct green = {90.0/255,230.0/255.0,160.0/255.0};

    
    NSMutableArray *polylines = [NSMutableArray array];
    for(int idx = 1; idx < items.count; idx++)
    {
     
        RunItem *preItem = [items objectAtIndex:(idx-1)];
        RunItem *laterItem = [items objectAtIndex:idx];
        CLLocationDegrees PreLatitude  = preItem.latitude.doubleValue;
        CLLocationDegrees PreLongitude = preItem.longitude.doubleValue;
        CLLocationDegrees laterLatitude  = laterItem.latitude.doubleValue;
        CLLocationDegrees laterLongitude = laterItem.longitude.doubleValue;
        CLLocationCoordinate2D preCoordinate2D = CLLocationCoordinate2DMake(PreLatitude, PreLongitude);
        CLLocationCoordinate2D laterCoordinate2D = CLLocationCoordinate2DMake(laterLatitude, laterLongitude);
        CLLocationCoordinate2D coordinates[2];
        preCoordinate2D = [ZHMapPolylineManager transFormToMarsCLLocationCoordinate2D:preCoordinate2D];
        laterCoordinate2D = [ZHMapPolylineManager transFormToMarsCLLocationCoordinate2D:laterCoordinate2D];
        
        coordinates[0] = preCoordinate2D;
        coordinates[1] = laterCoordinate2D;
        CGFloat speed = 0.0;
        if (speeds.count>idx) {
            speed = fabs([[speeds objectAtIndex:idx]doubleValue]);
        }
        UIColor *color = [UIColor blueColor];
        if (speed < minSpeed) {// Between Red & Yellow
            double ratio = (speed - minSpeed)/(meanSpeed - minSpeed);
            double r = (red.r + ratio*(yellow.r - red.r));
            double g = (red.g + ratio*(yellow.g - red.g));
            double b = (red.b + ratio*(yellow.b - red.b));
            color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
        }else{// Between Yellow & Green
             double ratio = (speed - minSpeed)/(maxSpeed - meanSpeed);
            double r = (yellow.r + ratio*(green.r - yellow.r));
            double g = (yellow.g + ratio*(green.g - yellow.g));
            double b = (red.r + ratio*(green.b - yellow.b));
            color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
        }
        ZHPolyline *polyline = [ZHPolyline polylineWithCoordinates:coordinates count:2];
        polyline.color = color;
        [polylines addObject:polyline];
    }
    return polylines;
    
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
