//
//  SpecialRedPacketViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/4.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SpecialRedPacketViewController.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "IndustryInfo.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "TodayCell.h"
#import "HHSoftHeader.h"
#import "RedPacketAdvertDetailViewController.h"
#import "RedPacketInfo.h"
@interface SpecialRedPacketViewController ()
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) BOOL isPullToRefresh;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL isLoadMore;
@end

@implementation SpecialRedPacketViewController
- (instancetype) init {
    if (self = [super init]) {
        _pageIndex = 1;
        _pageSize = 30;
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GetSpecialRedpacketNotification object:nil];
}
- (void)getTodayRedpacketNotification:(NSNotification *)no {
    NSInteger advertID = [no.object integerValue];
    __block NSInteger indx=0;
    [self.arrData enumerateObjectsUsingBlock:^(RedPacketInfo *redPacketInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        if (redPacketInfo.redPacketID == advertID) {
            redPacketInfo.state = 2;
            indx = idx;
            [self.dataTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];

//    RedPacketInfo *redPacketInfo = no.object;
//    NSInteger indx = [self.arrData indexOfObject:redPacketInfo];
//    [self.dataTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)setNavigationBar {
    self.navigationItem.title = @"专场红包";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTodayRedpacketNotification:) name:GetSpecialRedpacketNotification object:nil];
    [self setNavigationBar];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getRedPacketList];
}
- (void)getRedPacketList {
    [[[RedPacketAdvertNetWorkEngine alloc] init] getSpecialRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID userID:[UserInfoEngine getUserInfo].userID page:_pageIndex pageSize:_pageSize successed:^(NSInteger code, NSMutableArray *arrData) {
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
                        [self getRedPacketList];
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
                        [self getRedPacketList];
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
                [self getRedPacketList];
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
#pragma mark -- 初始化TableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[UIColor clearColor]];
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore=NO;
            _weakself.pageIndex=1;
            //调接口
            [_weakself getRedPacketList];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            [_weakself getRedPacketList];
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
    return ([HHSoftAppInfo AppScreen].width-20)/3+50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *menuCell = @"menuCell";
    TodayCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[TodayCell alloc]initSpecialRedpacketCellWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
    }
    cell.redPacketInfo = self.arrData[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RedPacketInfo *redPacketInfo = self.arrData[indexPath.row];
    RedPacketAdvertDetailViewController *redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] initWithRedPacketAdvertID:redPacketInfo.redPacketID];
    redPacketAdvertDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
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
