//
//  RedAdvertCommentListViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RedAdvertCommentListViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftPhotoBrowser.h>
#import "GlobalFile.h"
#import "CommentInfo.h"
#import "AdvertCommentViewCell.h"
#import "RedPacketAdvertNetWorkEngine.h"

@interface RedAdvertCommentListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) BOOL isPullToRefresh;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,assign) NSInteger merchantUserID;
@end

@implementation RedAdvertCommentListViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithMerchantUserID:(NSInteger)merchantUserID{
    if(self = [super init]){
        _merchantUserID = merchantUserID;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价列表";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    _pageSize=30;
    _pageIndex=1;
    _isLoadMore=NO;
    _isPullToRefresh=NO;
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取评价列表
    [self getCommentListWithPageIndex:_pageIndex PageSize:_pageSize MerchantUserID:_merchantUserID];
}
#pragma mark -- 获取评价列表
-(void)getCommentListWithPageIndex:(NSInteger)pageIndex
                          PageSize:(NSInteger)pageSize
                    MerchantUserID:(NSInteger)merchantUserID{
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] getCommentListWithPageIndex:pageIndex PageSize:pageSize MerchantUserID:merchantUserID Succeed:^(NSInteger code, NSMutableArray *arrData) {
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
                    //获取评价列表
                    [self getCommentListWithPageIndex:_pageIndex PageSize:_pageSize MerchantUserID:_merchantUserID];
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
                    //获取评价列表
                    [self getCommentListWithPageIndex:_pageIndex PageSize:_pageSize MerchantUserID:_merchantUserID];
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
                //获取评价列表
                [self getCommentListWithPageIndex:_pageIndex PageSize:_pageSize MerchantUserID:_merchantUserID];
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
            //获取评价列表
            [_weakself getCommentListWithPageIndex:_weakself.pageIndex PageSize:_weakself.pageSize MerchantUserID:_weakself.merchantUserID];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            //获取评价列表
            [_weakself getCommentListWithPageIndex:_weakself.pageIndex PageSize:_weakself.pageSize MerchantUserID:_weakself.merchantUserID];
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
    CommentInfo *commentInfo = _arrData[indexPath.row];
    return [AdvertCommentViewCell cellHeightWithCommentInfo:commentInfo];
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
    //评论
    static NSString *listImageCell = @"listImageCell";
    static NSString *listNoImageCell = @"listNoImageCell";
    
    CommentInfo *commentInfo = _arrData[indexPath.row];
    AdvertCommentViewCell *cell;
    if (commentInfo.arrCommentGallery.count) {
        cell = [AdvertCommentViewCell AdvertCommentViewCellWithTableView:tableView identifier:listImageCell];
    }else{
        cell = [AdvertCommentViewCell AdvertCommentViewCellWithTableView:tableView identifier:listNoImageCell];
    }
    cell.commentInfo = commentInfo;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.seeImgViewBlock = ^(NSMutableArray *arrImage,NSInteger indexPath){
        //查看大图
        [[HHSoftPhotoBrowser shared] showPhotos:arrImage currentPhotoIndex:indexPath inTargetController:self];
    };
    return cell;
}



@end
