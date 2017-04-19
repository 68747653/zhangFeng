//
//  EditTelphoneViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "EditTelphoneViewController.h"
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
#import "UserLoginNetWorkEngine.h"
#import "NSString+Addition.h"
#import "AppDelegate.h"
#import "UserLoginNetWorkEngine.h"

@interface EditTelphoneViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) EditTelphoneViewType viewType;
@property (nonatomic, assign) NSInteger mark, requestType;
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UITextField *telTextField, *codeTextField;
@property (nonatomic,strong) HHSoftButton *verifyButton;

@end

@implementation EditTelphoneViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消所有编辑
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (instancetype)initWithEditTelphoneViewType:(EditTelphoneViewType)viewType {
    if (self = [super init]) {
        self.viewType = viewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_viewType == VerifyTelType) {
        self.navigationItem.title = @"安全验证";
        _mark = 1;
        _requestType = 1;
    } else if (_viewType == EditTelType) {
        self.navigationItem.title = @"修改手机号";
        _mark = 2;
        _requestType = 0;
    }
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *codeCell = @"codeCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:codeCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:codeCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            //手机号码
            _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, [HHSoftAppInfo AppScreen].width-20-90-15-5, 44)];
            _telTextField.placeholder = @"手机号码";
            _telTextField.keyboardType = UIKeyboardTypeNumberPad;
            _telTextField.font = [UIFont systemFontOfSize:14.0];
            _telTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            _telTextField.textAlignment = NSTextAlignmentLeft;
            if (_viewType == VerifyTelType) {
                _telTextField.enabled = NO;
                _telTextField.text = [UserInfoEngine getUserInfo].userLoginName;
            }
            [cell addSubview:_telTextField];
            //按钮
            //获取验证码
            _verifyButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-110, 7, 90, 30)];
            [_verifyButton setTitle:@"发送验证码" forState:UIControlStateNormal];
            _verifyButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
            _verifyButton.layer.cornerRadius = 3.0;
            _verifyButton.layer.masksToBounds = YES;
            _verifyButton.layer.borderColor = [GlobalFile themeColor].CGColor;
            _verifyButton.layer.borderWidth = 1;
            [_verifyButton setTitleColor:[GlobalFile themeColor] forState:0];
            [_verifyButton addTarget:self action:@selector(verifyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_verifyButton];
            //下线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 43, [HHSoftAppInfo AppScreen].width-40, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
            [cell addSubview:lineView];
        }
        return cell;
    } else {
        static NSString *strCell = @"strCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            //输入框
            _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, [HHSoftAppInfo AppScreen].width-40, 44)];
            _codeTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            _codeTextField.font = [UIFont systemFontOfSize:14.0];
            _codeTextField.placeholder = @"验证码";
            _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:_codeTextField];
            //下线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 43, [HHSoftAppInfo AppScreen].width-40, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
            [cell addSubview:lineView];
        }
        return cell;
    }
}

#pragma mark --- 提交按钮点击事件
- (void)commitButtonClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_telTextField.text.length == 0) {
        [self showErrorView:@"请输入手机号"];
        return;
    }
    if (![_telTextField.text isPhoneNumber]) {
        [self showErrorView:@"手机号格式错误"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    [self editUserTelWithWithUserID:[UserInfoEngine getUserInfo].userID mark:_mark userTel:_telTextField.text verifyCode:_codeTextField.text];
}
#pragma mark --- 修改手机号
- (void)editUserTelWithWithUserID:(NSInteger)userID mark:(NSInteger)mark userTel:(NSString *)userTel verifyCode:(NSString *)verifyCode {
    self.op = [[[UserCenterNetWorkEngine alloc] init] editUserTelWithWithUserID:userID mark:mark userTel:userTel verifyCode:verifyCode successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                if (_viewType == VerifyTelType) {
                    EditTelphoneViewController *editTelViewController = [[EditTelphoneViewController alloc] initWithEditTelphoneViewType:EditTelType];
                    [self.navigationController pushViewController:editTelViewController animated:YES];
                } else if (_viewType == EditTelType) {
                    [self showWaitView:@"请稍等..."];
                    self.view.userInteractionEnabled = NO;
                    [self logout];
                }
            }
                break;
                
            case 101: {
                [self showErrorView:@"修改失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"手机号格式错误"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"手机号已经存在"];
            }
                break;
                
            case 105: {
                [self showErrorView:@"验证码错误"];
            }
                break;
                
            case 106: {
                [self showErrorView:@"验证码超时（超过120秒）"];
            }
                break;
                
            case 107: {
                [self showErrorView:@"该手机号不存在"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常,请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败,请稍后重试"];
    }];
}
#pragma mark --- 获取验证码按钮点击事件
- (void)verifyButtonPressed {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_telTextField.text.length == 0) {
        [self showErrorView:@"请输入手机号"];
        return;
    }
    if (![_telTextField.text isPhoneNumberNew]) {
        [self showErrorView:@"手机号格式错误"];
        return;
    }
    if (_viewType == EditTelType) {
        if ([_telTextField.text isEqualToString:[UserInfoEngine getUserInfo].userLoginName]) {
            [self showErrorView:@"新手机号不能与原手机号相同"];
            return;
        }
    }
    [self showWaitView:@"请稍等..."];
    _verifyButton.enabled = NO;
    //获取验证码
    [self userGetVerifyCodeWithUserTel:_telTextField.text requestType:_requestType];
}
#pragma mark --- 获取验证码接口
-(void)userGetVerifyCodeWithUserTel:(NSString *)userTel
                        requestType:(NSInteger)requestType{
    self.op = [[[UserLoginNetWorkEngine alloc] init] getVerifyCodeWithUserTel:userTel requestType:requestType successed:^(NSInteger code) {
        switch (code) {//100:成功,101:失败,102:参数错误,103:手机号格式错误，104:手机号已经存在，105:验证码错误，106：验证码超时，100001:网络连接异常,请稍后重试
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
                [self showErrorView:@"手机号已经存在"];
                _verifyButton.enabled = YES;
            }
                break;
                
            case 105: {
                [self showErrorView:@"验证码错误"];
                _verifyButton.enabled = YES;
            }
                break;
                
            case 106: {
                [self showErrorView:@"验证码超时（超过120秒）"];
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
        [self showErrorView:@"网络连接失败,请稍后重试"];
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
