//
//  SystemMassageViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SystemMassageViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserCenterNetWorkEngine.h"
#import "MessageInfo.h"
#import "WKWebViewController.h"
#import "SystemMassageViewCell.h"
#import "NewsInfoViewController.h"
#import "PictureNewsInfoViewController.h"
#import "VideoNewsInfoViewController.h"
#import "MerchantsRewardApplyViewController.h"
#import "SupplierRewardApplyViewController.h"

@interface SystemMassageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger PageSize;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) BOOL isPullToRefresh;
@property (nonatomic,assign) BOOL isLoadMore;

@end

@implementation SystemMassageViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统消息";
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    _PageSize=30;
    _pageIndex=1;
    _isLoadMore=NO;
    _isPullToRefresh=NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"usercenter_message_clear.png"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteMessageAction)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.tintColor = [GlobalFile themeColor];
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取我的消息
    [self getMessageListWithUserID:[UserInfoEngine getUserInfo].userID Page:_pageIndex PageSize:_PageSize];
}
#pragma mark -- 获取我的消息
-(void)getMessageListWithUserID:(NSInteger)userID
                           Page:(NSInteger)page
                       PageSize:(NSInteger)pageSize{
    self.op = [[[UserCenterNetWorkEngine alloc] init] getMessageListWithUserID:userID page:page pageSize:pageSize successed:^(NSInteger code, NSMutableArray *arrMessageList) {
        [self hideLoadingView];
        if (code == 100) {
            if (_arrData == nil) {
                _arrData = [[NSMutableArray alloc] init];
            }
            if (self.pageIndex==1) {
                [self.arrData removeAllObjects];
            }
            [self.arrData addObjectsFromArray:arrMessageList];
            
            if (!_dataTableView) {
                [self.view addSubview:self.dataTableView];
            }else {
                [_dataTableView reloadData];
            }
            [self.dataTableView stopAnimating];
            if (_arrData.count == 0) {
                [_dataTableView reloadData];
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    _isPullToRefresh=NO;
                    _isLoadMore=NO;
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getMessageListWithUserID:userID Page:page PageSize:pageSize];
                }];
            }else{
                self.navigationItem.rightBarButtonItem.enabled = YES;
                if (_isPullToRefresh==NO && _isLoadMore==NO) {
                    [self hideLoadingView];
                }else{
                    [self.dataTableView stopAnimating];
                }
                [self.dataTableView reloadData];
                
                if (_arrData.count==_pageIndex*_PageSize) {
                    [_dataTableView setLoadMoreEnabled:YES];
                }else{
                    [_dataTableView setLoadMoreEnabled:NO];
                }
            }
        }else if (code == 101){
            //没有数据
            if (!_isLoadMore&&!_isPullToRefresh) {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    //调接口
                    //获取我的消息
                    [self getMessageListWithUserID:[UserInfoEngine getUserInfo].userID Page:_pageIndex PageSize:_PageSize];
                }];
            }else {
                [self showErrorView:@"没有更多数据啦"];
            }
            [_dataTableView stopAnimating];
            [_dataTableView setLoadMoreEnabled:NO];
        }else{
            //失败
            if (_isLoadMore==NO && _isPullToRefresh==NO) {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    //调接口
                    //获取我的消息
                    [self getMessageListWithUserID:[UserInfoEngine getUserInfo].userID Page:_pageIndex PageSize:_PageSize];
                }];
            }else {
                [self showErrorView:[GlobalFile HHSoftLoadError]];
            }
            [_dataTableView stopAnimating];
            [_dataTableView setLoadMoreEnabled:NO];
        }
        
    } failed:^(NSError *error) {
        [self hideLoadingView];
        //失败
        if (_isLoadMore==NO && _isPullToRefresh==NO) {
            [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                //调接口
                [self getMessageListWithUserID:[UserInfoEngine getUserInfo].userID Page:_pageIndex PageSize:_PageSize];
            }];
        }else{
            [self showErrorView:[GlobalFile HHSoftLoadError]];
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
        _dataTableView = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStylePlain];
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore=NO;
            _weakself.pageIndex=1;
            //调接口
            //获取我的消息
            [_weakself getMessageListWithUserID:[UserInfoEngine getUserInfo].userID Page:_weakself.pageIndex PageSize:_weakself.PageSize];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            //获取我的消息
            [_weakself getMessageListWithUserID:[UserInfoEngine getUserInfo].userID Page:_weakself.pageIndex PageSize:_weakself.PageSize];
        }];
    }
    return _dataTableView;
}
#pragma mark -- -------TableView的代理------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageInfo *messageInfo = _arrData[indexPath.row];
    return [SystemMassageViewCell getCellHeightWithMessageInfo:messageInfo];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *menuCell = @"MessageTableCell";
    SystemMassageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[SystemMassageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
    }
    cell.messageInfo = self.arrData[indexPath.row];
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self showWaitView:@"正在处理，请稍等..."];
        MessageInfo *messageInfo = _arrData[indexPath.row];
        [self deleteSingleSystemWithInfoID:messageInfo.messageID UserID:[UserInfoEngine getUserInfo].userID IndexPath:indexPath];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageInfo *messageInfo = _arrData[indexPath.row];
    // 类型 0：系统 1：新闻  2:组图新闻  3：视频新闻  4：打赏申请推送
    switch (messageInfo.messageType) {
        case 0:{
            //系统
            WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithMessageID:messageInfo.messageID WkWebType:WKWebTypeWithMessage MessageTitle:@"消息详情" successed:^(NSInteger messageID) {
                for (MessageInfo *message in self.arrData) {
                    if (message.messageID == messageID) {
                        message.messageState = 2;
                        break;
                    }
                }
                [self.dataTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }];
            [self.navigationController pushViewController:wkWebViewController animated:YES];
        }
            break;
        case 1:{
            //新闻
            NewsInfoViewController *newsInfoViewController = [[NewsInfoViewController alloc] initWithUrl:nil newsID:messageInfo.messageLogoID infoID:messageInfo.messageID];
            [self.navigationController pushViewController:newsInfoViewController animated:YES];
        }
            break;
        case 2:{
            //组图新闻
            PictureNewsInfoViewController *pictureNewsInfoViewController = [[PictureNewsInfoViewController alloc] initWithNewsID:messageInfo.messageLogoID infoID:messageInfo.messageID];
            [self.navigationController pushViewController:pictureNewsInfoViewController animated:YES];
        }
            break;
        case 3:{
            //视频新闻
            VideoNewsInfoViewController *videoNewsInfoViewController = [[VideoNewsInfoViewController alloc] initWithNewsID:messageInfo.messageLogoID newsImage:nil infoID:messageInfo.messageID];
            [self.navigationController pushViewController:videoNewsInfoViewController animated:YES];
        }
            break;
        case 4:{
            //打赏申请推送
            if ([UserInfoEngine getUserInfo].userType == 1) {
                //商家打赏申请
                MerchantsRewardApplyViewController *merchantsRewardApplyViewController = [[MerchantsRewardApplyViewController alloc] initWithInfoID:messageInfo.messageID];
                [self.navigationController pushViewController:merchantsRewardApplyViewController animated:YES];
            }else{
                //供货商打赏申请
                SupplierRewardApplyViewController *supplierRewardApplyViewController = [[SupplierRewardApplyViewController alloc] initWithInfoID:messageInfo.messageID];
                [self.navigationController pushViewController:supplierRewardApplyViewController animated:YES];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark -- 单个删除系统消息
-(void)deleteSingleSystemWithInfoID:(NSInteger)infoID
                             UserID:(NSInteger)userID
                          IndexPath:(NSIndexPath *)indexPath{
    self.op = [[[UserCenterNetWorkEngine alloc] init] deleteSingleSystemWithInfoID:infoID UserID:userID DeleteSingleSystemUserSuccessed:^(NSInteger code) {
        if (code == 100) {
            [self showSuccessView:@"删除成功"];
            [self.arrData removeObjectAtIndex:indexPath.row];
            [_dataTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            if(self.arrData.count == 0){
                self.navigationItem.rightBarButtonItem.enabled = NO;
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                }];
            }
        }else{
            [self showErrorView:@"网络连接异常，请稍后重试"];
        }
    } GetDataFail:^(NSError *error) {
        [self showErrorView:@"网络连接异常，请稍后重试"];
    }];
}
#pragma mark -- 清空消息按钮点击事件
-(void)deleteMessageAction{
    if (_arrData == nil) {
        [self showErrorView:@"您暂时没有可以删除的消息"];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要清空消息吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showWaitView:@"请稍等..."];
            self.view.userInteractionEnabled = NO;
            [self emptySystemUserInfoWithUserID:[UserInfoEngine getUserInfo].userID];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark -- 清空消息接口
-(void)emptySystemUserInfoWithUserID:(NSInteger)userID{
    self.op = [[[UserCenterNetWorkEngine alloc] init] emptySystemUserInfoWithUserID:userID succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        if (code == 100) {
            [self showSuccessView:@"清空成功"];
            [self.arrData removeAllObjects];
            if(self.arrData.count == 0){
                self.navigationItem.rightBarButtonItem.enabled = NO;
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    
                }];
            }
        }else{
            [self showErrorView:@"网络连接异常，请稍后再试"];
        }
    } Fail:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍后再试"];
    }];
}


@end
