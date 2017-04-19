//
//  BankViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "BankViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "AccountNetWorkEngine.h"
#import "GlobalFile.h"
#import "BankInfo.h"

@interface BankViewController () <UITableViewDataSource, UITableViewDelegate>

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

@property (nonatomic, copy) SelectBankSuccessed selectBankSuccessed;

@end

@implementation BankViewController

- (instancetype)initWithSelectBankSuccessed:(SelectBankSuccessed)selectBankSuccessed {
    if (self = [super init]) {
        self.selectBankSuccessed = selectBankSuccessed;
    }
    return self;
}

#pragma mark --- 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"银行";
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
    [self getBankListWithPage:_pageIndex pageSize:_pageSize];
}
#pragma mark --- 获取银行列表
- (void)getBankListWithPage:(NSInteger)page pageSize:(NSInteger)pageSize {
    self.op = [[[AccountNetWorkEngine alloc] init] getBankListWithPage:page pageSize:pageSize successed:^(NSInteger code, NSMutableArray *arrData) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                if (_arrData == nil) {
                    _arrData = [[NSMutableArray alloc] init];
                }
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                }
                [_arrData addObjectsFromArray:arrData];
                
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
                        [self getBankListWithPage:page pageSize:pageSize];
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
                        [self getBankListWithPage:page pageSize:pageSize];
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
                [self getBankListWithPage:page pageSize:pageSize];
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
            [_weakself getBankListWithPage:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
        //加载更多
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh = NO;
            _weakself.isLoadMore = YES;
            _weakself.pageIndex ++;
            [_weakself getBankListWithPage:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
    }
    return _dataTableView;
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankInfo *bankInfo = _arrData[indexPath.row];
    static NSString *pointRuleIdentifier = @"BankInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pointRuleIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:pointRuleIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    cell.textLabel.text = bankInfo.bankName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BankInfo *bankInfo = _arrData[indexPath.row];
    if (_selectBankSuccessed) {
        _selectBankSuccessed(bankInfo);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
