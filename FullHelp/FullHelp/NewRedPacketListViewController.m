//
//  NewRedPacketListViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "NewRedPacketListViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"

#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "AdvertInfo.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "RedPacketAdvertCell.h"
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "NSMutableAttributedString+hhsoft.h"
#import "RedPacketAdvertDetailViewController.h"
#import "IndustryInfo.h"
#import "HHSoftHeader.h"
@interface NewRedPacketListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) BOOL isPullToRefresh;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL isLoadMore;

@end

@implementation NewRedPacketListViewController

- (instancetype) init {
    if (self = [super init]) {
        
        _pageIndex = 1;
        _pageSize = 30;
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ChooseIndustryInfoNotification object:nil];
}
- (void)chooseIndustryInfoNotification {
    [self getGrabRedPacketList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseIndustryInfoNotification) name:ChooseIndustryInfoNotification object:nil];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getGrabRedPacketList];
}
#pragma mark ------ 设置导航栏
- (void)setNavigationItem {
    self.navigationItem.title = [self navigationItemTitle];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
}
- (void)getGrabRedPacketList {
    [[[RedPacketAdvertNetWorkEngine alloc] init] getNewRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_pageIndex pageSize:_pageSize mark:[self activityMark] keyWordds:nil successed:^(NSInteger code, NSMutableArray *arrData) {
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
                        [self getGrabRedPacketList];
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
                        [self getGrabRedPacketList];
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
                [self getGrabRedPacketList];
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
#pragma mark ----------------- tableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView==nil) {
        _dataTableView=[[HHSoftTableView alloc] initWithFrame:CGRectZero dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
        [self setDataTableViewFrame];
        _dataTableView.tableHeaderView = self.headerView;
        _dataTableView.backgroundColor = self.view.backgroundColor;
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.pageIndex = 1;
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore = NO;
            [_weakself getGrabRedPacketList];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.pageIndex += 1;
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore = YES;
            [_weakself getGrabRedPacketList];
        }];
    }
    return _dataTableView;
}
#pragma mark--UITableViewDelegate
#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([HHSoftAppInfo AppScreen].width-20)/2+65;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"Identifier";
    RedPacketAdvertCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell=[[RedPacketAdvertCell alloc] initWithNewAdvertStyle:UITableViewCellStyleDefault reuseIdentifier:string cellType:CellTypeNew];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.advertInfo = self.arrData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AdvertInfo *advertInfo = self.arrData[indexPath.row];
    //广告详情
    RedPacketAdvertDetailViewController *redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] initWithRedPacketAdvertID:advertInfo.advertID];
    redPacketAdvertDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
}
- (NSMutableArray *)arrData {
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}
- (NSString *)navigationItemTitle {
    return @"最新活动";
}
#pragma mark ------ 最新活动
- (NSInteger)activityMark {
    return 0;
}
- (void)setDataTableViewFrame {
    self.dataTableView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
