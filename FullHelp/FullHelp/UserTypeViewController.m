//
//  UserTypeViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "UserTypeViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "UIViewController+NavigationBar.h"
#import "RegionViewController.h"
#import "HHSoftBarButtonItem.h"
#import "NSMutableAttributedString+hhsoft.h"

@interface UserTypeViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) UIView *headerView, *footerView;
@property (nonatomic, strong) UIImageView *backImgView;

@end

@implementation UserTypeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航控制器的代理为self
    self.navigationController.delegate = self;
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
    [self addLucencyNavigationBar];
    [self.hhsoftNavigationBar.subviews.firstObject setAlpha:0];
    self.hhsoftNaigationItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithBackBlock:^{
        [UserInfoEngine setRegisterUserInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark --- dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
        _dataTableView.backgroundColor = [GlobalFile backgroundColor] ;
        UIImageView *backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userregist_backgroundimg"]];
        [_dataTableView setBackgroundView:backImgView];
        _dataTableView.tableHeaderView = self.headerView;
        _dataTableView.tableFooterView = self.footerView;
    }
    return _dataTableView;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height/4.0)];
        _headerView.backgroundColor = [UIColor clearColor];
        HHSoftLabel *promptLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 10, [HHSoftAppInfo AppScreen].width-20, [HHSoftAppInfo AppScreen].height/4.0-20) fontSize:18.0 text:@"请选择您的身份" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_headerView addSubview:promptLabel];
    }
    return _headerView;
}

- (UIView *)footerView {
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-_headerView.frame.size.height-[HHSoftAppInfo AppScreen].height/3.0)];
        HHSoftButton *commitButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake([HHSoftAppInfo AppScreen].width/2-[HHSoftAppInfo AppScreen].width/3, 40, [HHSoftAppInfo AppScreen].width/1.5, 40) titleColor:[GlobalFile themeColor] titleSize:16.0];
        [commitButton setTitle:@"确定" forState:UIControlStateNormal];
        [commitButton addTarget:self action:@selector(commitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        //        [loginButton setBackgroundImage:[UIImage imageNamed:@"userlogin_buttonbackimg"] forState:UIControlStateNormal];
        commitButton.backgroundColor = [GlobalFile colorWithRed:222.0 green:205.0 blue:154.0 alpha:1.0];
        commitButton.layer.cornerRadius = 20.0;
        [_footerView addSubview:commitButton];
    }
    return _footerView;
}

#pragma mark --- 确定
- (void)commitButtonPressed {
    if (![UserInfoEngine getRegisterUserInfo].userType) {
        [self selectUserTypeWith:1];
    }
    RegionViewController *regionViewController = [[RegionViewController alloc] initWithViewType:RegisterType pID:1 layerID:1];
    [self.navigationController pushViewController:regionViewController animated:YES];
}

#pragma mark --- tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HHSoftAppInfo AppScreen].height/3.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *string = @"UserTypeIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        //背景
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width - 260) / 3, [HHSoftAppInfo AppScreen].height / 6 - 80 - 40, 130, 130)];
        _backImgView.image = [UIImage imageNamed:@"userregist_rotationbackimg"];
        //旋转动画效果
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
        rotationAnimation.duration = 5;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE_VALF;
        [_backImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [cell addSubview:_backImgView];
        //商家按钮
        HHSoftButton *merchantButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width - 260) / 3, [HHSoftAppInfo AppScreen].height / 6 - 80 - 40, 130, 160) innerImage:[UIImage imageNamed:@"userregist_merchant"] innerImageRect:CGRectMake(15, 15, 100, 100) descTextRect:CGRectMake(0, 140, 120, 20) descText:@"商家" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:18.0] textAligment:NSTextAlignmentCenter];
        [merchantButton addTarget:self action:@selector(merchantButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:merchantButton];
        //供应商按钮
        HHSoftButton *supplierButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width - 260) / 3 * 2 + 130, [HHSoftAppInfo AppScreen].height / 6 - 80 - 40, 130, 160) innerImage:[UIImage imageNamed:@"userregist_supplier"] innerImageRect:CGRectMake(15, 15, 100, 100) descTextRect:CGRectMake(0, 140, 120, 20) descText:@"供应商" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:18.0] textAligment:NSTextAlignmentCenter];
        [supplierButton addTarget:self action:@selector(supplierButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:supplierButton];
        
        HHSoftLabel *promptLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(merchantButton.frame) + 40, [HHSoftAppInfo AppScreen].width-20, 40) fontSize:14.0 text:@"温馨提示：亲，身份一旦角色\n确定无法修改哦" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentCenter numberOfLines:0];
        NSMutableAttributedString *promptAttributed = [[NSMutableAttributedString alloc] init];
        [promptAttributed attributedStringWithImageStr:@"userregist_prompt" imageSize:CGSizeMake(18, 18)];
        [promptAttributed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", promptLabel.text]]];
        promptLabel.attributedText = promptAttributed;
        [cell addSubview:promptLabel];
    }
    return cell;
}
#pragma mark --- 点击商家按钮
- (void)merchantButtonPress {
    [self selectUserTypeWith:1];
    _backImgView.frame = CGRectMake(([HHSoftAppInfo AppScreen].width - 260) / 3, [HHSoftAppInfo AppScreen].height / 6 - 80 - 40, 130, 130);
}
#pragma mark --- 点击供应商按钮
- (void)supplierButtonPress {
    [self selectUserTypeWith:2];
    _backImgView.frame = CGRectMake(([HHSoftAppInfo AppScreen].width - 260) / 3 * 2 + 130, [HHSoftAppInfo AppScreen].height / 6 - 80 - 40, 130, 130);
}
#pragma mark --- 选择用户类型  1：商家 2：供货商
- (void)selectUserTypeWith:(NSInteger)userType {
    UserInfo *userInfo = [UserInfoEngine getRegisterUserInfo];
    if (!userInfo) {
        userInfo = [[UserInfo alloc] init];
    }
    userInfo.userType = userType;
    [UserInfoEngine setRegisterUserInfo:userInfo];
}

@end
