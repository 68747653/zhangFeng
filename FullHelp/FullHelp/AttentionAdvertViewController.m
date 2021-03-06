//
//  AttentionAdvertViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AttentionAdvertViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "AttentionInfo.h"
#import "AdvertInfo.h"
#import "AttentionNetWorkEngine.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "AttentionAdvertViewCell.h"
#import "RedPacketAdvertDetailViewController.h"

@interface AttentionAdvertViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) BOOL isPullToRefresh;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,copy) NSMutableArray *arrSelect;
@property (nonatomic,copy) AttentionAdvertCanEditBlock canEditBlock;
@property (nonatomic,copy) AttentionAdvertIsAllDeleteBlock isAllDeleteBlock;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,assign) BOOL isAllSelect;
@end

@implementation AttentionAdvertViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithAttentionAdvertCanEditBlock:(AttentionAdvertCanEditBlock)canEditBlock AttentionAdvertIsAllDeleteBlock:(AttentionAdvertIsAllDeleteBlock)isAllDeleteBlock{
    if(self = [super init]){
        _canEditBlock = canEditBlock;
        _isAllDeleteBlock = isAllDeleteBlock;
    }
    return self;
}
-(void)deleteSelectCollect{
    if (self.dataTableView.editing) {
        [self.dataTableView setEditing:NO animated:YES];
        //是否显示下拉
        _dataTableView.showsPullToRefresh = YES;
        //是否显示上提
        _dataTableView.showsInfiniteScrolling = YES;
        self.dataTableView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-42);
        if (_bottomView) {
            [_bottomView removeFromSuperview];
            _bottomView = nil;
        }
    }else{
        [_arrSelect removeAllObjects];
        //是否显示下拉
        _dataTableView.showsPullToRefresh = NO;
        //是否显示上提
        _dataTableView.showsInfiniteScrolling = NO;
        
        if (_arrData.count) {
            [self.dataTableView setEditing:YES animated:YES];
            self.dataTableView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-42*2);
            if (!_bottomView) {
                [self.view addSubview:self.bottomView];
            }
        }
    }
}
-(void)setTableEditing:(BOOL)isEdit{
    [_dataTableView setEditing:isEdit animated:YES];
    if (_bottomView) {
        self.dataTableView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-42);
        [_bottomView removeFromSuperview];
        _bottomView = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    if (_canEditBlock) {
        _canEditBlock(NO);
    }
    _pageSize=30;
    _pageIndex=1;
    _isLoadMore=NO;
    _isPullToRefresh=NO;
    _isAllSelect = NO;
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取我的关注广告列表
    [self getCollectAdvertListWithPageIndex:_pageIndex PageSize:_pageSize UserID:[UserInfoEngine getUserInfo].userID];
}
#pragma mark -- 重新刷新数据
-(void)reloadAttentionData{
    if (self.isViewLoaded == YES) {
        _pageSize=30;
        _pageIndex=1;
        _isLoadMore=NO;
        _isPullToRefresh=NO;
        _isAllSelect = NO;
        //是否显示下拉
        _dataTableView.showsPullToRefresh = YES;
        //是否显示上提
        _dataTableView.showsInfiniteScrolling = YES;
        if (_canEditBlock) {
            _canEditBlock(NO);
        }
        //动画
        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
        //获取我的关注广告列表
        [self getCollectAdvertListWithPageIndex:_pageIndex PageSize:_pageSize UserID:[UserInfoEngine getUserInfo].userID];
    }
}
#pragma mark -- 获取我的关注广告列表
-(void)getCollectAdvertListWithPageIndex:(NSInteger)pageIndex
                                  PageSize:(NSInteger)pageSize
                                    UserID:(NSInteger)userID{
    self.op = [[[AttentionNetWorkEngine alloc] init] getCollectAdvertListWithPageIndex:pageIndex PageSize:pageSize UserID:userID Succeed:^(NSInteger code, NSMutableArray *arrAdvertList) {
        [self hideLoadingView];
        if (code == 100) {
            if (_canEditBlock) {
                _canEditBlock(YES);
            }
            if (_arrData == nil) {
                _arrData = [[NSMutableArray alloc] init];
            }
            if (self.pageIndex==1) {
                [self.arrData removeAllObjects];
            }
            [self.arrData addObjectsFromArray:arrAdvertList];
            
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
                    //获取我的关注广告列表
                    [self getCollectAdvertListWithPageIndex:pageIndex PageSize:pageSize UserID:[UserInfoEngine getUserInfo].userID];
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
                    //获取我的关注广告列表
                    [self getCollectAdvertListWithPageIndex:pageIndex PageSize:pageSize UserID:[UserInfoEngine getUserInfo].userID];
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
                //获取我的关注广告列表
                [self getCollectAdvertListWithPageIndex:pageIndex PageSize:pageSize UserID:[UserInfoEngine getUserInfo].userID];
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
        _dataTableView = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-42) dataSource:self delegate:self style:UITableViewStyleGrouped];
        _dataTableView.allowsMultipleSelectionDuringEditing = YES;
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore=NO;
            _weakself.pageIndex=1;
            //调接口
            //获取我的关注广告列表
            [_weakself getCollectAdvertListWithPageIndex:_weakself.pageIndex PageSize:_weakself.pageSize UserID:[UserInfoEngine getUserInfo].userID];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            //获取我的关注广告列表
            [_weakself getCollectAdvertListWithPageIndex:_weakself.pageIndex PageSize:_weakself.pageSize UserID:[UserInfoEngine getUserInfo].userID];
        }];
    }
    return _dataTableView;
}
#pragma mark -- 初始化底部删除视图
-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].height-64-42*2, [HHSoftAppInfo AppScreen].width, 40)];
        _bottomView.backgroundColor = [GlobalFile backgroundColor];
        //全选、取消全选
        UIButton *chooseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width/2.0-0.5, 42)];
        [chooseButton setTitle:@"全选" forState:UIControlStateNormal];
        [chooseButton setTitle:@"取消全选" forState:UIControlStateSelected];
        [chooseButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateNormal];
        [chooseButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateSelected];
        chooseButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        chooseButton.backgroundColor = [UIColor whiteColor];
        chooseButton.tag = 741;
        [_bottomView addSubview:chooseButton];
        [chooseButton addTarget:self action:@selector(allChooseAdvertButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //删除
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+0.5, 0, [HHSoftAppInfo AppScreen].width/2.0-0.5, 42)];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[GlobalFile themeColor] forState:UIControlStateNormal];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        deleteButton.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteAdvertButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    //全选、取消全选
    UIButton *chooseButton = (UIButton *)[_bottomView viewWithTag:741];
    chooseButton.selected = _isAllSelect;
    
    return _bottomView;
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
    AttentionAdvertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[AttentionAdvertViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 100)];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        cell.tintColor = [GlobalFile themeColor]; //改变选中按钮的颜色
    }
    cell.attentionInfo = _arrData[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.editing) {
        if (!_arrSelect) {
            _arrSelect = [[NSMutableArray alloc] init];
        }
        [_arrSelect addObject:_arrData[indexPath.row]];
        if (_arrSelect.count == _arrData.count) {
            _isAllSelect = YES;
            [self.bottomView reloadInputViews];
        }
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AttentionInfo *attentionInfo = _arrData[indexPath.row];
        RedPacketAdvertDetailViewController *redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] initWithRedPacketAdvertID:attentionInfo.advertInfo.advertID];
        [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_arrSelect removeObject:_arrData[indexPath.row]];
    if (_arrSelect.count < _arrData.count) {
        _isAllSelect = NO;
        [self.bottomView reloadInputViews];
    }
}
#pragma mark -- 全选按钮点击事件
-(void)allChooseAdvertButtonClick:(UIButton *)button{
    if (button.selected == NO) {
        button.selected = YES;
        _isAllSelect = YES;
        if (!_arrSelect) {
            _arrSelect = [[NSMutableArray alloc] init];
        }else{
            [_arrSelect removeAllObjects];
        }
        for (int i = 0; i < _arrData.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            AttentionInfo *attentionInfo = _arrData[indexPath.row];
            [self.dataTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self.arrSelect addObject:attentionInfo];
        }
    }else{
        button.selected = NO;
        _isAllSelect = NO;
        for (int i = 0; i < _arrData.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.dataTableView deselectRowAtIndexPath:indexPath animated:YES];
            [self.arrSelect removeAllObjects];
        }
    }
}
#pragma mark -- 删除按钮点击事件
-(void)deleteAdvertButtonClick{
    if (_arrSelect.count == 0) {
        [self showErrorView:@"请选择要删除的内容"];
        return;
    }
    
    NSString *spliceStr = @"";
    for (NSInteger i = 0; i<_arrSelect.count; i++) {
        
        AttentionInfo *attentionInfo = _arrSelect[i];
        if (i == 0) {
            spliceStr = [NSString stringWithFormat:@"%@",[@(attentionInfo.attentionID) stringValue]];
        }else{
            spliceStr = [NSString stringWithFormat:@"%@,%@",spliceStr,[@(attentionInfo.attentionID) stringValue]];
        }
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    //我的关注批量删除接口
    [self deletaBatchCollectInfoWithUserID:[UserInfoEngine getUserInfo].userID CollectIDStr:spliceStr];
}
#pragma mark -- 我的关注批量删除接口
-(void)deletaBatchCollectInfoWithUserID:(NSInteger)userID
                           CollectIDStr:(NSString *)collectIDStr{
    self.op = [[[AttentionNetWorkEngine alloc] init] deletaBatchCollectInfoWithUserID:userID CollectIDStr:collectIDStr Succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"删除成功"];
                for (NSInteger i = 0; i<_arrSelect.count; i++) {
                    [_arrData removeObject:_arrSelect[i]];
                }
                [self.dataTableView reloadData];
                if (_arrData.count == 0) {
                    if (_isAllDeleteBlock) {
                        _isAllDeleteBlock(YES);
                    }
                    _isLoadMore = NO ;
                    _isPullToRefresh = NO;
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //调接口
                        [self reloadAttentionData];
                    }];
                }
            }
                break;
            case 101:{
                [self showErrorView:@"删除失败"];
            }
                break;
            default:{
                [self showErrorView:@"网络连接失败，请稍后再试"];
            }
                break;
        }
    } Failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍后再试"];
    }];
}
@end
