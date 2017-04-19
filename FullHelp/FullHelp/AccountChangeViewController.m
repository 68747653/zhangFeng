//
//  AccountChangeViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AccountChangeViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "AccountNetWorkEngine.h"
#import "AccountChangeInfo.h"
#import "AccountChangeTableCell.h"

@interface AccountChangeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
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

@end

@implementation AccountChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"资金流水";
    [self loadData];
}

- (void)loadData {
    _pageIndex = 1;
    _pageSize = 30;
    _isPullToRefresh = NO;
    _isLoadMore = NO;
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getAccountChangeListWithUserID:[UserInfoEngine getUserInfo].userID page:_pageIndex pageSize:_pageSize];
}

- (void)getAccountChangeListWithUserID:(NSInteger)userID page:(NSInteger)page pageSize:(NSInteger)pageSize {
    self.op = [[[AccountNetWorkEngine alloc] init] getAccountChangeListWithUserID:userID page:page pageSize:pageSize successed:^(NSInteger code, NSMutableArray *arrData) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                if (!_arrData) {
                    _arrData = [NSMutableArray arrayWithCapacity:0];
                }
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                }
                [self.arrData addObjectsFromArray:arrData];
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }
                [self.dataTableView reloadData];

                if (!_isLoadMore && !_isPullToRefresh) {
                    [self hideLoadingView];
                } else {
                    [self.dataTableView stopAnimating];
                }
                
                if (_arrData.count == _pageIndex * _pageSize) {
                    [_dataTableView setLoadMoreEnabled:YES];
                } else {
                    [_dataTableView setLoadMoreEnabled:NO];
                }
            }
                break;
                
            case 101: {
                //没有数据
                if (!_isLoadMore && !_isPullToRefresh) {
                    [_arrData removeAllObjects];
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        _isLoadMore = NO;
                        _isPullToRefresh = NO;
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getAccountChangeListWithUserID:userID page:page pageSize:pageSize];
                    }];
                } else {
                    [self showErrorView:@"没有更多数据啦"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
                
            default: {
                if (!_isLoadMore && !_isPullToRefresh) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                        _isLoadMore = NO;
                        _isPullToRefresh = NO;
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getAccountChangeListWithUserID:userID page:page pageSize:pageSize];
                    }];
                } else {
                    [self showErrorView:[GlobalFile HHSoftLoadError]];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        if (!_isLoadMore && !_isPullToRefresh) {
            [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                _isLoadMore = NO;
                _isPullToRefresh = NO;
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                [self getAccountChangeListWithUserID:userID page:page pageSize:pageSize];
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
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStylePlain];
        __weak typeof(self) _weakself = self;
        //下拉刷新
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh = YES;
            _weakself.isLoadMore = NO;
            _weakself.pageIndex = 1;
            [_weakself getAccountChangeListWithUserID:[UserInfoEngine getUserInfo].userID page:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
        //加载更多
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh = NO;
            _weakself.isLoadMore = YES;
            _weakself.pageIndex ++;
            [_weakself getAccountChangeListWithUserID:[UserInfoEngine getUserInfo].userID page:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountChangeInfo *accountChangeInfo = _arrData[indexPath.row];
    return [AccountChangeTableCell getCellHeightWith:accountChangeInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountChangeInfo *accountChangeInfo = _arrData[indexPath.row];
    static NSString *identifier = @"AccountChangeTableCell";
    AccountChangeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AccountChangeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accountChangeInfo = accountChangeInfo;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
