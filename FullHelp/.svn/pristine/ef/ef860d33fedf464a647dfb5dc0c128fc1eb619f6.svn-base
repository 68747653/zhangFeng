//
//  SupplierRewardOngoingViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SupplierRewardOngoingViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "RewardInfo.h"
#import "UserCenterNetWorkEngine.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "SupplierRewardViewCell.h"
#import "MerchantsDetailViewController.h"

@interface SupplierRewardOngoingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,assign) NSInteger mark;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) BOOL isPullToRefresh;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,assign) NSInteger infoID;

@end

@implementation SupplierRewardOngoingViewController

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
    return 180.0;
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
    SupplierRewardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[SupplierRewardViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.rewardInfo = _arrData[indexPath.row];
    //打赏
    cell.rewardSupplierRewardBlock = ^(){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要打赏吗？" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            RewardInfo *rewardInfo = _arrData[indexPath.row];
            [self showWaitView:@"请稍等..."];
            self.view.userInteractionEnabled = NO;
            //修改申请打赏状态
            [self editApplyRedInfoWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType ApplyRedID:rewardInfo.rewardID NoPassReason:@"" Mark:1 IndexPath:indexPath];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    };
    //拒绝
    cell.refusedSupplierRewardBlock = ^(){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"拒绝原因" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入拒绝原因";
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            RewardInfo *rewardInfo = _arrData[indexPath.row];
            if (alertController.textFields.firstObject.text.length == 0) {
                [self showErrorView:@"请输入拒绝原因"];
                return;
            }
            [self showWaitView:@"请稍等..."];
            self.view.userInteractionEnabled = NO;
            //修改申请打赏状态
            [self editApplyRedInfoWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType ApplyRedID:rewardInfo.rewardID NoPassReason:alertController.textFields.firstObject.text Mark:2 IndexPath:indexPath];
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
    MerchantsDetailViewController *merchantsDetailViewController = [[MerchantsDetailViewController alloc] initWithMerchantUserID:rewardInfo.userInfo.userID];
    [self.navigationController pushViewController:merchantsDetailViewController animated:YES];
}
#pragma mark -- 修改申请打赏状态
-(void)editApplyRedInfoWithUserID:(NSInteger)userID
                         UserType:(NSInteger)userType
                       ApplyRedID:(NSInteger)applyRedID
                     NoPassReason:(NSString *)noPassReason
                             Mark:(NSInteger)mark
                        IndexPath:(NSIndexPath *)indexPath{
    self.op = [[[UserCenterNetWorkEngine alloc] init] editApplyRedInfoWithUserID:userID UserType:userType ApplyRedID:applyRedID NoPassReason:noPassReason Mark:mark Succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"处理成功"];
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
                [self showErrorView:@"处理失败"];
            }
                break;
            case 103:{
                [self showErrorView:@"该状态无法修改"];
            }
                break;
            case 104:{
                [self showErrorView:@"余额不足"];
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
