//
//  PointsViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PointsViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "UserCenterNetWorkEngine.h"
#import "PointsChangeTableCell.h"
#import "PointsInfo.h"
#import "ChangeRecordInfo.h"
#import "PointsRuleViewController.h"
#import "UIViewController+NavigationBar.h"
#import "NSMutableAttributedString+hhsoft.h"
#import "PointsWithdrawalsViewController.h"

@interface PointsViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) HHSoftLabel *userPointsLabel;
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
/**
 *  是否支持下拉刷新
 */
@property (nonatomic,assign) BOOL isPullToRefresh;
/**
 *  是否支持加载更多
 */
@property (nonatomic,assign) BOOL isLoadMore;

@property (nonatomic, strong) PointsInfo *pointsInfo;
@property (nonatomic, strong) HHSoftLoadingView *noDataView;

@end

@implementation PointsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航控制器的代理为self
    self.navigationController.delegate = self;
    [self getUserPointListWithUserID:[UserInfoEngine getUserInfo].userID pageIndex:1 pageSize:30];
}

#pragma mark --- 导航栏变成白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark --- UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self.view addSubview:self.dataTableView];
    [self setNavigationBar];
    [self loadData];
}

#pragma mark ------ 设置导航栏
- (void)setNavigationBar {
    [self addLucencyNavigationBar];
    NSMutableDictionary *textAttributesDict = [NSMutableDictionary dictionary];
    textAttributesDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.0];
    [self.hhsoftNavigationBar setBackgroundImage:[GlobalFile imageWithColor:[GlobalFile colorWithRed:253.0 green:143.0 blue:75.0 alpha:1.0] size:CGSizeMake([HHSoftAppInfo AppScreen].width, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.hhsoftNavigationBar.subviews.firstObject setAlpha:1];
    [self.hhsoftNavigationBar setShadowImage:[UIImage new]];
    [self.hhsoftNavigationBar setTitleTextAttributes:textAttributesDict];
    [self.hhsoftNavigationBar setTintColor:[UIColor whiteColor]];
    self.hhsoftNaigationItem.title = @"我的金币";
    self.hhsoftNaigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"points_rule"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClickEvent)];
}
#pragma mark --- 点击积分规则
- (void)rightBarButtonClickEvent {
    PointsRuleViewController *pointsRuleListViewController = [[PointsRuleViewController alloc] init];
    [self.navigationController pushViewController:pointsRuleListViewController animated:YES];
}
#pragma mark --- 加载数据
- (void)loadData {
    _pageIndex = 1;
    _pageSize = 30;
    _isPullToRefresh = NO;
    _isLoadMore = NO;
    
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
}
#pragma mark --- 获取积分列表
- (void)getUserPointListWithUserID:(NSInteger)userID pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getUserPointListWithUserID:userID pageIndex:pageIndex pageSize:pageSize successed:^(NSInteger code, PointsInfo *pointsInfo) {
        [self hideLoadingView];
        if (_noDataView) {
            [_noDataView removeFromSuperview];
            _noDataView = nil;
        }
        switch (code) {
            case 100: {
                if (_arrData == nil) {
                    _arrData = [[NSMutableArray alloc] init];
                }
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                    _pointsInfo = pointsInfo;
                }
                [_arrData addObjectsFromArray:pointsInfo.pointsArrChange];
                
                [self.dataTableView stopAnimating];
                if (_arrData.count == 0) {
                    [_dataTableView reloadData];
                    [self.noDataView showLoadDataFailViewWithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        _isPullToRefresh = NO;
                        _isLoadMore = NO;
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getUserPointListWithUserID:userID pageIndex:pageIndex pageSize:pageSize];
                    }];
                } else {
                    if (!_isLoadMore && !_isPullToRefresh) {
                        [self hideLoadingView];
                    } else {
                        [self.dataTableView stopAnimating];
                    }
                    [self.dataTableView reloadData];
                    
                    if (_arrData.count == _pageIndex * _pageSize) {
                        [_dataTableView setLoadMoreEnabled:YES];
                    } else {
                        [_dataTableView setLoadMoreEnabled:NO];
                    }
                }
            }
                break;
                
            case 101: {
                //没有数据
                if (!_isLoadMore && !_isPullToRefresh) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //调接口
                        [self getUserPointListWithUserID:userID pageIndex:pageIndex pageSize:pageSize];
                    }];
                } else {
                    [self showErrorView:@"没有更多数据啦"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
                
            default: {
                //失败
                if (!_isLoadMore && !_isPullToRefresh) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //调接口
                        [self getUserPointListWithUserID:userID pageIndex:pageIndex pageSize:pageSize];
                    }];
                } else {
                    [self showErrorView:[GlobalFile HHSoftLoadError]];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        if (_noDataView) {
            [_noDataView removeFromSuperview];
            _noDataView = nil;
        }
        //失败
        if (!_isLoadMore && !_isPullToRefresh) {
            [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                //调接口
                [self getUserPointListWithUserID:userID pageIndex:pageIndex pageSize:pageSize];
            }];
        } else {
            [self showErrorView:[GlobalFile HHSoftUnableLinkNetWork]];
            if (_isLoadMore) {
                _pageIndex--;
            }
        }
        [_dataTableView stopAnimating];
    }];
}
#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 64, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStylePlain];
        __weak typeof(self) _weakself = self;
        //下拉刷新
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh = YES;
            _weakself.isLoadMore = NO;
            _weakself.pageIndex = 1;
            [_weakself getUserPointListWithUserID:[UserInfoEngine getUserInfo].userID pageIndex:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
        //加载更多
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh = NO;
            _weakself.isLoadMore = YES;
            _weakself.pageIndex ++;
            [_weakself getUserPointListWithUserID:[UserInfoEngine getUserInfo].userID pageIndex:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
    }
    return _dataTableView;
}

-(HHSoftLoadingView *)noDataView{
    if (_noDataView == nil) {
        _noDataView = [[HHSoftLoadingView alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].width*2/3.0+44, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-[HHSoftAppInfo AppScreen].width*2/3.0 - 44)];
        _noDataView.textLable.textColor = [UIColor lightGrayColor];
        _noDataView.textLable.font = [UIFont systemFontOfSize:14.0];
        [self.dataTableView addSubview:_noDataView];
        [self.dataTableView bringSubviewToFront:_noDataView];
    }
    return _noDataView;
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44.0;
    }
    ChangeRecordInfo *changeRecordInfo = self.arrData[indexPath.row - 1];
    return [PointsChangeTableCell getCellHeightWith:changeRecordInfo];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return 10.0;
    }
    return [HHSoftAppInfo AppScreen].width*2/3.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section) {
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width*2/3.0)];
    headerView.backgroundColor = [GlobalFile colorWithRed:254.0 green:148.0 blue:93.0 alpha:1.0];
    
    _userPointsLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 0, [HHSoftAppInfo AppScreen].width - 20, [HHSoftAppInfo AppScreen].width*2/3.0 - 70) fontSize:14.0 text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:0];
    NSString *pointsStr = [NSString stringWithFormat:@"%@", @(_pointsInfo.pointsUserPoints)];
    NSMutableAttributedString *attr;
    if (_pointsInfo.pointsFewDays) {
        attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n当前金币\n\n亲，您已经连续签到%@天，继续加油哦", pointsStr, @(_pointsInfo.pointsFewDays)]];
    } else {
        attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n当前金币\n\n亲，您今天还没有签到哦", pointsStr]];
    }
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50.0] range:NSMakeRange(0, pointsStr.length)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(pointsStr.length, 8)];
    _userPointsLabel.attributedText = attr;
    [headerView addSubview:_userPointsLabel];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_userPointsLabel.frame) + 30, [HHSoftAppInfo AppScreen].width, 40)];
    bottomView.backgroundColor = [GlobalFile colorWithRed:253.0 green:140.0 blue:68.0 alpha:1.0];
    
    UIButton *withdrawalButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 40)];
    NSMutableAttributedString *withdrawalAttributed = [[NSMutableAttributedString alloc] init];
    [withdrawalAttributed attributedStringWithImageStr:@"points_withdrawal" imageSize:CGSizeMake(18, 18)];
    [withdrawalAttributed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"  提现" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:16.0], NSFontAttributeName, nil]]];
    [withdrawalButton setAttributedTitle:withdrawalAttributed forState:UIControlStateNormal];
    [withdrawalButton addTarget:self action:@selector(withdrawalButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:withdrawalButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0 - 0.5, 5, 1, 30)];
    lineView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:lineView];
    
    UIButton *signButton = [[UIButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0 + 10, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 40)];
    NSMutableAttributedString *signAttributed = [[NSMutableAttributedString alloc] init];
    [signAttributed attributedStringWithImageStr:@"points_sign" imageSize:CGSizeMake(18, 16)];
    [signAttributed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"  签到" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:16.0], NSFontAttributeName, nil]]];
    [signButton setAttributedTitle:signAttributed forState:UIControlStateNormal];
    [signButton addTarget:self action:@selector(signButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:signButton];
    
    [headerView addSubview:bottomView];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *pointsIdentifier = @"PointsTableCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pointsIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pointsIdentifier];
            HHSoftLabel *pointsLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 7, [HHSoftAppInfo AppScreen].width - 30, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
            NSMutableAttributedString *attr;
            attr = [[NSMutableAttributedString alloc] initWithString:@"◆ 金币明细 ◆"];
            [attr addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(0, 1)];
            [attr addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(attr.length - 1, 1)];
            pointsLabel.attributedText = attr;
            [cell addSubview:pointsLabel];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *userPointsIdentifier = @"PointsChangeTableCell";
    PointsChangeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:userPointsIdentifier];
    if (!cell) {
        cell = [[PointsChangeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userPointsIdentifier];
    }
    cell.changeRecordInfo = self.arrData[indexPath.row-1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark --- 提现
- (void)withdrawalButtonPress {
    PointsWithdrawalsViewController *pointsWithdrawalsViewController = [[PointsWithdrawalsViewController alloc] initWithPoints:_pointsInfo.pointsUserPoints];
    [self.navigationController pushViewController:pointsWithdrawalsViewController animated:YES];
}

#pragma mark --- 签到
- (void)signButtonPress {
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    self.op = [[[UserCenterNetWorkEngine alloc] init] addSignInfoWithUserID:[UserInfoEngine getUserInfo].userID successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"签到成功"];
                [self loadData];
            }
                break;
                
            case 101: {
                [self showErrorView:@"签到失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"今日已签到过"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍候重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍候重试"];
    }];
}

#pragma mark --- DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
