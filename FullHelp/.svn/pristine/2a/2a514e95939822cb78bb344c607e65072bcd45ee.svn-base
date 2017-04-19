//
//  SettingsViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SettingsViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftSDImageCache.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "MenuInfo.h"
#import "UserCenterNetWorkEngine.h"
#import "AppDelegate.h"
#import "UserLoginNetWorkEngine.h"
#import "MessageSettingsViewController.h"
#import "FeedbackViewController.h"
#import "WKWebViewController.h"
#import "RegionViewController.h"
#import "IndustryInfo.h"
#import "RegionInfo.h"
#import "SetWithdrawalPwdViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic,strong) UIView *footerView;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    _arrData = [self getSettingsData];
    [self.view addSubview:self.dataTableView];
}

#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
        _dataTableView.tableFooterView = [self footerView];
    }
    return _dataTableView;
}
#pragma mark --- 添加尾部视图
- (UIView *)footerView {
    if (_footerView==nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 100)];
        _footerView.backgroundColor = [GlobalFile backgroundColor];
        //确定
        UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, [HHSoftAppInfo AppScreen].width-20, 40)];
        logoutButton.backgroundColor = [UIColor whiteColor];
        [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateNormal];
        logoutButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        logoutButton.layer.cornerRadius = 3.0;
        logoutButton.layer.masksToBounds = YES;
        [logoutButton addTarget:self action:@selector(logoutButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:logoutButton];
        
    }
    return _footerView;
}
#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrData[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuInfo *menuInfo = [_arrData[indexPath.section] objectAtIndex:indexPath.row];
    static NSString *strCell = @"SettingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
        cell.detailTextLabel.textColor = [GlobalFile themeColor];
    }
    cell.textLabel.text = menuInfo.menuName;
    if (menuInfo.menuID == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        CGFloat tmpSize = [[HHSoftSDImageCache sharedImageCache] getSize]/(1024.0*1024.0);
        if (tmpSize>1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",tmpSize];
        }else{
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fK",tmpSize*1024];
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuInfo *menuInfo = [_arrData[indexPath.section] objectAtIndex:indexPath.row];
    switch (menuInfo.menuID) {
        case 0: {//消息设置
            MessageSettingsViewController *messageSettingsViewController = [[MessageSettingsViewController alloc] init];
            [self.navigationController pushViewController:messageSettingsViewController animated:YES];
        }
            break;
            
        case 1: {
            [[HHSoftSDImageCache sharedImageCache] clearMemory];
            [[HHSoftSDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [self showSuccessView:@"清除缓存成功"];
                [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            }];
            //清除缓存
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
        }
            break;
            
        case 2: {//联系我们
            RegionViewController *regionViewController = [[RegionViewController alloc] initWithViewType:LinkUsType pID:0 layerID:0];
            [self.navigationController pushViewController:regionViewController animated:YES];
        }
            break;
            
        case 3: {//使用帮助
            WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithUrl:@"" WkWebType:WKWebTypeWithHelp MessageTitle:@"使用帮助"];
            [self.navigationController pushViewController:wkWebViewController animated:YES];
        }
            break;
            
        case 4: {//意见反馈
            FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedbackViewController animated:YES];
        }
            break;
            
        case 5: {//设置提现密码
            SetWithdrawalPwdViewController *setWithdrawalPwdViewController = [[SetWithdrawalPwdViewController alloc] initWithViewType:1 setWithdrawalPwdSuccessed:nil];
            [self.navigationController pushViewController:setWithdrawalPwdViewController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark --- 退出登录按钮点击事件
- (void)logoutButtonClick {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showWaitView:@"请稍等..."];
        self.view.userInteractionEnabled = NO;
        self.op = [[[UserLoginNetWorkEngine alloc] init] updateDeviceStateWithUserID:0 deviceType:1 deviceToken:[HHSoftAppDelegate deviceToken] successed:^(NSInteger code) {
            self.view.userInteractionEnabled = YES;
            switch (code) {
                case 100: {
                    [UserInfoEngine setUserInfo:nil];
                    [IndustryInfo setIndustryInfo:nil];
                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    appDelegate.window.rootViewController = [AppDelegate getRootViewController];
                }
                    break;
                    
                case 101: {
                    [self showErrorView:@"退出登录失败"];
                }
                    break;
                    
                default: {
                    [self showErrorView:@"网络连接异常，请稍后重试"];
                }
                    break;
            }
        } failed:^(NSError *error) {
            self.view.userInteractionEnabled = YES;
            [self showErrorView:@"网络连接异常,请稍后重试"];
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 系统设置
 
 @return arrData
 */
- (NSMutableArray *)getSettingsData {
    MenuInfo *menuInfo0 = [[MenuInfo alloc] initWithMenuID:0 menuName:@"消息设置"];
    MenuInfo *menuInfo1 = [[MenuInfo alloc] initWithMenuID:1 menuName:@"清除缓存"];
    MenuInfo *menuInfo2 = [[MenuInfo alloc] initWithMenuID:2 menuName:@"联系我们"];
    NSMutableArray *arr0 = [NSMutableArray arrayWithObjects:menuInfo0, menuInfo1, menuInfo2, nil];
    
    MenuInfo *menuInfo3 = [[MenuInfo alloc] initWithMenuID:3 menuName:@"使用帮助"];
    MenuInfo *menuInfo4 = [[MenuInfo alloc] initWithMenuID:4 menuName:@"意见反馈"];
    MenuInfo *menuInfo5 = [[MenuInfo alloc] initWithMenuID:5 menuName:@"设置提现密码"];
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:menuInfo3, menuInfo4, menuInfo5, nil];
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:arr0, arr1, nil];
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
