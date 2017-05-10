//
//  XHQFoundMoreViewController.m
//  AutoHome
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "XHQFoundMoreViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "XHQFoundAnnotation.h"

@interface XHQFoundMoreViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)MKMapView *map;
@end

@implementation XHQFoundMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 运用GPS定位
    [self location];
    // 添加地图
    [self addMapView];
    // 添加大头针
    [self addAnnotation];
    // 给地图添加手势
    [self addGesture];
    // 画圆
    [self drawCircle];
    
}
/** GPS定位 */
- (void)location {
    // 1. 定位, 需要引入一个系统的头文件
    // 2. 定位, 是用 CLLocationManager 对象来实现的
    self.locationManager = [[CLLocationManager alloc] init];
    
    // 3. 判断定位服务是否可用
    if ([CLLocationManager locationServicesEnabled]) {
        
        // 4. 问用户要授权
        // 一直获取定位信息
        // 在iOS 8以后, 如果想获取定位, 需要在plist文件中,设置授权弹窗要显示的内容
        //        [self.locationManager requestAlwaysAuthorization];
        
        // 使用期间定位
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // 设置位置发生变动的时候回调
    self.locationManager.delegate = self;
    
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // 设置位置变更精度, 单位米
    self.locationManager.distanceFilter = 10;
    
    // 开启位置变更监控
    [self.locationManager startUpdatingLocation];
}
/** 添加地图 */
- (void)addMapView {
    // 1. 实例化地图
    self.map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    // 2. 添加
    [self.view addSubview:self.map];
    
    // 在地图上做操作, 是需要由协议方法来控制的
    self.map.delegate = self;
    
    // 3. 设置地图显示的范围
    
    // 1. 坐标
    self.map.region = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 1000, 1000);
    
    // 4. 在地图上, 显示自己的位置
    self.map.showsUserLocation = YES;
}

/** 添加大头针 */
- (void)addAnnotation {
    // 实例化一个大头针, 主要作用是显示一个具体的位置
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    // 设置一个坐标, 要放置的位置
    point.coordinate = self.locationManager.location.coordinate;
    
   // point.coordinate = CLLocationCoordinate2DMake(+40.11526845,+116.24564781);
   // point.coordinate = CLLocationCoordinate2DMake(40.11526845,116.24564781);
    // 设置大头针标题
    point.title = @"我现在的位置";
    
    
    
    // 把大头针添加到地图上
    [self.map addAnnotation:point];
    
}

/** 给地图添加一个长按手势 */
- (void)addGesture {
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressAction:)];
    [self.map addGestureRecognizer:press];
}
- (void)pressAction:(UILongPressGestureRecognizer *)ges {
    if (ges.state == UIGestureRecognizerStateBegan) {
        // 长按开始
        // 1. 需要拿到点击点击的这个点, 相对于视图的坐标
        CGPoint point = [ges locationInView:ges.view];
        
        // 2. 把这个点坐标, 转换成经纬度坐标
        CLLocationCoordinate2D coordinate = [self.map convertPoint:point toCoordinateFromView:self.map];
        
        
        // 添加大头针
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = coordinate;
        
        annotation.title = @"我现在的位置";
       [self.map addAnnotation:annotation];
       
    }
}

/** 画圆 */
- (void)drawCircle {
    // 半径的单位是
    MKCircle *cicle = [MKCircle circleWithCenterCoordinate:self.locationManager.location.coordinate radius:500];
    
    // 添加覆盖物
    [self.map addOverlay:cicle];
}

#pragma mark ----- 定位服务的协议 -----
// 位置发生变更时候的回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // CLLocation是一个位置对象, 里面包含有经度, 纬度
    CLLocation *location = locations.firstObject;
    
    NSLog(@"%@", location);
    
}

#pragma mark ----- 地图的协议 -----
// 只要在地图上添加覆盖物, 就会触发这个方法
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    // 根据不同的覆盖物, 区分不同的操作
    if ([overlay isKindOfClass:[MKCircle class]]) {
        // 实例化一个绘制工具
        MKCircleRenderer *render = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        
        // 画笔颜色
        render.strokeColor = [UIColor redColor];
        // 线宽
        render.lineWidth = 2;
        // 填充颜色
        render.fillColor = [UIColor greenColor];
        
        render.alpha = 0.2;
        
        return render;
    }
        
    return nil;
}



// 大头针和cell类似, 都需要做复用
// 每当地图上需要显示一个标记视图的时候, 调用
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // 从复用池取大头针
    
    
//    for(XHQFoundAnnotation *view in mapView.subviews)
//    {
//        [view removeFromSuperview];
//    }
    
    XHQFoundAnnotation *ann = (XHQFoundAnnotation *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ann"];
    // 如果取不到, 就实例化一个新的
    if (ann == nil) {
        ann = [[XHQFoundAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"ann"];
    }
    else {
        // 修改显示的信息
        ann.annotation = annotation;
    }
    return ann;
}
// 气泡两侧视图被点击触发
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    // 1. 获取大头针
    MKPointAnnotation *point =   view.annotation;
    
    [XHQAuxiliary alertWithTitle:@"温馨提示" message: point.title button:0 done:0 ];
    
}






@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com