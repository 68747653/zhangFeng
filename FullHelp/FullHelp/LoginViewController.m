//
//  LoginViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "LoginViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
#import "UserLoginNetWorkEngine.h"
#import "AppDelegate.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "FindPasswordViewController.h"
#import "UserTypeViewController.h"
#import "RegionInfo.h"

@interface LoginViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) HHSoftTableView  *dataTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UITextField *loginNameTextField, *pwdTextField;
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, strong) UserInfo *userLoginInfo;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航控制器的代理为self
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消所有编辑
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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

    _loginName = [[UserInfoEngine getUserLoginDict] objectForKey:@"user_userLoginName"];
    [self.view addSubview:self.dataTableView];
}

#pragma mark --- dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
        _dataTableView.backgroundColor = [GlobalFile backgroundColor] ;
        UIImageView *backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userlogin_backgroundimg"]];
        [_dataTableView setBackgroundView:backImgView];
        _dataTableView.tableHeaderView = self.headerView;
        _dataTableView.tableFooterView = self.footerView;
    }
    return _dataTableView;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height/3.0)];
        _headerView.backgroundColor = [UIColor clearColor];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2-164/4, _headerView.frame.size.height/1.5-164/4, 164/2, 164/2)];
        imgView.image = [GlobalFile avatarImage];
        [_headerView addSubview:imgView];
    }
    return _headerView;
}

- (UIView *)footerView {
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-_headerView.frame.size.height-44*2)];
        HHSoftButton *loginButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake([HHSoftAppInfo AppScreen].width/2-[HHSoftAppInfo AppScreen].width/3, 40, [HHSoftAppInfo AppScreen].width/1.5, 40) titleColor:[UIColor whiteColor] titleSize:16.0];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//        [loginButton setBackgroundImage:[UIImage imageNamed:@"userlogin_buttonbackimg"] forState:UIControlStateNormal];
        loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        loginButton.layer.borderWidth = 1.0;
        loginButton.layer.cornerRadius = 20.0;
        [_footerView addSubview:loginButton];
        
        //忘记密码
        HHSoftButton *forgetButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake([HHSoftAppInfo AppScreen].width/2-[HHSoftAppInfo AppScreen].width/3, _footerView.frame.size.height-50, [HHSoftAppInfo AppScreen].width/3-1, 40) titleColor:nil titleSize:12.0];
        [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [forgetButton setTitle:@"    忘记密码" forState:UIControlStateNormal];
        [forgetButton addTarget:self action:@selector(forgetPwdButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        forgetButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        [_footerView addSubview:forgetButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2-0.5, _footerView.frame.size.height-50+30/2, 1, 10)];
        lineView.backgroundColor = [UIColor whiteColor];
        [_footerView addSubview:lineView];
        
        //立即注册
        HHSoftButton *registerButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake([HHSoftAppInfo AppScreen].width/2+1, _footerView.frame.size.height-50, [HHSoftAppInfo AppScreen].width/3-1, 40) titleColor:nil titleSize:12.0];
        [registerButton setTitle:@"立即注册    " forState:UIControlStateNormal];
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:registerButton];
    }
    return _footerView;
}

#pragma mark --- 登录
- (void)loginButtonPressed {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (!_loginNameTextField.text.length) {
        [self showErrorView:@"请输入手机号码"];
        return;
    }
    if (!_pwdTextField.text.length) {
        [self showErrorView:@"请输入密码"];
        return;
    }
    [self showWaitView:@"请稍等。。。"];
    [self userLoginWithDeviceToken:[HHSoftAppDelegate deviceToken] deviceType:1 loginName:_loginNameTextField.text loginPwd:_pwdTextField.text];
}

#pragma mark --- 注册
- (void)registerButtonPressed {
    UserTypeViewController *userTypeViewController = [[UserTypeViewController alloc] init];
    [self.navigationController pushViewController:userTypeViewController animated:YES];
}

#pragma mark --- 忘记密码
- (void)forgetPwdButtonPressed {
    FindPasswordViewController *findPasswordViewController = [[FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:findPasswordViewController animated:YES];
}

#pragma mark --- 清空登录名信息
- (void)deleteLoginNameButtonPressed {
    _loginNameTextField.text = @"";
    _pwdTextField.text = @"";
}

#pragma mark --- 清空登录密码信息
- (void)deletePwdButtonPressed {
    _pwdTextField.text = @"";
}

#pragma mark --- 登录接口
- (void)userLoginWithDeviceToken:(NSString *)deviceToken
                      deviceType:(NSInteger)deviceType
                       loginName:(NSString *)userLoginName
                    loginPwd:(NSString *)userLoginPwd {
    [self.view setUserInteractionEnabled:NO];
    self.op = [[[UserLoginNetWorkEngine alloc] init] userLoginWithLoginName:userLoginName loginPassword:userLoginPwd deviceType:deviceType deviceToken:deviceToken successed:^(NSInteger code, UserInfo *userInfo) {
        [self.view setUserInteractionEnabled:YES];
        switch (code) {//100:登录成功,101:登录失败,102:网络连接失败,103:手机号码错误，104：该用户不存在，105：密码错误,100001:网络连接异常,请稍后重试，106：该账号已禁用
            case 100: {
                RegionInfo *regionInfo = [RegionInfo getRegionInfo];
                if (!regionInfo) {
                    regionInfo = [[RegionInfo alloc] init];
                }
                regionInfo.provinceID = userInfo.userProvinceID;
                regionInfo.provinceName = userInfo.userProvinceName;
                [RegionInfo setRegionInfo:regionInfo];
                self.userLoginInfo = userInfo;
                self.userLoginInfo.userLoginName = userLoginName;
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:userLoginName, @"user_userLoginName", nil];
                [UserInfoEngine setUserLoginDict:dict];
                [UserInfoEngine setUserInfo:_userLoginInfo];
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appDelegate.window.rootViewController = [AppDelegate getRootViewController];
            }
                break;
                
            case 101: {
                [self showErrorView:@"登录失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"手机号码错误"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"该用户不存在"];
            }
                break;
                
            case 105: {
                [self showErrorView:@"密码错误"];
            }
                break;
                
            case 106: {
                [self showErrorView:@"该账号已禁用"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self.view setUserInteractionEnabled:YES];
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

#pragma mark --- tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *string = @"LoginIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2-[HHSoftAppInfo AppScreen].width/3-44/2/4*3, 44/2-44/4, 44/2/4*3, 44/2)];
        imgView.tag = 445;
        [cell addSubview:imgView];
        
        UIImageView *underlineImgView = [[UIImageView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2-[HHSoftAppInfo AppScreen].width/3+10, 44-1, [HHSoftAppInfo AppScreen].width/1.5-15, 1)];
//        underlineImgView.image = [UIImage imageNamed:@"userlogin_underline"];
        underlineImgView.backgroundColor = [UIColor whiteColor];
        [cell addSubview:underlineImgView];
        
        UITextField *loginTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(underlineImgView.frame), 0, [HHSoftAppInfo AppScreen].width/1.5-15-35, 44)];
        loginTextField.tag = 551;
        loginTextField.font = [UIFont systemFontOfSize:15.0];
        loginTextField.delegate = self;
        loginTextField.textColor = [UIColor whiteColor];
        [cell addSubview:loginTextField];
        
        //清空数据
        HHSoftButton *deleteButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(CGRectGetMaxX(loginTextField.frame), 4, 35, 35) titleColor:nil titleSize:12.0];
        [deleteButton setImage:[UIImage imageNamed:@"userlogin_delete"] forState:UIControlStateNormal];
        deleteButton.tag = 666;
        [cell addSubview:deleteButton];
        
    }
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:445];
    UITextField *loginTextField = (UITextField *)[cell viewWithTag:551];
    HHSoftButton *deleteButton = (HHSoftButton *)[cell viewWithTag:666];
    [loginTextField.layer setValue:[NSString stringWithFormat:@"%@", @(indexPath.row)] forKey:@"row"];
    
    if (indexPath.row == 0) {
        imgView.image = [UIImage imageNamed:@"userlogin_username"];
        _loginNameTextField = loginTextField;
        _loginNameTextField.text = _loginName;
        _loginNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _loginNameTextField.returnKeyType = UIReturnKeyNext;
        _loginNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:14.0]}];
        [deleteButton addTarget:self action:@selector(deleteLoginNameButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    } else {
        imgView.image = [UIImage imageNamed:@"userlogin_loginpwd"];
        _pwdTextField = loginTextField;
        _pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _pwdTextField.returnKeyType = UIReturnKeyDone;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:14.0]}];
        [deleteButton addTarget:self action:@selector(deletePwdButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

#pragma mark --- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loginButtonPressed];
    return YES;
}

@end
