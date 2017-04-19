//
//  AttentionDemandViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AttentionDemandViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "AttentionInfo.h"
#import "AttentionNetWorkEngine.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "DemandNoticeInfo.h"
#import "AttentionDemandNoticeViewCell.h"
#import "DemandInfoViewController.h"

@interface AttentionDemandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) BOOL isPullToRefresh;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,assign) NSInteger demandNoticeType;
@property (nonatomic,copy) NSMutableArray *arrSelect;
@property (nonatomic,copy) AttentionDemandCanEditBlock canEditBlock;
@property (nonatomic,copy) AttentionDemandIsAllDeleteBlock isAllDeleteBlock;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,assign) BOOL isAllSelect;

@end

@implementation AttentionDemandViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithAttentionDemandCanEditBlock:(AttentionDemandCanEditBlock)canEditBlock AttentionDemandIsAllDeleteBlock:(AttentionDemandIsAllDeleteBlock)isAllDeleteBlock{
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
    _pageSize=30;
    _pageIndex=1;
    _isLoadMore=NO;
    _isPullToRefresh=NO;
    _isAllSelect = NO;
    _demandNoticeType = 1;
    if (_canEditBlock) {
        _canEditBlock(NO);
    }
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取我的关注需求公示公告列表
    [self getCollectDemandNoticeListWithPageIndex:_pageIndex PageSize:_pageSize UserID:[UserInfoEngine getUserInfo].userID DemandNoticeType:_demandNoticeType];
}
#pragma mark -- 重新刷新数据
-(void)reloadAttentionData{
    if (self.isViewLoaded == YES) {
        _pageSize=30;
        _pageIndex=1;
        _isLoadMore=NO;
        _isPullToRefresh=NO;
        _isAllSelect = NO;
        _demandNoticeType = 1;
        //是否显示下拉
        _dataTableView.showsPullToRefresh = YES;
        //是否显示上提
        _dataTableView.showsInfiniteScrolling = YES;
        if (_canEditBlock) {
            _canEditBlock(NO);
        }
        //动画
        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
        //获取我的关注需求公示公告列表
        [self getCollectDemandNoticeListWithPageIndex:_pageIndex PageSize:_pageSize UserID:[UserInfoEngine getUserInfo].userID DemandNoticeType:_demandNoticeType];
    }
}
#pragma mark -- 获取我的关注需求公示公告列表
-(void)getCollectDemandNoticeListWithPageIndex:(NSInteger)pageIndex
                                      PageSize:(NSInteger)pageSize
                                        UserID:(NSInteger)userID
                              DemandNoticeType:(NSInteger)demandNoticeType{
    self.op = [[[AttentionNetWorkEngine alloc] init] getCollectDemandNoticeListWithPageIndex:pageIndex PageSize:pageSize UserID:userID DemandNoticeType:demandNoticeType Succeed:^(NSInteger code, NSMutableArray *arrDemandNoticeList) {
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
            [self.arrData addObjectsFromArray:arrDemandNoticeList];
            
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
                    //获取我的关注需求公示公告列表
                    [self getCollectDemandNoticeListWithPageIndex:pageIndex PageSize:pageSize UserID:[UserInfoEngine getUserInfo].userID DemandNoticeType:demandNoticeType];
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
                    //获取我的关注需求公示公告列表
                    [self getCollectDemandNoticeListWithPageIndex:pageIndex PageSize:pageSize UserID:[UserInfoEngine getUserInfo].userID DemandNoticeType:demandNoticeType];
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
                //获取我的关注需求公示公告列表
                [self getCollectDemandNoticeListWithPageIndex:pageIndex PageSize:pageSize UserID:[UserInfoEngine getUserInfo].userID DemandNoticeType:demandNoticeType];
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
            //获取我的关注需求公示公告列表
            [_weakself getCollectDemandNoticeListWithPageIndex:_weakself.pageIndex PageSize:_weakself.pageSize UserID:[UserInfoEngine getUserInfo].userID DemandNoticeType:_weakself.demandNoticeType];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            //获取我的关注需求公示公告列表
            [_weakself getCollectDemandNoticeListWithPageIndex:_weakself.pageIndex PageSize:_weakself.pageSize UserID:[UserInfoEngine getUserInfo].userID DemandNoticeType:_weakself.demandNoticeType];
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
        chooseButton.tag = 743;
        [_bottomView addSubview:chooseButton];
        [chooseButton addTarget:self action:@selector(allChooseDemandButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //删除
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+0.5, 0, [HHSoftAppInfo AppScreen].width/2.0-0.5, 42)];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[GlobalFile themeColor] forState:UIControlStateNormal];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        deleteButton.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteDemandButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    //全选、取消全选
    UIButton *chooseButton = (UIButton *)[_bottomView viewWithTag:743];
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
    AttentionDemandNoticeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[AttentionDemandNoticeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
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
            _arrSelect = [[NSMutableArray alloc]init];
        }
        [_arrSelect addObject:_arrData[indexPath.row]];
        if (_arrSelect.count == _arrData.count) {
            _isAllSelect = YES;
            [self.bottomView reloadInputViews];
        }
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AttentionInfo *attentionInfo = _arrData[indexPath.row];
        DemandInfoViewController *demandInfoViewController = [[DemandInfoViewController alloc] initWithDemandID:attentionInfo.demandNoticeInfo.demandNoticeID];
        [self.navigationController pushViewController:demandInfoViewController animated:YES];
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
-(void)allChooseDemandButtonClick:(UIButton *)button{
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
-(void)deleteDemandButtonClick{
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
