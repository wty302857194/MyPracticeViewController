//
//  GuangGaoViewController.m
//  MyPracticeViewController
//
//  Created by 杨飞 on 16/9/13.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "GuangGaoViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface GuangGaoViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKPoiSearchDelegate>{
    BMKMapView *map_view;
    //定位服务类
    BMKLocationService *_locService;
    
    //提供位置搜索服务
    
    BMKPoiSearch *poi_search;
    NSMutableArray *_locationArr;

}

@end

@implementation GuangGaoViewController
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _locService.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationArr = [[NSMutableArray alloc] initWithCapacity:0];

    map_view = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    map_view.delegate = self;
    map_view.zoomEnabledWithTap = NO;
//    map_view.zoomLevel=15.475111;
    map_view.mapType = BMKMapTypeStandard;
    map_view.userTrackingMode = BMKUserTrackingModeFollow;
    //显示比例尺
    map_view.showMapScaleBar = YES;
    //缩放等级
    map_view.zoomLevel = 14;
    //显示用户的位置
    map_view.showsUserLocation = YES;
    [self.view addSubview:map_view];
    
    
    //百度地图上添加大头针
    
    BMKPointAnnotation *ann = [[BMKPointAnnotation alloc] init];
    
    ann.coordinate = CLLocationCoordinate2DMake(31.977158, 118.762550);
    
    ann.title = @"兴隆州站";
    
    ann.subtitle = @"长江汇兆基加油站";
    
    [map_view addAnnotation:ann];
    
    

    /***动态定制我的位置样式*/
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc] init];
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    displayParam.isAccuracyCircleShow = NO;//经度圈是否显示
//    displayParam.accuracyCircleFillColor = hexColor(ff4e00);
//    displayParam.accuracyCircleStrokeColor = [UIColor redColor];
    //这里替换自己的图标路径，必须把图片放到百度地图SDK的Resources/mapapi.bundle/images 下面
    //还有一种方法就是获取到_locationView之后直接设置图片
//    displayParam.locationViewImgName=@"default_head";
    [map_view updateLocationViewWithParam:displayParam];
    
    
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //设置距离过滤器(默认距离是米)
//    _locService.distanceFilter = 10;
    _locService.headingFilter = kCLHeadingFilterNone;
    //设置定位精度
    _locService.desiredAccuracy = kCLLocationAccuracyBest;
    //指定定位：是否允许后台定位更新。默认为NO。只在iOS 9.0之后起作用
//    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9) {
//        _locService.allowsBackgroundLocationUpdates = YES;
//    }
    //启动LocationService
    [_locService startUserLocationService];
    
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [UIColor redColor];
        polylineView.lineWidth = 2.0;
        
        return polylineView;
    }
    return nil;
}
//- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[BMKPolyline class]]) {
//        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
//        polylineView.lineWidth = 5;
//        polylineView.isFocus = YES;// 是否分段纹理绘制（突出显示），默认YES
//        //加载分段纹理图片，必须否则不能进行分段纹理绘制
//        [polylineView loadStrokeTextureImages:
//         [NSArray arrayWithObjects:[UIImage imageNamed:@"road_blue_arrow.png"],
//          [UIImage imageNamed:@"road_green_arrow.png"],
//          [UIImage imageNamed:@"road_red_arrow.png"],nil]];
//        return polylineView;
//    }
//    return nil;
//}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
     [map_view updateLocationData:userLocation];
    
    map_view.centerCoordinate = userLocation.location.coordinate;
    
//    CLLocationCoordinate2D loc = [userLocation.location coordinate];
//    
//    //放大地图到自身的经纬度位置。
//    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(loc, BMKCoordinateSpanMake(0.02f,0.02f));
//    BMKCoordinateRegion adjustedRegion = [map_view regionThatFits:viewRegion];
//    [map_view setRegion:adjustedRegion animated:YES];
    
    
    if (_locationArr.count != 0) {
        
        //从位置数组中取出最新的位置数据
        NSString *locationStr = _locationArr.lastObject;
        NSArray *temp = [locationStr componentsSeparatedByString:@","];
        NSString *latitudeStr = temp[0];
        NSString *longitudeStr = temp[1];
        CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake([latitudeStr doubleValue], [longitudeStr doubleValue]);
        
        //当前确定到的位置数据
        CLLocationCoordinate2D endCoordinate;
        endCoordinate.latitude = userLocation.location.coordinate.latitude;
        endCoordinate.longitude = userLocation.location.coordinate.longitude;
        
        //移动距离的计算
        double juli = [self distanceBetweenOrderBy:userLocation.location.coordinate.latitude :[latitudeStr doubleValue] :userLocation.location.coordinate.longitude :[longitudeStr doubleValue]];
        NSLog(@"移动的距离为%f米",juli);
        //为了美化移动的轨迹,移动的位置超过10米,方可添加进位置的数组
        if (juli >= 0){
            NSLog(@"添加进位置数组");
            NSString *locationString = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude];
            [_locationArr addObject:locationString];
            
            //开始绘制轨迹
            CLLocationCoordinate2D pointsToUse[2];
            pointsToUse[0] = startCoordinate;
            pointsToUse[1] = endCoordinate;
            //调用 addOverlay 方法后,会进入 rendererForOverlay 方法,完成轨迹的绘制
            BMKPolyline *lineOne = [BMKPolyline polylineWithCoordinates:pointsToUse count:2];
            [map_view addOverlay:lineOne];
        }else{
            NSLog(@"不添加进位置数组");
        }
    }else{
        
        //存放位置的数组,如果数组包含的对象个数为0,那么说明是第一次进入,将当前的位置添加到位置数组
        NSString *locationString = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude];
        [_locationArr addObject:locationString];
    }
}
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    BMKPinAnnotationView *pinview = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ann"];
    pinview.pinColor = BMKPinAnnotationColorPurple;
    pinview.canShowCallout = YES;
    
    return pinview;
    
    
}

#pragma mark - 距离测算
- (double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //return  distance*1000;
    //返回 m
    return   distance;
}


@end
