//
//  SceneRedPacketViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SceneRedPacketViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "IndustryInfo.h"
#import "RedPacketView.h"
#import "RedPacketInfo.h"
#import "OpenRedPacketInfoViewController.h"
#import "MainTabBarController.h"
#import "MainNavgationController.h"
#import "SceneCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "AdvertInfo.h"

#import "RedPacketAdvertDetailViewController.h"
@interface SceneRedPacketViewController ()
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) BOOL isPullToRefresh;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL isLoadMore;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) RedPacketView *redPacketView;


@end

@implementation SceneRedPacketViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        _pageIndex = 1;
        _pageSize = 30;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    
    [self getDemandList];
}
- (void)getDemandList {
    [[[RedPacketAdvertNetWorkEngine alloc] init] getSceneRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_pageIndex pageSize:_pageSize successed:^(NSInteger code, NSMutableArray *arrData) {
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
- (void)checkPassword {
    self.view.userInteractionEnabled = NO;
    [[[RedPacketAdvertNetWorkEngine alloc] init] checkPasswordWithUserID:[UserInfoEngine getUserInfo].userID password:self.passwordTextField.text Succeed:^(NSInteger code, NSInteger packetID) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:
            {
                [self hideWaitView];
                RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
                redPacketInfo.sendUserInfo.userHeadImg = @"Icon.png";
                redPacketInfo.sendUserInfo.userNickName = [HHSoftAppInfo AppName];
                redPacketInfo.redPacketMemo = @"场景红包";
                _redPacketView = [[RedPacketView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) openRedPacket:^(NSString *amount) {
                    _redPacketView.redPacketInfo.redPacketAmount = amount;
                    OpenRedPacketInfoViewController*openRedPacketInfoViewController = [[OpenRedPacketInfoViewController alloc] initWithRedPacketInfo:_redPacketView.redPacketInfo];
                    MainTabBarController *mainTabBarController = (MainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                    MainNavgationController *nav = mainTabBarController.viewControllers[mainTabBarController.selectedIndex];
                    [nav pushViewController:openRedPacketInfoViewController animated:YES];
                    [_redPacketView removeFromSuperview];
                }];
                _redPacketView.redPacketType = RedPacketTypeScene;
                _redPacketView.advertID = packetID;
                _redPacketView.redPacketInfo = redPacketInfo;
                [[UIApplication sharedApplication].keyWindow addSubview:_redPacketView];
            }
            break;
            case 101: {
                [self showErrorView:@"口令错误"];
            }
            break;
            case 103: {
                [self showErrorView:@"已领取"];
            }
            break;
            
            default:
            [self showErrorView:@"网络异常"];
            break;
        }
    } Failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络异常"];
    }];
}
- (void)setNavigationBar {
    self.navigationItem.title = @"场景红包";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
}
#pragma mark ------ headerView
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width*0.827)];
        UIImageView *sceneView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
        sceneView.image = [UIImage imageNamed:@"scene.png"];
        [_headerView addSubview:sceneView];
        
        [_headerView addSubview:self.passwordTextField];
        
    }
    return _headerView;
}
- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        CGFloat margin = 40;
        CGFloat width = [HHSoftAppInfo AppScreen].width-margin*2;
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.frame = CGRectMake(margin, [HHSoftAppInfo AppScreen].width*0.533, width, 30);
        _passwordTextField.background = [[UIImage imageNamed:@"password_background.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 40, 15, 20)];
        _passwordTextField.font = [UIFont systemFontOfSize:14];
        _passwordTextField.placeholder = @"请输入场景标签领取红包";
        _passwordTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        [_passwordTextField setTintColor:[GlobalFile colorWithRed:252 green:227 blue:130 alpha:1]];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
        _passwordTextField.leftView = leftView;
        _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 50, 30);
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(affirmPasswordClick) forControlEvents:UIControlEventTouchUpInside];
        CALayer *line = [CALayer layer];
        line.backgroundColor = [GlobalFile colorWithRed:252 green:227 blue:130 alpha:1].CGColor;
        line.frame = CGRectMake(0, 5, 1, 20);
        [button.layer addSublayer:line];
        _passwordTextField.rightView = button;
    }
    return _passwordTextField;
}
- (void)affirmPasswordClick {
    [self.view endEditing:YES];
    if (self.passwordTextField.text.length) {
        [self checkPassword];
    }
    else {
        [self showErrorView:@"请输入口令"];
    }
}

#pragma mark -- 初始化TableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStylePlain];
        _dataTableView.tableHeaderView = self.headerView;
        
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
    return ([HHSoftAppInfo AppScreen].width-20)/2+40;
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
    SceneCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (cell == nil) {
        cell = [[SceneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
    }
    cell.advertInfo = self.arrData[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AdvertInfo *advertInfo = self.arrData[indexPath.row];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
