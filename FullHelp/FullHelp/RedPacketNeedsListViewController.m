//
//  RedPacketNeedsListViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RedPacketNeedsListViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "HHSoftBarButtonItem.h"
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "PublishNeedsViewController.h"
#import "MyPublishViewCell.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "IndustryInfo.h"
#import "DemandInfoViewController.h"
#import "DemandNoticeInfo.h"
#import "HHSoftHeader.h"
@interface RedPacketNeedsListViewController ()
@property (nonatomic, assign) NeedsType needsType;
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) BOOL isPullToRefresh;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL isLoadMore;

@end

@implementation RedPacketNeedsListViewController
- (instancetype)initWithNeedsType:(NeedsType )needsType {
    if (self = [super init]) {
        self.needsType = needsType;
        _pageIndex = 1;
        _pageSize = 30;
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PublishDemandNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publishDemandNotification) name:PublishDemandNotification object:nil];
    [self setNavigationBar];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    
    [self getDemandList];
}
- (void)getDemandList {
    [[[RedPacketAdvertNetWorkEngine alloc] init] getDemadListWithIndustryID:[IndustryInfo getIndustryInfo].industryID demandType:self.needsType page:_pageIndex pageSize:_pageSize successed:^(NSInteger code, NSMutableArray *arrData) {
        switch (code) {
            case 100:
            {
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                }
                [self.arrData addObjectsFromArray:arrData];
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }else {
                    [self.dataTableView reloadData];
                }
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                }else {
                    [_dataTableView stopAnimating];
                }
                _dataTableView.showsInfiniteScrolling=_arrData.count==_pageIndex*_pageSize?YES:NO;
            }
                break;
            case 101: {
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                    [self showLoadDataFailViewInView:self.view WithText:@"暂无数据" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self hideLoadingView];
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getDemandList];
                    }];
                }else {
                    [self showErrorView:@"暂无数据"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setShowsInfiniteScrolling:NO];
            }
                break;
            default: {
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                    [self showLoadDataFailViewInView:self.view WithText:@"网络异常" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self hideLoadingView];
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getDemandList];
                    }];
                }else {
                    [self showErrorView:@"网络异常"];
                }
            }
                break;
        }
    } failed:^(NSError *error) {
        if (!_isLoadMore&&!_isPullToRefresh) {
            [self hideLoadingView];
            [self showLoadDataFailViewInView:self.view WithText:@"网络异常" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                [self hideLoadingView];
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                [self getDemandList];
            }];
        }else {
            [self showErrorView:@"网络异常"];
            if (_isLoadMore) {
                _pageIndex--;
            }
            [_dataTableView stopAnimating];
        }
    }];
}
- (void)setNavigationBar {
    
    self.navigationItem.title = self.needsType==1?@"需求红包":@"公示公告";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    if ([UserInfoEngine getUserInfo].userType == self.needsType) {
        self.navigationItem.rightBarButtonItem = [[HHSoftBarButtonItem alloc] initWithImageStr:@"publish.png" itemClickBlock:^{
            PublishNeedsViewController*publishNeedsViewController = [[PublishNeedsViewController alloc] init];
            [self.navigationController pushViewController:publishNeedsViewController animated:YES];
        }];
    }
    
}
#pragma mark -- 初始化TableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore=NO;
            _weakself.pageIndex=1;
            //调接口
            [_weakself getDemandList];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            [_weakself getDemandList];
        }];
    }
    return _dataTableView;
}
#pragma mark -- TableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)viewDidLayoutSubviews{
    if ([_dataTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_dataTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_dataTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_dataTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *menuCell = @"menuCell";
    MyPublishViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[MyPublishViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
    }
    cell.demandNoticeInfo = self.arrData[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DemandNoticeInfo *demandInfo = self.arrData[indexPath.row];
    DemandInfoViewController*demandInfoViewController = [[DemandInfoViewController alloc] initWithDemandID:demandInfo.demandNoticeID];
    [self.navigationController pushViewController:demandInfoViewController animated:YES];
}
- (void)publishDemandNotification {
    _pageIndex = 1;
    [self getDemandList];
}
- (NSMutableArray *)arrData {
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
