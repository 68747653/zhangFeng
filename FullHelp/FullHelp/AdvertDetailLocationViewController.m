//
//  AdvertDetailLocationViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AdvertDetailLocationViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface AdvertDetailLocationViewController ()<BMKMapViewDelegate>
@property (nonatomic,assign) CGFloat latitude,longitude;
@property (nonatomic,strong) BMKMapView *mapView;

@end

@implementation AdvertDetailLocationViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude{
    if(self = [super init]){
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"位置";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    
    _mapView=[[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64)];
    
    CLLocationCoordinate2D center;
    center.latitude = _latitude;
    center.longitude = _longitude;
    _mapView.centerCoordinate = center;
    _mapView.delegate = self;
    [_mapView setZoomLevel:18];
    [self.view addSubview:_mapView];
    
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
    pointAnnotation.coordinate = center;
    [_mapView addAnnotation:pointAnnotation];
    _mapView.showMapScaleBar=YES;//是否显示比例尺
}
#pragma mark -- BMKMapViewDelegate  自定义大头针
-(BMKAnnotationView *)mapView:(BMKMapView *)theMapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        static NSString *identifier = @"myAnnotation";
        BMKAnnotationView *newAnnotationView=[[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        newAnnotationView.image = [UIImage imageNamed:@"pin_red.png"];
        newAnnotationView.canShowCallout=YES;
        [newAnnotationView setSelected:YES animated:YES];
        
        return newAnnotationView;
    }else{
        return nil;
    }
}

@end
