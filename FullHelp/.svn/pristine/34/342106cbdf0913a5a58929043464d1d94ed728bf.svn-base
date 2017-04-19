//
//  EditPasswordViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "EditPasswordViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserCenterNetWorkEngine.h"
#import "AppDelegate.h"
#import "UserLoginNetWorkEngine.h"

@interface EditPasswordViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITextField *oldPwdTextField, *pwdTextField, *certPwdTextField;
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) UIView *footerView;

@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self.view addSubview:self.dataTableView];
}

#pragma mark --- 初始化TableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[UIColor clearColor]];
        _dataTableView.tableFooterView = self.footerView;
    }
    return _dataTableView;
}

#pragma mark --- 尾部视图
- (UIView *)footerView {
    if (_footerView==nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 320)];
        
        //提交
        UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 60, [HHSoftAppInfo AppScreen].width-20, 40)];
        commitButton.backgroundColor = [GlobalFile themeColor];
        [commitButton setTitle:@"确定" forState:UIControlStateNormal];
        [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commitButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        commitButton.layer.cornerRadius = 3.0;
        commitButton.layer.masksToBounds = YES;
        [_footerView addSubview:commitButton];
        [commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

#pragma mark --- tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strCell = @"EditPasswordCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        //输入框
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, [HHSoftAppInfo AppScreen].width-40, 44)];
        textField.tag = 322;
        textField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        textField.font = [UIFont systemFontOfSize:14.0];
        textField.backgroundColor = [UIColor whiteColor];
        [cell addSubview:textField];
        //下线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 43, [HHSoftAppInfo AppScreen].width-40, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
        [cell addSubview:lineView];
    }
    //输入框
    UITextField *textField = (UITextField *)[cell viewWithTag:322];
    if (indexPath.row == 0) {
        textField.placeholder = @"原密码";
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
        _oldPwdTextField = textField;
    } else if (indexPath.row == 1) {
        textField.placeholder = @"新密码";
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
        _pwdTextField = textField;
    } else if (indexPath.row == 2) {
        textField.placeholder = @"确认新密码";
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
        _certPwdTextField = textField;
    }
    return cell;
}

#pragma mark --- 提交按钮点击事件
- (void)commitButtonClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_oldPwdTextField.text.length == 0) {
        [self showErrorView:@"请输入原密码"];
        return;
    }
    if (_oldPwdTextField.text.length < 6 || _oldPwdTextField.text.length > 16) {
        [self showErrorView:@"原密码长度为6~16位"];
        return;
    }
    if (_pwdTextField.text.length == 0) {
        [self showErrorView:@"请输入新密码"];
        return;
    }
    if (_pwdTextField.text.length < 6 || _pwdTextField.text.length > 16) {
        [self showErrorView:@"密码长度为6~16位"];
        return;
    }
    if (_certPwdTextField.text.length == 0) {
        [self showErrorView:@"请输入确认密码"];
        return;
    }
    if (_certPwdTextField.text.length < 6 || _certPwdTextField.text.length > 16) {
        [self showErrorView:@"确认密码长度为6~16位"];
        return;
    }
    if (![_pwdTextField.text isEqualToString:_certPwdTextField.text]) {
        [self showErrorView:@"两次密码不一致"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    [self editUserPwdWithUserID:[UserInfoEngine getUserInfo].userID newPwd:_pwdTextField.text oldPwd:_oldPwdTextField.text];
}
#pragma mark --- 修改密码
- (void)editUserPwdWithUserID:(NSInteger)userID newPwd:(NSString *)newPwd oldPwd:(NSString *)oldPwd {
    self.op = [[[UserCenterNetWorkEngine alloc] init] editUserPwdWithUserID:userID newPwd:newPwd oldPwd:oldPwd successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showWaitView:@"请稍等..."];
                self.view.userInteractionEnabled = NO;
                [self logout];
            }
                break;
                
            case 101: {
                [self showErrorView:@"修改失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"原密码错误"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

#pragma mark --- 退出登录
- (void)logout {
    self.op = [[[UserLoginNetWorkEngine alloc] init] updateDeviceStateWithUserID:0 deviceType:1 deviceToken:[HHSoftAppDelegate deviceToken] successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [UserInfoEngine setUserInfo:nil];
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
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
