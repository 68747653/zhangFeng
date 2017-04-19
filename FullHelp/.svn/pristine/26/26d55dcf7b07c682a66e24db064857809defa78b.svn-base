//
//  PointsRuleViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PointsRuleViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "UserCenterNetWorkEngine.h"
#import "GlobalFile.h"
#import "PointsRuleTableCell.h"
#import "RuleInfo.h"

@interface PointsRuleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
/**
 *  是否支持下拉刷新
 */
@property (nonatomic,assign) BOOL isPullToRefresh;
/**
 *  是否支持加载更多
 */
@property (nonatomic,assign) BOOL isLoadMore;

@end

@implementation PointsRuleViewController

#pragma mark --- 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"金币规则";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self loadData];
}
#pragma mark --- 加载数据
- (void)loadData {
    _pageIndex = 1;
    _pageSize = 30;
    _isPullToRefresh = NO;
    _isLoadMore = NO;
    
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getPointRuleListPageIndex:_pageIndex pageSize:_pageSize];
}
#pragma mark --- 获取积分规则列表
- (void)getPointRuleListPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getPointRuleListPageIndex:pageIndex pageSize:pageSize successed:^(NSInteger code, NSMutableArray *arrRule) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                if (_arrData == nil) {
                    _arrData = [[NSMutableArray alloc] init];
                }
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                }
                [_arrData addObjectsFromArray:arrRule];
                
                if (!_isLoadMore && !_isPullToRefresh) {
                    [self hideLoadingView];
                } else {
                    [self.dataTableView stopAnimating];
                }
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }else {
                    [_dataTableView reloadData];
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
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //调接口
                        [self getPointRuleListPageIndex:pageIndex pageSize:pageSize];
                    }];
                } else {
                    [self showErrorView:@"没有更多数据啦"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
                
            default: {
                //失败
                if (!_isLoadMore && !_isPullToRefresh) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //调接口
                        [self getPointRuleListPageIndex:pageIndex pageSize:pageSize];
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
        //失败
        if (!_isLoadMore && !_isPullToRefresh) {
            [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                //调接口
                [self getPointRuleListPageIndex:pageIndex pageSize:pageSize];
            }];
        } else {
            [self showErrorView:[GlobalFile HHSoftUnableLinkNetWork]];
            if (_isLoadMore) {
                _pageIndex--;
            }
        }
        [_dataTableView stopAnimating];
    }];
}
#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStylePlain];
        __weak typeof(self) _weakself = self;
        //下拉刷新
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh = YES;
            _weakself.isLoadMore = NO;
            _weakself.pageIndex = 1;
            [_weakself getPointRuleListPageIndex:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
        //加载更多
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh = NO;
            _weakself.isLoadMore = YES;
            _weakself.pageIndex ++;
            [_weakself getPointRuleListPageIndex:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
    }
    return _dataTableView;
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RuleInfo *ruleInfo = self.arrData[indexPath.row];
    return [PointsRuleTableCell getCellHeightWith:ruleInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *pointRuleIdentifier = @"PointsRuleInfoCell";
    PointsRuleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:pointRuleIdentifier];
    if (!cell) {
        cell = [[PointsRuleTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:pointRuleIdentifier];
    }
    cell.ruleInfo = self.arrData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark --- DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
