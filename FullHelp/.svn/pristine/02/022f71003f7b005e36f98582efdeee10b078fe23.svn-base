//
//  MessageSettingsViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MessageSettingsViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppDelegate.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "MenuInfo.h"
#import "UserCenterNetWorkEngine.h"

@interface MessageSettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, strong) UISwitch *switchButton;

@end

@implementation MessageSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息设置";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getIsPushWithUserID:[UserInfoEngine getUserInfo].userID deviceToken:[HHSoftAppDelegate deviceToken] deviceType:1];
}

- (void)getIsPushWithUserID:(NSInteger)userID deviceToken:(NSString *)deviceToken deviceType:(NSInteger)deviceType {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getIsPushWithUserID:userID deviceToken:deviceToken deviceType:deviceType successed:^(NSInteger code, UserInfo *userInfo) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _userInfo = userInfo;
            }
                break;
                
            case 101: {
//                [self showErrorView:@"获取失败"];
            }
                break;
                
            default: {
//                [self showErrorView:[GlobalFile HHSoftLoadError]];
            }
                break;
        }
        _arrData = [self getSettingsData];
        [self.view addSubview:self.dataTableView];
    } failed:^(NSError *error) {
        [self hideLoadingView];
//        [self showErrorView:[GlobalFile HHSoftUnableLinkNetWork]];
        _arrData = [self getSettingsData];
        [self.view addSubview:self.dataTableView];
    }];
}

#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStylePlain];
    }
    return _dataTableView;
}
#pragma mark -- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 30)];
    footerView.backgroundColor = [GlobalFile backgroundColor];
    HHSoftLabel *detailLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width - 30, 30) fontSize:13.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    detailLabel.text = @"若关闭所有系统推送将不会在通知栏提示";
    [footerView addSubview:detailLabel];
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuInfo *menuInfo = _arrData[indexPath.row];
    static NSString *strCell = @"MessageSettingsInfoCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        _switchButton = [[UISwitch alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width - 60, 15, 30, 30)];
        _switchButton.onTintColor = [GlobalFile themeColor];
        _switchButton.on = YES;
        [_switchButton addTarget:self action:@selector(switchButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_switchButton];
    }
    cell.textLabel.text = menuInfo.menuName;
    if (_userInfo) {
        _switchButton.on = _userInfo.userIsPush;
    } else {
        _switchButton.on = YES;
    }
    return cell;
}

#pragma mark --- 开关按钮点击
- (void)switchButtonPress {
    [self setNotificationState:_switchButton.on];
}
#pragma mark --- 设置系统推送是否在通知栏显示
- (void)setNotificationState:(BOOL)isOpen {
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    self.op = [[[UserCenterNetWorkEngine alloc] init] editIsPushWithUserID:[UserInfoEngine getUserInfo].userID deviceToken:[HHSoftAppDelegate deviceToken] deviceType:1 isPush:isOpen successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"修改成功"];
            }
                break;
                
            case 101: {
                if (isOpen) {
                    _switchButton.on = NO;
                } else {
                    _switchButton.on = YES;
                }
                [self showErrorView:@"修改失败"];
            }
                break;
                
            default: {
                if (isOpen) {
                    _switchButton.on = NO;
                } else {
                    _switchButton.on = YES;
                }
                [self showErrorView:@"网络连接异常，请稍候重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        if (isOpen) {
            _switchButton.on = NO;
        } else {
            _switchButton.on = YES;
        }
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍候重试"];
    }];
}

/**
 消息设置
 
 @return arrData
 */
- (NSMutableArray *)getSettingsData {
    MenuInfo *messageMenu = [[MenuInfo alloc] initWithMenuID:0 menuName:@"通知栏推送"];
    NSMutableArray *arrData = [NSMutableArray arrayWithObjects:messageMenu, nil];
    return arrData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
