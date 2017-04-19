//
//  PredictRedListViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PredictRedListViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "RedPacketInfo.h"
#import "PredictRedTableCell.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"

@interface PredictRedListViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) HHSoftLoadingView *noDataView;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
/**
 *  是否支持下拉刷新
 */
@property (nonatomic, assign) BOOL isPullToRefresh;
/**
 *  是否支持加载更多
 */
@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, copy) NSString *activityTime;

@end

@implementation PredictRedListViewController

- (instancetype)initWithActivityTime:(NSString *)activityTime {
    if (self = [super init]) {
        self.activityTime = activityTime;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.view addSubview:self.dataTableView];
    
    [self loadData];
}

- (void)loadData {
    _pageIndex = 1;
    _pageSize = 30;
    _isPullToRefresh = NO;
    _isLoadMore = NO;
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getPredictRedPacketListWithIndustryID:[UserInfoEngine getUserInfo].userIndustryID page:_pageIndex pageSize:_pageSize time:_activityTime];
}

- (void)getPredictRedPacketListWithIndustryID:(NSInteger)industryID page:(NSInteger)page pageSize:(NSInteger)pageSize time:(NSString *)time {
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] getPredictRedPacketListWithIndustryID:industryID page:page pageSize:pageSize time:time successed:^(NSInteger code, NSMutableArray *arrActivityTime, NSMutableArray *arrActivityRed) {
        [self hideLoadingView];
        [_noDataView removeFromSuperview];
        _noDataView = nil;
        switch (code) {
            case 100: {
                if (!_arrData) {
                    _arrData = [NSMutableArray arrayWithCapacity:0];
                }
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                }
                [self.arrData addObjectsFromArray:arrActivityRed];
                if (_isPullToRefresh == NO && _isLoadMore == NO) {
                    [self hideLoadingView];
                } else {
                    [self.dataTableView stopAnimating];
                }
                [self.dataTableView reloadData];
                
                if (_arrData.count == _pageIndex*_pageSize) {
                    [_dataTableView setLoadMoreEnabled:YES];
                } else {
                    [_dataTableView setLoadMoreEnabled:NO];
                }
            }
                break;
                
            case 101: {
                //没有数据
                if (_isLoadMore == NO && _isPullToRefresh == NO) {
                    [_arrData removeAllObjects];
                    [self.noDataView showLoadDataFailViewWithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        _isLoadMore = NO;
                        _isPullToRefresh = NO;
                        [self.noDataView showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getPredictRedPacketListWithIndustryID:industryID page:page pageSize:pageSize time:time];
                    }];
                }else{
                    [self showErrorView:@"没有更多数据啦"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
                
            default: {
                if (_isLoadMore == NO && _isPullToRefresh == NO) {
                    [self.noDataView showLoadDataFailViewWithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                        _isLoadMore = NO;
                        _isPullToRefresh = NO;
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getPredictRedPacketListWithIndustryID:industryID page:page pageSize:pageSize time:time];
                    }];
                }else{
                    [self showErrorView:[GlobalFile HHSoftLoadError]];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        if (_isLoadMore == NO && _isPullToRefresh == NO) {
            [self.noDataView showLoadDataFailViewWithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                _isLoadMore = NO;
                _isPullToRefresh = NO;
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                [self getPredictRedPacketListWithIndustryID:industryID page:page pageSize:pageSize time:time];
            }];
        } else {
            [self showErrorView:[GlobalFile HHSoftUnableLinkNetWork]];
            if (_isLoadMore == YES) {
                _pageIndex--;
            }
        }
        [_dataTableView stopAnimating];
    }];
}

/**
 初始化dataTableView
 
 @return dataTableView
 */
- (HHSoftTableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64 - 40) dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
        __weak typeof(self) _weakself = self;
        //下拉刷新
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh = YES;
            _weakself.isLoadMore = NO;
            _weakself.pageIndex = 1;
            [_weakself getPredictRedPacketListWithIndustryID:[UserInfoEngine getUserInfo].userIndustryID page:_weakself.pageIndex pageSize:_weakself.pageSize time:_weakself.activityTime];
        }];
        //加载更多
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh = NO;
            _weakself.isLoadMore = YES;
            _weakself.pageIndex ++;
            [_weakself getPredictRedPacketListWithIndustryID:[UserInfoEngine getUserInfo].userIndustryID page:_weakself.pageIndex pageSize:_weakself.pageSize time:_weakself.activityTime];
        }];
    }
    return _dataTableView;
}

- (HHSoftLoadingView *)noDataView {
    if (_noDataView == nil) {
        _noDataView = [[HHSoftLoadingView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64 - 40)];
        _noDataView.textLable.textColor = [UIColor lightGrayColor];
        _noDataView.textLable.font = [UIFont systemFontOfSize:14.f];
        [self.view addSubview:_noDataView];
        [self.view bringSubviewToFront:_noDataView];
    }
    return _noDataView;
}

#pragma mark --- UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RedPacketInfo *redPacketInfo = _arrData[indexPath.row];
    return [PredictRedTableCell getCellHeightWith:redPacketInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RedPacketInfo *redPacketInfo = _arrData[indexPath.row];
    static NSString *advertIdentifier = @"PredictRedTableCell";
    PredictRedTableCell *cell = [tableView dequeueReusableCellWithIdentifier:advertIdentifier];
    if (!cell) {
        cell = [[PredictRedTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:advertIdentifier];
    }
    cell.redPacketInfo = redPacketInfo;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
