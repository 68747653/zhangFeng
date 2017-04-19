//
//  RegionViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RegionViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "UserLoginNetWorkEngine.h"
#import "IndustryViewController.h"
#import "RegionInfo.h"
#import "UserCenterNetWorkEngine.h"
#import "HHSoftBarButtonItem.h"

@interface RegionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) NSInteger pID, layerID;
@property (nonatomic, assign) ViewType viewType;

@end

@implementation RegionViewController

- (instancetype)initWithViewType:(ViewType)viewType pID:(NSInteger)pID layerID:(NSInteger)layerID {
    if (self = [super init]) {
        self.viewType = viewType;
        self.pID = pID;
        self.layerID = layerID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.navigationItem.title = @"地区选择";
    self.navigationItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithBackBlock:^{
        [self saveRegistRegionInfoWithRegionInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    if (_viewType == RegisterType) {
        [self getRegionListWithPID:_pID layerID:_layerID];
    } else if (_viewType == LinkUsType) {
        [self getRegionIndustryListWithUserType:[UserInfoEngine getUserInfo].userType];
    } else if (_viewType == BackHomeType) {
        [self getRegionIndustryListWithUserType:[UserInfoEngine getUserInfo].userType];
    }
}
#pragma mark --- 获取地区列表
- (void)getRegionListWithPID:(NSInteger)pID layerID:(NSInteger)layerID {
    self.op = [[[UserLoginNetWorkEngine alloc] init] getRegionListWithPID:pID layerID:layerID successed:^(NSInteger code, NSMutableArray *arrRegion) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _arrData = arrRegion;
                if (_dataTableView) {
                    [_dataTableView reloadData];
                } else {
                    [self.view addSubview:self.dataTableView];
                }
            }
                break;
                
            case 101: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getRegionListWithPID:pID layerID:layerID];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getRegionListWithPID:pID layerID:layerID];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getRegionListWithPID:pID layerID:layerID];
        }];
    }];
}

#pragma mark --- 联系我们
- (void)getRegionIndustryListWithUserType:(NSInteger)userType {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getRegionIndustryListWithUserType:userType successed:^(NSInteger code, NSMutableArray *arrRegion) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _arrData = arrRegion;
                if (_dataTableView) {
                    [_dataTableView reloadData];
                } else {
                    [self.view addSubview:self.dataTableView];
                }
            }
                break;
                
            case 101: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getRegionIndustryListWithUserType:userType];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getRegionIndustryListWithUserType:userType];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getRegionIndustryListWithUserType:userType];
        }];
    }];
}

/**
 初始化dataTableView
 
 @return dataTableView
 */
- (HHSoftTableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStylePlain];
    }
    return _dataTableView;
}

#pragma mark --- UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"RegionInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    }
    RegionInfo *regionInfo = _arrData[indexPath.row];
    cell.textLabel.text = regionInfo.regionName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RegionInfo *regionInfo = _arrData[indexPath.row];
    if (_viewType == RegisterType) {//注册
        [self saveRegistRegionInfoWithRegionInfo:regionInfo];
        if (regionInfo.regionChildCount) {
            if (_layerID == 3) {
                IndustryViewController *industryViewController = [[IndustryViewController alloc] initWithViewType:_viewType regionID:regionInfo.regionID];
                [self.navigationController pushViewController:industryViewController animated:YES];
            } else {
                RegionViewController *regionViewController = [[RegionViewController alloc] initWithViewType:_viewType pID:regionInfo.regionID layerID:_layerID+1];
                [self.navigationController pushViewController:regionViewController animated:YES];
            }
        } else {
            IndustryViewController *industryViewController = [[IndustryViewController alloc] initWithViewType:_viewType regionID:regionInfo.regionID];
            [self.navigationController pushViewController:industryViewController animated:YES];
        }
    } else if (_viewType == LinkUsType) {//联系我们
        IndustryViewController *industryViewController = [[IndustryViewController alloc] initWithViewType:_viewType regionID:regionInfo.regionID];
        [self.navigationController pushViewController:industryViewController animated:YES];
    } else if (_viewType == BackHomeType) {//首页
        IndustryViewController *industryViewController = [[IndustryViewController alloc] initWithViewType:_viewType regionID:regionInfo.regionID];
        industryViewController.regionInfo = regionInfo;
        [self.navigationController pushViewController:industryViewController animated:YES];
    }
}

- (void)saveRegistRegionInfoWithRegionInfo:(RegionInfo *)regionInfo {
    if (_layerID == 1) {
        UserInfo *userInfo = [UserInfoEngine getRegisterUserInfo];
        userInfo.userProvinceID = regionInfo.regionID;
        [UserInfoEngine setRegisterUserInfo:userInfo];
    } else if (_layerID == 2) {
        UserInfo *userInfo = [UserInfoEngine getRegisterUserInfo];
        userInfo.userCityID = regionInfo.regionID;
        [UserInfoEngine setRegisterUserInfo:userInfo];
    } else if (_layerID == 3) {
        UserInfo *userInfo = [UserInfoEngine getRegisterUserInfo];
        userInfo.userDistrictID = regionInfo.regionID;
        [UserInfoEngine setRegisterUserInfo:userInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
