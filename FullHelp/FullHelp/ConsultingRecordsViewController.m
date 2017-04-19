                                                                                                                                                          //
//  ConsultingRecordsViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ConsultingRecordsViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "ConsultRecordInfo.h"
#import "UserCenterNetWorkEngine.h"
#import "ConsultRecordViewCell.h"

@interface ConsultingRecordsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) BOOL isPullToRefresh;
@property (nonatomic,assign) BOOL isLoadMore;

@end

@implementation ConsultingRecordsViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"咨询记录";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    _pageSize=30;
    _pageIndex=1;
    _isLoadMore=NO;
    _isPullToRefresh=NO;
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取咨询记录
    [self getConsultRecordListWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType PageIndex:_pageIndex PageSize:_pageSize];
}
#pragma mark -- 获取咨询记录
-(void)getConsultRecordListWithUserID:(NSInteger)userID
                             UserType:(NSInteger)userType
                            PageIndex:(NSInteger)pageIndex
                             PageSize:(NSInteger)pageSize{
    self.op = [[[UserCenterNetWorkEngine alloc] init] getConsultRecordListWithUserID:userID UserType:userType PageIndex:pageIndex PageSize:pageSize Succeed:^(NSInteger code, NSMutableArray *arrRecordList) {
        [self hideLoadingView];
        if (code == 100) {
            if (_arrData == nil) {
                _arrData = [[NSMutableArray alloc] init];
            }
            if (self.pageIndex==1) {
                [self.arrData removeAllObjects];
            }
            [self.arrData addObjectsFromArray:arrRecordList];
            
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
                    //获取咨询记录
                    [self getConsultRecordListWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType PageIndex:pageIndex PageSize:pageSize];
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
                    //获取咨询记录
                    [self getConsultRecordListWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType PageIndex:pageIndex PageSize:pageSize];
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
                //获取咨询记录
                [self getConsultRecordListWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType PageIndex:pageIndex PageSize:pageSize];
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
        _dataTableView = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore=NO;
            _weakself.pageIndex=1;
            //调接口
            //获取咨询记录
            [_weakself getConsultRecordListWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType PageIndex:_weakself.pageIndex PageSize:_weakself.pageSize];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            //获取咨询记录
            [_weakself getConsultRecordListWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType PageIndex:_weakself.pageIndex PageSize:_weakself.pageSize];
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
    return 80.0;
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
    ConsultRecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[ConsultRecordViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.consultRecordInfo = self.arrData[indexPath.row];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self showWaitView:@"请稍等..."];
        self.view.userInteractionEnabled = NO;
        ConsultRecordInfo *consultRecordInfo = _arrData[indexPath.row];
        //删除接扣
        [self deleteConsultRecordInfoWithUserType:[UserInfoEngine getUserInfo].userType ConsultRecordID:consultRecordInfo.consultRecordID IndexPath:indexPath];
    }
}
#pragma mark -- 删除咨询记录接口
-(void)deleteConsultRecordInfoWithUserType:(NSInteger)userType
                           ConsultRecordID:(NSInteger)consultRecordID
                                 IndexPath:(NSIndexPath *)indexPath{
    self.op = [[[UserCenterNetWorkEngine alloc] init] deleteConsultRecordInfoWithUserType:userType ConsultRecordID:consultRecordID Succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"删除成功"];
                [self.arrData removeObjectAtIndex:indexPath.row];
                [self.dataTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                if (self.arrData.count == 0) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //获取咨询记录
                        [self getConsultRecordListWithUserID:[UserInfoEngine getUserInfo].userID UserType:[UserInfoEngine getUserInfo].userType PageIndex:_pageIndex PageSize:_pageSize];
                    }];
                }
            }
                break;
            case 101:{
                [self showErrorView:@"删除失败"];
            }
                break;
            default:{
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } Failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接异常，请稍后重试"];
    }];
}



@end
