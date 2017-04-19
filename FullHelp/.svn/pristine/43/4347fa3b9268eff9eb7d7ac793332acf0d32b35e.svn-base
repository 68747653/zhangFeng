//
//  RegisterViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RegisterViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppDelegate.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserLoginNetWorkEngine.h"
#import "AppDelegate.h"
#import "WKWebViewController.h"
#import "NSString+Addition.h"
#import "RegionInfo.h"

@interface RegisterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITextField *telTextField, *codeTextField, *pwdTextField, *certPwdTextField;
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) HHSoftButton *verifyButton, *selectButton, *agreementButton;

@end

@implementation RegisterViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消所有编辑
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
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
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 160)];
        //已有账号，登录
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-140, 10, 120, 20)];
        [loginButton setTitle:@"已有账号，去登录" forState:UIControlStateNormal];
        [loginButton setTitleColor:[GlobalFile themeColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_footerView addSubview:loginButton];
        [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //注册
        UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 60, [HHSoftAppInfo AppScreen].width-20, 40)];
        registerButton.backgroundColor = [GlobalFile themeColor];
        [registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        registerButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        registerButton.layer.cornerRadius = 3.0;
        registerButton.layer.masksToBounds = YES;
        [_footerView addSubview:registerButton];
        [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //是否同意协议
        _selectButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(5, 108, 45, 45) titleColor:nil titleSize:12.0];
        [_selectButton setImage:[UIImage imageNamed:@"login_no_agree"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"login_agree"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.selected = YES;
        [_footerView addSubview:_selectButton];
        
        NSString *str = @"我已阅读并同意";
        CGSize size = [str boundingRectWithfont:[UIFont systemFontOfSize:13] maxTextSize:CGSizeMake(100, 45) ];
        HHSoftLabel *agreementLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(40, 108, size.width, 45) fontSize:13.0 text:str textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [_footerView addSubview:agreementLabel];
        //协议按钮
        NSString *strButton = @"鼎利相助用户协议";
        CGSize sizeBiutton = [strButton boundingRectWithfont:[UIFont systemFontOfSize:13.0] maxTextSize:CGSizeMake(150, 45) ];
        _agreementButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(agreementLabel.frame), CGRectGetMinY(agreementLabel.frame), sizeBiutton.width, 45)];
        [_agreementButton setTitle:@"鼎利相助用户协议" forState:UIControlStateNormal];
        [_agreementButton setTitleColor:[GlobalFile themeColor] forState:UIControlStateNormal];
        _agreementButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        _agreementButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_agreementButton addTarget:self action:@selector(agreementButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_agreementButton];
        
    }
    return _footerView;
}

#pragma mark --- tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
            //图标
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 9, 20, 25)];
            imageView.tag = 311;
            [cell.contentView addSubview:imageView];
            //手机号码
            _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, [HHSoftAppInfo AppScreen].width-50-90-15-5, 44)];
            _telTextField.placeholder = @"手机号码";
            _telTextField.keyboardType = UIKeyboardTypeNumberPad;
            _telTextField.font = [UIFont systemFontOfSize:14.0];
            _telTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            _telTextField.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:_telTextField];
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
            [cell.contentView addSubview:_verifyButton];
            //下线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 43, [HHSoftAppInfo AppScreen].width-40, 1)];
            lineView.backgroundColor = [GlobalFile colorWithRed:229.0 green:229.0 blue:229.0 alpha:1.0];
            [cell.contentView addSubview:lineView];
        }
        //图标
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:311];
        imageView.image = [UIImage imageNamed:@"login_name"];
        return cell;
    }else{
        static NSString *strCell = @"strCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            //图标
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 9, 20, 25)];
            imageView.tag = 321;
            [cell.contentView addSubview:imageView];
            //输入框
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, [HHSoftAppInfo AppScreen].width-70, 44)];
            textField.tag = 322;
            textField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            textField.font = [UIFont systemFontOfSize:14.0];
            [cell.contentView addSubview:textField];
            //下线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 43, [HHSoftAppInfo AppScreen].width-40, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
            [cell.contentView addSubview:lineView];
        }
        //图标
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:321];
        //输入框
        UITextField *textField = (UITextField *)[cell.contentView viewWithTag:322];
        if (indexPath.row == 1) {
            imageView.image = [UIImage imageNamed:@"login_code"];
            textField.placeholder = @"验证码";
            textField.keyboardType = UIKeyboardTypeNumberPad;
            _codeTextField = textField;
        } else if (indexPath.row == 2) {
            imageView.image = [UIImage imageNamed:@"login_pwd"];
            textField.placeholder = @"密码（6~16位）";
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            textField.secureTextEntry = YES;
            _pwdTextField = textField;
        } else if (indexPath.row == 3) {
            imageView.image = [UIImage imageNamed:@"login_pwd"];
            textField.placeholder = @"确认密码（6~16位）";
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            textField.secureTextEntry = YES;
            _certPwdTextField = textField;
        }
        return cell;
    }
}

#pragma mark --- 已有账号，去登录
- (void)loginButtonClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    for (UIViewController *viewController in self.navigationController.childViewControllers) {
        if ([NSStringFromClass([viewController class]) isEqualToString:@"LoginViewController"]) {
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
    }
}

#pragma mark --- 选择协议按钮点击事件
- (void)selectButtonPressed {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_selectButton.selected == YES) {
        _selectButton.selected = NO;
    } else {
        _selectButton.selected = YES;
    }
}

#pragma mark --- 用户协议按钮点击事件
- (void)agreementButtonPressed {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //跳转用户协议
    WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithUrl:@"" WkWebType:WKWebTypeWithRegist MessageTitle:@"用户协议"];
    [self.navigationController pushViewController:wkWebViewController animated:YES];
}
#pragma mark --- 注册按钮点击事件
- (void)registerButtonClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_telTextField.text.length == 0) {
        [self showErrorView:@"请输入手机号"];
        return;
    }
    if (![_telTextField.text isPhoneNumberNew]) {
        [self showErrorView:@"手机号格式错误"];
        return;
    }
    if (_codeTextField.text.length == 0) {
        [self showErrorView:@"请输入验证码"];
        return;
    }
    if (_pwdTextField.text.length == 0) {
        [self showErrorView:@"请输入密码"];
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
    if (_selectButton.selected == NO) {
        [self showErrorView:@"请同意用户协议"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    [self userRegistWithDeviceToken:[HHSoftAppDelegate deviceToken] deviceType:1 loginPwd:_pwdTextField.text loginName:_telTextField.text verifyCode:_codeTextField.text];
}
#pragma mark --- 注册接口
- (void)userRegistWithDeviceToken:(NSString *)deviceToken
                       deviceType:(NSInteger)deviceType
                         loginPwd:(NSString *)loginPwd
                        loginName:(NSString *)loginName
                       verifyCode:(NSString *)verifyCode {
    self.op = [[[UserLoginNetWorkEngine alloc] init] userRegisterWithUserInfo:[UserInfoEngine getRegisterUserInfo] loginName:loginName verifyCode:verifyCode loginPassword:loginPwd deviceType:deviceType deviceToken:deviceToken successed:^(NSInteger code, UserInfo *userInfo) {
        self.view.userInteractionEnabled = YES;
        switch (code) {//100:注册成功,101:注册失败,102:参数错误,103：手机号格式错误 ，104：验证码错误，105：验证码超时，106：用户已存在，100001:网络连接异常,请稍后重试
            case 100: {
                RegionInfo *regionInfo = [RegionInfo getRegionInfo];
                if (!regionInfo) {
                    regionInfo = [[RegionInfo alloc] init];
                }
                regionInfo.provinceID = userInfo.userProvinceID;
                regionInfo.provinceName = userInfo.userProvinceName;
                [RegionInfo setRegionInfo:regionInfo];
                [UserInfoEngine setRegisterUserInfo:nil];
                userInfo.userLoginName = loginName;
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:loginName, @"user_userLoginName", nil];
                [UserInfoEngine setUserLoginDict:dict];
                [UserInfoEngine setUserInfo:userInfo];
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appDelegate.window.rootViewController = [AppDelegate getRootViewController];
            }
                break;
                
            case 101: {
                [self showErrorView:@"注册失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"手机号格式错误"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"验证码错误"];
            }
                break;
                
            case 105: {
                [self showErrorView:@"验证码超时（超过120秒）"];
            }
                break;
                
            case 106: {
                [self showErrorView:@"用户已存在"];
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
    [self showWaitView:@"请稍等..."];
    _verifyButton.enabled = NO;
    //获取验证码
    [self userGetVerifyCodeWithUserTel:_telTextField.text requestType:0];
}
#pragma mark --- 获取验证码接口
-(void)userGetVerifyCodeWithUserTel:(NSString *)userTel
                        requestType:(NSInteger)requestType{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
