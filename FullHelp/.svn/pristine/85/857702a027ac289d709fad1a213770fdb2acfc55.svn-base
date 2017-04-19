//
//  IndustryViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "IndustryViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "UserLoginNetWorkEngine.h"
#import "RegisterViewController.h"
#import "IndustryInfo.h"
#import "RegionInfo.h"
#import "CustomServicerViewController.h"


@interface IndustryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) NSInteger regionID;
@property (nonatomic, assign) ViewType viewType;

@end

@implementation IndustryViewController

- (instancetype)initWithViewType:(ViewType)viewType regionID:(NSInteger)regionID {
    if (self = [super init]) {
        self.viewType = viewType;
        self.regionID = regionID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.navigationItem.title = @"行业选择";
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getIndustryListWithRegionID:_regionID];
}
#pragma mark --- 获取行业列表
- (void)getIndustryListWithRegionID:(NSInteger)regionID {
    self.op = [[[UserLoginNetWorkEngine alloc] init] getIndustryListWithRegionID:regionID successed:^(NSInteger code, NSMutableArray *arrIndustry) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _arrData = arrIndustry;
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
                    [self getIndustryListWithRegionID:regionID];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getIndustryListWithRegionID:regionID];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getIndustryListWithRegionID:regionID];
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
    static NSString *identifier = @"IndustryInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    }
    IndustryInfo *industryInfo = _arrData[indexPath.row];
    cell.textLabel.text = industryInfo.industryName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IndustryInfo *industryInfo = _arrData[indexPath.row];
    if (_viewType == RegisterType) {//注册
        UserInfo *userInfo = [UserInfoEngine getRegisterUserInfo];
        userInfo.userIndustryID = industryInfo.industryID;
        [UserInfoEngine setRegisterUserInfo:userInfo];
        RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
        [self.navigationController pushViewController:registerViewController animated:YES];
    } else if (_viewType == LinkUsType) {//联系我们
        CustomServicerViewController *customServicerViewController = [[CustomServicerViewController alloc] initWithIndustryID:industryInfo.industryID];
        [self.navigationController pushViewController:customServicerViewController animated:YES];
    } else if (_viewType == BackHomeType) {//首页
        [IndustryInfo setIndustryInfo:industryInfo];
        RegionInfo *regionInfo = [[RegionInfo alloc] init];
        regionInfo.provinceID = self.regionInfo.regionID;
        regionInfo.provinceName = self.regionInfo.regionName;
        [RegionInfo setRegionInfo:regionInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:ChooseIndustryInfoNotification object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
