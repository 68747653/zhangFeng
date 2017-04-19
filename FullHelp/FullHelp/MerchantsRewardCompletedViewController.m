//
//  MerchantsRewardCompletedViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MerchantsRewardCompletedViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "RewardInfo.h"
#import "UserCenterNetWorkEngine.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "MerchantsRewardViewCell.h"
#import "RedPacketAdvertDetailViewController.h"

@interface MerchantsRewardCompletedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,assign) NSInteger mark;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) BOOL isPullToRefresh;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,assign) NSInteger infoID;

@end

@implementation MerchantsRewardCompletedViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithMark:(NSInteger)mark InfoID:(NSInteger)infoID{
    if(self = [super init]){
        _mark = mark;
        _infoID = infoID;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    _pageSize=30;
    _pageIndex=1;
    _isLoadMore=NO;
    _isPullToRefresh=NO;
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取我的打赏申请（商家/代理商）
    [self getApplyRedListWithUserID:[UserInfoEngine getUserInfo].userID Page:_pageIndex PageSize:_pageSize Mark:_mark UserType:[UserInfoEngine getUserInfo].userType InfoID:_infoID];
}
#pragma mark -- 重新获取数据
-(void)reloadRewardData{
    if (self.isViewLoaded == YES) {
        _pageSize=30;
        _pageIndex=1;
        _isLoadMore=NO;
        _isPullToRefresh=NO;
        //动画
        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
        //获取我的打赏申请（商家/代理商）
        [self getApplyRedListWithUserID:[UserInfoEngine getUserInfo].userID Page:_pageIndex PageSize:_pageSize Mark:_mark UserType:[UserInfoEngine getUserInfo].userType InfoID:_infoID];
    }
}
#pragma mark -- 获取我的打赏申请（商家/代理商）
-(void)getApplyRedListWithUserID:(NSInteger)userID
                            Page:(NSInteger)page
                        PageSize:(NSInteger)pageSize
                            Mark:(NSInteger)mark
                        UserType:(NSInteger)userType
                          InfoID:(NSInteger)infoID{
    self.op = [[[UserCenterNetWorkEngine alloc] init] getApplyRedListWithUserID:userID Page:page PageSize:pageSize Mark:mark UserType:userType InfoID:infoID Succeed:^(NSInteger code, NSMutableArray *arrData) {
        [self hideLoadingView];
        if (code == 100) {
            if (_arrData == nil) {
                _arrData = [[NSMutableArray alloc] init];
            }
            if (self.pageIndex==1) {
                [self.arrData removeAllObjects];
            }
            [self.arrData addObjectsFromArray:arrData];
            
            if (!_dataTableView) {
                [self.view addSubview:self.dataTableView];
            }else {
                [_dataTableView reloadData];
            }
            
            if (!_isLoadMore&&!_isPullToRefresh) {
                [self hideLoadingView];
            }else {
                [_dataTableView stopAnimating];
            }
            [self.dataTableView setShowsInfiniteScrolling:_arrData.count==_pageIndex*_pageSize];
        }else if (code == 101){
            //没有数据
            if (!_isLoadMore&&!_isPullToRefresh) {
                [self hideLoadingView];
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    //调接口
                    //获取我的打赏申请（商家/代理商）
                    [self getApplyRedListWithUserID:[UserInfoEngine getUserInfo].userID Page:page PageSize:pageSize Mark:mark UserType:[UserInfoEngine getUserInfo].userType InfoID:infoID];
                }];
            }else {
                [self showErrorView:@"没有更多数据啦"];
            }
            [_dataTableView stopAnimating];
            [_dataTableView setShowsInfiniteScrolling:NO];
        }else{
            //失败
            if (_isLoadMore==NO) {
                [self hideLoadingView];
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    //调接口
                    //获取我的打赏申请（商家/代理商）
                    [self getApplyRedListWithUserID:[UserInfoEngine getUserInfo].userID Page:page PageSize:pageSize Mark:mark UserType:[UserInfoEngine getUserInfo].userType InfoID:infoID];
                }];
            }else {
                [self showErrorView:[GlobalFile HHSoftLoadErrorMessage]];
            }
            [_dataTableView stopAnimating];
            [_dataTableView setShowsInfiniteScrolling:NO];
        }
    } Failed:^(NSError *error) {
        if (_isLoadMore==NO && _isPullToRefresh==NO) {
            [self hideLoadingView];
            [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                //调接口
                //获取我的打赏申请（商家/代理商）
                [self getApplyRedListWithUserID:[UserInfoEngine getUserInfo].userID Page:page PageSize:pageSize Mark:mark UserType:[UserInfoEngine getUserInfo].userType InfoID:infoID];
            }];
        }else{
            [self showErrorView:@"网络连接异常"];
            if (_isLoadMore) {
                _pageIndex--;
            }
        }
        [_dataTableView stopAnimating];
    }];
}
#pragma mark -- 初始化TableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-40) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[UIColor clearColor]];
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore=NO;
            _weakself.pageIndex=1;
            //调接口
            //获取我的打赏申请（商家/代理商）
            [_weakself getApplyRedListWithUserID:[UserInfoEngine getUserInfo].userID Page:_weakself.pageIndex PageSize:_weakself.pageSize Mark:_weakself.mark UserType:[UserInfoEngine getUserInfo].userType InfoID:_weakself.infoID];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            //获取我的打赏申请（商家/代理商）
            [_weakself getApplyRedListWithUserID:[UserInfoEngine getUserInfo].userID Page:_weakself.pageIndex PageSize:_weakself.pageSize Mark:_weakself.mark UserType:[UserInfoEngine getUserInfo].userType InfoID:_weakself.infoID];
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
    return 140.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
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
    MerchantsRewardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[MerchantsRewardViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.rewardInfo = _arrData[indexPath.row];
    //删除
    cell.deleteMerchantsRewardBlock = ^(){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除吗？" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            RewardInfo *rewardInfo = _arrData[indexPath.row];
            [self showWaitView:@"请稍等..."];
            self.view.userInteractionEnabled = NO;
            //删除申请打赏信息
            [self deleteApplyRedInfoWithUserType:[UserInfoEngine getUserInfo].userType ApplyredID:rewardInfo.rewardID IndexPath:indexPath];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    };
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RewardInfo *rewardInfo = _arrData[indexPath.row];
    RedPacketAdvertDetailViewController *redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] initWithRedPacketAdvertID:rewardInfo.rewardRedAdvertID];
    [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
}
#pragma mark -- 删除申请打赏信息
-(void)deleteApplyRedInfoWithUserType:(NSInteger)userType
                           ApplyredID:(NSInteger)applyredID
                            IndexPath:(NSIndexPath *)indexPath{
    self.op = [[[UserCenterNetWorkEngine alloc] init] deleteApplyRedInfoWithUserType:userType ApplyredID:applyredID Succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"删除成功"];
                [self.arrData removeObjectAtIndex:indexPath.row];
                [_dataTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [_dataTableView reloadData];
                if (_arrData.count == 0) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //调接口
                        [self reloadRewardData];
                    }];
                }
            }
                break;
            case 101:{
                [self showErrorView:@"删除失败"];
            }
                break;
            case 103:{
                [self showErrorView:@"未受理的红包打赏不满3天，不可删除"];
            }
                break;
            default:
                [self showErrorView:@"网络连接异常,请稍后重试"];
                break;
        }
    } Failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接异常,请稍后重试"];
    }];
}
@end
