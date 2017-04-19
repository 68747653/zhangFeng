//
//  SetWithdrawalPwdViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SetWithdrawalPwdViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftTextView.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserLoginNetWorkEngine.h"
#import "AccountNetWorkEngine.h"
#import "WithdrawalViewController.h"

@interface SetWithdrawalPwdViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UITextField *codeTextField,*pwdTextField,*surePwdTextField;
@property (nonatomic,strong) HHSoftButton *verifyButton;
@property (nonatomic,assign) NSInteger viewType;
@property (nonatomic,copy) SetWithdrawalPwdSuccessed setWithdrawalPwdSuccessed;

@end

@implementation SetWithdrawalPwdViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消所有编辑
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (instancetype)initWithViewType:(NSInteger)viewType setWithdrawalPwdSuccessed:(SetWithdrawalPwdSuccessed)setWithdrawalPwdSuccessed {
    if(self = [super init]){
        self.viewType = viewType;
        self.setWithdrawalPwdSuccessed = setWithdrawalPwdSuccessed;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    if (_viewType == 2) {
        self.navigationItem.title = @"修改提现密码";
    } else {
        self.navigationItem.title = @"设置提现密码";
    }
    [self.view addSubview:self.dataTableView];
}

#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[GlobalFile backgroundColor]];
        _dataTableView.tableFooterView = self.footerView;
    }
    return _dataTableView;
}

#pragma mark --- 初始化footerView
- (UIView *)footerView {
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 100)];
        //提交按钮
        UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, [HHSoftAppInfo AppScreen].width-30, 40)];
        submitButton.backgroundColor = [GlobalFile themeColor];
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        submitButton.layer.cornerRadius = 3.0;
        submitButton.layer.masksToBounds = YES;
        [_footerView addSubview:submitButton];
        [submitButton addTarget:self action:@selector(submitWithdrawalPwdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *contentCell = @"contentCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //验证码
            _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width-15-111-5, 44)];
            _codeTextField.placeholder = @"请输入验证码";
            _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
            _codeTextField.font = [UIFont systemFontOfSize:14.0];
            _codeTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            _codeTextField.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:_codeTextField];
            //分割线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-111, 0, 1, 44.0 )];
            lineView.backgroundColor = [GlobalFile backgroundColor];
            [cell addSubview:lineView];
            //获取验证码
            _verifyButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-110, 0, 110, 44)];
            [_verifyButton setTitle:@"发送验证码" forState:UIControlStateNormal];
            _verifyButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
            [_verifyButton setTitleColor:[GlobalFile themeColor] forState:0];
            [_verifyButton addTarget:self action:@selector(setWithdrawalPwdVerifyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_verifyButton];
        }
        return cell;
    } else {
        static NSString *contentCell = @"PasswordCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //输入框
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width-30, 44)];
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            textField.font = [UIFont systemFontOfSize:14.0];
            textField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            textField.textAlignment = NSTextAlignmentLeft;
            textField.secureTextEntry = YES;
            textField.tag = 666;
            [cell addSubview:textField];
        }
        //输入框
        UITextField *textField = (UITextField *)[cell viewWithTag:666];
        if (indexPath.row == 1) {
            textField.placeholder = @"请输入提现密码（6~16位）";
            _pwdTextField = textField;
        } else {
            textField.placeholder = @"请再次输入提现密码（6~16位）";
            _surePwdTextField = textField;
        }
        return cell;
    }
}

#pragma mark --- 获取验证码按钮
- (void)setWithdrawalPwdVerifyButtonPressed {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self showWaitView:@"请稍等..."];
    _verifyButton.enabled = NO;
    //获取验证码
    [self userGetVerifyCodeWithUserTel:[UserInfoEngine getUserInfo].userLoginName requestType:2];
}

#pragma mark --- 获取验证码接口
- (void)userGetVerifyCodeWithUserTel:(NSString *)userTel
                         requestType:(NSInteger)requestType {
    self.op = [[[UserLoginNetWorkEngine alloc] init] getVerifyCodeWithUserTel:userTel requestType:requestType successed:^(NSInteger code) {
        switch (code) {
            case 100: {
                [self showSuccessView:@"验证码已发送至您的手机,请注册查收"];
                [self timeFireMethodAction];
            }
                break;
                
            case 101: {
                [self showErrorView:@"验证码获取失败"];
                _verifyButton.enabled = YES;
            }
                break;
                
            case 103: {
                [self showErrorView:@"手机号格式错误"];
                _verifyButton.enabled = YES;
            }
                break;
                
            case 104: {
                [self showErrorView:@"用户已存在"];
                _verifyButton.enabled = YES;
            }
                break;
                
            case 105: {
                [self showErrorView:@"用户不存在"];
                _verifyButton.enabled = YES;
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常,请稍后重试"];
                _verifyButton.enabled = YES;
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        _verifyButton.enabled = YES;
        [self showErrorView:@"网络连接错误,请稍后重试"];
    }];
}

#pragma mark --- 计时器事件
- (void)timeFireMethodAction {
    __block int timeout = 120; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_verifyButton setTitle:@"重新获取" forState:UIControlStateNormal];
                _verifyButton.enabled = YES;
            });
        } else {
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%@", [@(seconds) stringValue]];
            dispatch_async(dispatch_get_main_queue(), ^{
                //让按钮变为不可点击
                _verifyButton.enabled = NO;
                [_verifyButton setTitle:[NSString stringWithFormat:@"%@s后重发",strTime] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

#pragma mark --- 设置提现密码按钮点击事件
- (void)submitWithdrawalPwdButtonClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_codeTextField.text.length == 0) {
        [self showErrorView:@"请输入验证码"];
        return;
    }
    if (_pwdTextField.text.length > 16 ||_pwdTextField.text.length < 6) {
        [self showErrorView:@"请输入6~16位提现密码"];
        return;
    }
    if (_surePwdTextField.text.length > 16 ||_surePwdTextField.text.length < 6) {
        [self showErrorView:@"请再次输入6~16位提现密码"];
        return;
    }
    if (![_pwdTextField.text isEqualToString:_surePwdTextField.text]) {
        [self showErrorView:@"两次密码不一致"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    //设置密码接口
    [self updateWithdrawalsPwdWithUserID:[UserInfoEngine getUserInfo].userID verifyCode:_codeTextField.text withdrawalsPwd:_pwdTextField.text];
}

#pragma mark --- 设置密码接口
- (void)updateWithdrawalsPwdWithUserID:(NSInteger)userID
                            verifyCode:(NSString *)verifyCode
                        withdrawalsPwd:(NSString *)withdrawalsPwd {
    self.op = [[[AccountNetWorkEngine alloc] init] updateWithdrawalsPwdWithUserID:userID verifyCode:verifyCode withdrawalsPwd:withdrawalsPwd successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"设置成功"];
                if (_setWithdrawalPwdSuccessed) {
                    _setWithdrawalPwdSuccessed();
                }
                if (_viewType) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    //提现
                    WithdrawalViewController *withdrawalViewController = [[WithdrawalViewController alloc] initWithViewType:1 withdrawalSuccessedBlock:^{
                        if (_setWithdrawalPwdSuccessed) {
                            _setWithdrawalPwdSuccessed();
                        }
                    }];
                    [self.navigationController pushViewController:withdrawalViewController animated:YES];
                }
            }
                break;
                
            case 101: {
                [self showErrorView:@"设置失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"验证码错误"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"验证码超时"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常,请稍后重试"];
                _verifyButton.enabled = YES;
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接错误,请稍后重试"];
    }];
}

@end
