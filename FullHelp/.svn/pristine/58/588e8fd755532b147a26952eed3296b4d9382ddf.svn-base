//
//  EditAddressViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "EditAddressViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "UserCenterNetWorkEngine.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "LocationInfo.h"
#import "AddressInfo.h"

@interface EditAddressViewController () <BMKMapViewDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic,assign) CGFloat latitude,longitude;
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic, strong) AddressInfo *addressInfo;
@property (nonatomic, strong) HHSoftLabel *addressLabel;
@property (nonatomic, strong) UITextField *houseNumberTextField;
@property (nonatomic, copy) EditAddressBlock editAddressBlock;
@property (nonatomic, assign) AddressViewType viewType;
@property (nonatomic, strong) BMKGeoCodeSearch *geocoder;
@property (nonatomic, strong) BMKReverseGeoCodeOption *option;

@end

@implementation EditAddressViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithAddressInfo:(AddressInfo *)addressInfo editAddressBlock:(EditAddressBlock)editAddressBlock viewType:(AddressViewType)viewType {
    if (self = [super init]) {
        _addressInfo = addressInfo;
        if (addressInfo.addressLatitude) {
            self.latitude = addressInfo.addressLatitude;
        } else {
            self.latitude = [LocationInfo getLocationInfo].lat;
        }
        if (addressInfo.addressLatitude) {
            self.longitude = addressInfo.addressLongitude;
        } else {
            self.longitude = [LocationInfo getLocationInfo].lng;
        }
        self.editAddressBlock = editAddressBlock;
        self.viewType = viewType;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地址";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClickEvent)];
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64)];
    
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
    _mapView.showMapScaleBar = YES;//是否显示比例尺
    
    [self loadData];
}

- (void)loadData {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, [HHSoftAppInfo AppScreen].width - 30, 80)];
    backView.backgroundColor = [UIColor whiteColor];
    
    _addressLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(backView.frame) - 20, 40) fontSize:14.0 text:[NSString stringByReplaceNullString:_addressInfo.addressDetail] textColor:[GlobalFile colorWithRed:71 green:165 blue:232 alpha:1] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [backView addSubview:_addressLabel];
    
    if (!_addressInfo.addressDetail.length) {
        [self reverseGeocodeAddressWithLatitude:_latitude Longitude:_longitude];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, CGRectGetWidth(backView.frame), 1)];
    lineView.backgroundColor = [GlobalFile backgroundColor];
    [backView addSubview:lineView];
    
    _houseNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 45, CGRectGetWidth(backView.frame) - 20, 40)];
    _houseNumberTextField.font = [UIFont systemFontOfSize:14.0];
    _houseNumberTextField.placeholder = @"请输入详细地址";
    _houseNumberTextField.textColor = [HHSoftAppInfo defaultLightSystemColor];
    _houseNumberTextField.text = [NSString stringByReplaceNullString:_addressInfo.addressHouseNumber];
    [backView addSubview:_houseNumberTextField];
    
    [self.view addSubview:backView];
    [self.view bringSubviewToFront:backView];
}

#pragma mark --- 确定按钮点击
- (void)rightBarButtonClickEvent {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (!_addressLabel.text.length) {
        [self showErrorView:@"请选择位置"];
        return;
    }
    if (!_houseNumberTextField.text.length) {
        [self showErrorView:@"请输入详细地址"];
        return;
    }
    _addressInfo.addressDetail = _addressLabel.text;
    _addressInfo.addressHouseNumber = _houseNumberTextField.text;
    _addressInfo.addressLatitude = _latitude;
    _addressInfo.addressLongitude = _longitude;
    if (_viewType == EditAddressType) {
        [self showWaitView:@"请稍等..."];
        self.view.userInteractionEnabled = NO;
        [self updateAddressWithAddressInfo:_addressInfo];
    } else if (_viewType == SelectAddressType) {
        if (_editAddressBlock) {
            _editAddressBlock(_addressInfo);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)updateAddressWithAddressInfo:(AddressInfo *)addressInfo {
    self.op = [[[UserCenterNetWorkEngine alloc] init] editUserAddressWithWithUserID:[UserInfoEngine getUserInfo].userID lat:addressInfo.addressLatitude lng:addressInfo.addressLongitude addressDetail:addressInfo.addressDetail houseNumber:addressInfo.addressHouseNumber successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                if (_editAddressBlock) {
                    _editAddressBlock(addressInfo);
                }
                [self.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            }
                break;
                
            case 101: {
                [self showErrorView:@"修改失败"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常,请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败,请稍后重试"];
    }];
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
//点击地图空白处 大头针移动
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    _mapView.centerCoordinate = coordinate;
    BMKPointAnnotation *pointAnnotation = [_mapView.annotations firstObject];
    pointAnnotation.coordinate = coordinate;
    _latitude = coordinate.latitude;
    _longitude = coordinate.longitude;
    
    [self reverseGeocodeAddressWithLatitude:_latitude Longitude:_longitude];
}
//点击地图图标信息处 大头针移动
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi {
    _mapView.centerCoordinate = mapPoi.pt;
    BMKPointAnnotation *pointAnnotation = [_mapView.annotations firstObject];
    pointAnnotation.coordinate = mapPoi.pt;
    //    _addressLabel.text = mapPoi.text;
    //    _addressInfo.addressDetail = mapPoi.text;
    _latitude = mapPoi.pt.latitude;
    _longitude = mapPoi.pt.longitude;
    
    [self reverseGeocodeAddressWithLatitude:_latitude Longitude:_longitude];
}
#pragma mark --- 反地理编码
- (void)reverseGeocodeAddressWithLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude {
    
    //将数据传到反地址编码模型
    self.option.reverseGeoPoint = CLLocationCoordinate2DMake(latitude, longitude);
    
    NSLog(@"%f - %f", self.option.reverseGeoPoint.latitude, self.option.reverseGeoPoint.longitude);
    //调用反地址编码方法，让其在代理方法中输出
    [self.geocoder reverseGeoCode:self.option];
}

- (BMKGeoCodeSearch *)geocoder {
    if (!_geocoder) {
        _geocoder = [[BMKGeoCodeSearch alloc] init];
        _geocoder.delegate = self;
    }
    return _geocoder;
}

- (BMKReverseGeoCodeOption *)option {
    if (!_option) {
        _option = [[BMKReverseGeoCodeOption alloc] init];
    }
    return _option;
}

#pragma mark --- 代理方法返回反地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (result) {
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", result.addressDetail.province, result.addressDetail.city, result.addressDetail.district, result.addressDetail.streetName];
        NSLog(@"%@ - %@", result.address, result.addressDetail.streetNumber);
    }
}

@end
