//
//  DiscoverNearByViewController.m
//  HWWeiBo
//
//  Created by Mac on 15/9/2.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "DiscoverNearByViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DataService.h"

#import "WeiboAnnotation.h"

#import "WeiboAnnotationView.h"

#import "DetailViewController.h"
/*
 
 
 显示地图标注 步骤
 1 定义Annotation类（model）
 2 创建Annotation对象 ，把对象添加到mapView上
 3 实现 mapView的协议方法，创建标注视图
 
 
 */

@interface DiscoverNearByViewController ()<CLLocationManagerDelegate>
{
    
    CLLocationManager *_locationManager;

    MKMapView *_mapView;
    
    
    NSString *latitude;
    NSString *longitude;
}
@end

@implementation DiscoverNearByViewController


-(instancetype)init
{
    self=[super init];
    if (self)
    {
         self.hidesBottomBarWhenPushed=YES;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self _createViews];

    self.title=@"附近的微博";
  
   
    
    [self _location];
    
    
    
}

#pragma mark -  地图
-(void)_createViews
{
    
    _mapView=[[MKMapView alloc]initWithFrame:self.view.bounds];
    //显示用户位置
    _mapView.showsUserLocation=YES;
    //地图显示类型
    _mapView.mapType=MKMapTypeStandard;
    //代理
    _mapView.delegate=self;
    
    [self.view addSubview:_mapView];
   
    //添加 新坐标
//    WeiboAnnotation *annotation=[[WeiboAnnotation alloc]init];
////    annotation.title=@"汇文教育";
//    CLLocationCoordinate2D coordinate={30.315298,120.340931};
//    annotation.coordinate=coordinate;
//    [_mapView addAnnotation:annotation];

    
    
    
}




#pragma mark -  定位
-(void)_location
{
    if (_locationManager==nil)
    {
        _locationManager=[[CLLocationManager alloc]init];
        
        
        if (kVersion>8.0)
        {
            
            //获取授权使用地理位置服务
            [_locationManager requestWhenInUseAuthorization];
            
            
            
            
            
        }
        
    }
    
    //定位精确度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    _locationManager.delegate=self;
    
    [_locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    //停止定位
    [_locationManager stopUpdatingLocation];
    
      //2 请求数据
    CLLocation *location=[locations lastObject];
    
    
    CLLocationCoordinate2D coordinate=location.coordinate;
    
    NSLog(@"%lf  %lf",coordinate.latitude,coordinate.longitude);
    
    latitude=[NSString stringWithFormat:@"%f",coordinate.latitude ];
    longitude=[NSString stringWithFormat:@"%f",coordinate.longitude ];
    
    

    
    //地图
    CLLocationCoordinate2D center=coordinate;
    MKCoordinateSpan span={0.1,0.1};
    MKCoordinateRegion region={center,span};
    [_mapView setRegion:region];
    
    
    
    //下载数据
    [self _loadData];
    
    
}

-(void)_loadData
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:latitude forKey:@"lat"];
    [params setValue:longitude forKey:@"long"];
    
    [DataService requestAFUrl:nearby_timeline httpMethod:@"GET" params:params datas:nil block:^(id result) {
        
        NSArray *statuses=[result objectForKey:@"statuses"];
        
        NSMutableArray *annotationArray=[[NSMutableArray alloc]init];
        
        
        for ( NSDictionary *dataDic in statuses)
        {
            WeiboModel *model=[[WeiboModel alloc]initWithDataDic:dataDic];
            
            
            WeiboAnnotation *annotation=[[WeiboAnnotation alloc]init];
            annotation.weiboModel=model;
            
            
            
            
          [annotationArray addObject:annotation];
            
        }
        
        [_mapView addAnnotations:annotationArray];
        
        
      
    }];
}




//大头针 例子

/*
//实现返回视图
//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    
////    MKUserLocation用户当前位置类(直接 return nil; 默认 当前用户是圈，其他是大头针 )
//    if([annotation isKindOfClass:[MKUserLocation class]])
//    {
//        return nil;
//        
//    }
//    
//    MKPinAnnotationView *pinView=(MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
//    if (pinView==nil)
//    {
//        pinView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view"];
//        
//        
//        pinView.pinColor=MKPinAnnotationColorGreen;
//        
//        
//        //2从天而降
//        pinView.animatesDrop=YES;
//        
//        
//        //3设置显示标题
//        pinView.canShowCallout=YES;
//        //添加辅助视图
//        pinView .rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        
//        
//        
//        
//        
//    }
//    return pinView;
//    
//}
 
*/

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;

    }
    
    
    
    WeiboAnnotationView *annotationView=(WeiboAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view1"];
    if (annotationView==nil) {
        
        annotationView =[[WeiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view1"];
        
    }
    
    //复用再传
    annotationView.annotation=annotation;
    
    
    return annotationView;
    
}



//选中标注视图的协议方法
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"选中");
    // return;
    
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    WeiboAnnotation *annoation = (WeiboAnnotation *)view.annotation;
    WeiboModel *weiboModel = annoation.weiboModel;
    
    detailVC.weiboModel = weiboModel;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
