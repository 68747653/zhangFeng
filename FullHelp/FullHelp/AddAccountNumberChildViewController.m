//
//  AddAccountNumberChildViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AddAccountNumberChildViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "AccountNetWorkEngine.h"
#import "AccountInfo.h"
#import "GlobalFile.h"
#import "UserLoginNetWorkEngine.h"

@interface AddAccountNumberChildViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTable;
@property (nonatomic, assign) NSInteger payType;
@property (nonatomic, strong) AccountInfo *accountInfo;
@property (nonatomic, assign) NSInteger viewType;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, assign) NSInteger countTime;
@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) HHSoftButton *registerButton;
@property(nonatomic, copy) NSString *verifyCode;


@end

@implementation AddAccountNumberChildViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithViewType:(NSInteger)viewType addAccountNumberSuccessed:(AddAccountNumberSuccessed)addAccountNumberSuccessed {
    if (self = [super init]) {
        self.viewType =viewType;
        self.addAccountNumberSuccessed = addAccountNumberSuccessed;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _accountInfo = [[AccountInfo alloc]init];
    _accountInfo.accountType = 1;
    _accountInfo.accountIsDefault = 1;
    if (_viewType == 0) {
        _accountInfo.accountType = 0;
    } else {
        _accountInfo.accountType = 1;
    }
    _accountInfo.accountBankName = @"";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self initDataTable];
    [self tableViewFooterView];
}

- (void)addAccountNumber {
    [self.view endEditing:YES];
    if (_verifyCode.length == 0) {
        [self showErrorView:@"请输入验证码"];
        return;
    }
    if (_accountInfo.accountNo.length == 0) {
        [self showErrorView:@"请输入账号"];
        return;
    }
    if (_accountInfo.accountCardHolder.length == 0) {
        [self showErrorView:@"账号所属人"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    [self addUserAccountWithUserID:[UserInfoEngine getUserInfo].userID accountNo:_accountInfo.accountNo accountType:_accountInfo.accountType trueName:_accountInfo.accountCardHolder verifyCode:_verifyCode isDefault:_accountInfo.accountIsDefault];
}

#pragma mark --- 添加账户接口
- (void)addUserAccountWithUserID:(NSInteger)userID
                       accountNo:(NSString *)accountNo
                     accountType:(NSInteger)accountType
                        trueName:(NSString *)trueName
                      verifyCode:(NSString *)verifyCode
                       isDefault:(NSInteger)isDefault {
    self.op = [[[AccountNetWorkEngine alloc] init] addUserAccountWithUserID:userID accountNo:accountNo accountType:accountType trueName:trueName verifyCode:verifyCode isDefault:isDefault bankName:@"" successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"添加成功"];
                if (_addAccountNumberSuccessed) {
                    _addAccountNumberSuccessed();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
                
            case 101: {
                [self showErrorView:@"添加失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"同一类型的账号相同"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"验证码错误"];
            }
                break;
                
            case 105: {
                [self showErrorView:@"验证码超时"];
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

- (void)tableViewFooterView {
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 220)];
    //设置默认账号按钮
    HHSoftButton *setDefaultButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(0, 10, [HHSoftAppInfo AppScreen].width/2.0, 30) innerImage:[UIImage imageNamed:@"login_agree.png"] innerImageRect:CGRectMake(15, 7.5, 15, 15) descTextRect:CGRectMake(32, 0, [HHSoftAppInfo AppScreen].width/2.0-32, 30) descText:@"设为默认账户" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:13.0] textAligment:NSTextAlignmentLeft];
    setDefaultButton.selected = YES;
    [footerView addSubview:setDefaultButton];
    [setDefaultButton addTarget:self action:@selector(setDefaultAccountButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //说明
    HHSoftLabel *showLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 40, [HHSoftAppInfo AppScreen].width-30, 40) fontSize:12.0 text:[NSString stringWithFormat:@"*短信验证码将发送到尾号为%@的手机上，请注意查收。",[[UserInfoEngine getUserInfo].userLoginName substringFromIndex:7]] textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    [footerView addSubview:showLabel];
    //确定按钮
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 100, [HHSoftAppInfo AppScreen].width-30, 40)];
    sureButton.backgroundColor = [GlobalFile themeColor];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    sureButton.layer.cornerRadius = 3.0;
    sureButton.layer.masksToBounds = YES;
    [footerView addSubview:sureButton];
    [sureButton addTarget:self action:@selector(addAccountNumber) forControlEvents:UIControlEventTouchUpInside];
    _dataTable.tableFooterView = footerView;
}

- (void)initDataTable {
    if (_dataTable == nil) {
        _dataTable = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
        [self.view addSubview:_dataTable];
    }
}

#pragma mark --- tableView的代理
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
    static NSString *buttonCell = @"buttonCell";
    static NSString *inputCellIndi = @"inputCell";
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buttonCell];
            
            HHSoftLabel *titleLabel = [[HHSoftLabel alloc]initWithFrame:CGRectMake(15, 10, 90, 24) fontSize:14.0 text:@"手机验证码：" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
            
            [cell addSubview:titleLabel];
            
            UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, [HHSoftAppInfo AppScreen].width-105-100-2, 44)];
            inPutTextField.placeholder = @"请输入验证码";
            inPutTextField.keyboardType = UIKeyboardTypeNumberPad;
            inPutTextField.font = [UIFont systemFontOfSize:14.0];
            inPutTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            inPutTextField.delegate = self;
            inPutTextField.tag = 1;
            [cell addSubview:inPutTextField];
            
            _registerButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-100, 0, 100, 44)];
            [_registerButton setTitle:@"发送验证码" forState:UIControlStateNormal];
            _registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
            [_registerButton setTitleColor:[GlobalFile themeColor] forState:UIControlStateNormal];
            [_registerButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_registerButton];
            
            UIView *spView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_registerButton.frame)-2, 0, 2, 44)];
            spView.backgroundColor = [GlobalFile backgroundColor];
            [cell addSubview:spView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inputCellIndi];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inputCellIndi];
            HHSoftLabel *titleLabel = [[HHSoftLabel alloc]initWithFrame:CGRectMake(15, 10, 90, 24) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
            [cell addSubview:titleLabel];
            titleLabel.tag = 100;
            
            UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, [HHSoftAppInfo AppScreen].width-105, 44)];
            inPutTextField.placeholder = @"";
            inPutTextField.delegate = self;
            inPutTextField.font = [UIFont systemFontOfSize:14.0];
            inPutTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            [cell.contentView addSubview:inPutTextField];
            inPutTextField.tag = 101;
        }
        HHSoftLabel *titleLabel = (HHSoftLabel *)[cell viewWithTag:100];
        UITextField *inPutTextField = (UITextField *)[cell viewWithTag:101];
        if (indexPath.row == 1) {
            if (_viewType == 0) {
                titleLabel.text = @"支付宝账号：";
            } else {
                titleLabel.text = @"微信账号：";
            }
            inPutTextField.tag = 2;
            inPutTextField.keyboardType = UIKeyboardTypeASCIICapable;
            inPutTextField.placeholder = @"请输入账号";
        } else {
            inPutTextField.tag = 3;
            titleLabel.text = @"账号所属人：";
            inPutTextField.placeholder = @"请输入姓名";
            inPutTextField.keyboardType = UIKeyboardTypeDefault;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark --- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 1: {
            _verifyCode = textField.text;
            
        }
            break;
            
        case 2: {
            _accountInfo.accountNo = textField.text;
        }
            break;
            
        default: {
            _accountInfo.accountCardHolder = textField.text;
        }
            break;
    }
}

#pragma mark --- 设置默认账户按钮点击事件
- (void)setDefaultAccountButtonClick:(HHSoftButton *)sender {
    if (sender.selected == YES) {
        sender.selected = NO;
        [sender setSelectImage:[UIImage imageNamed:@"login_no_agree"] descText:@"设为默认账户" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:13.0]];
        _accountInfo.accountIsDefault = 0;
    } else {
        sender.selected=YES;
        [sender setSelectImage:[UIImage imageNamed:@"login_agree"] descText:@"设为默认账户" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:13.0]];
        _accountInfo.accountIsDefault = 1;
    }
}

#pragma mark --- 获取验证码按钮
-(void)registerButtonPressed:(HHSoftButton *)button{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self showWaitView:@"请稍等..."];
    _registerButton.enabled = NO;
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
                _registerButton.enabled = YES;
            }
                break;
                
            case 103: {
                [self showErrorView:@"手机号格式错误"];
                _registerButton.enabled = YES;
            }
                break;
                
            case 104: {
                [self showErrorView:@"用户已存在"];
                _registerButton.enabled = YES;
            }
                break;
                
            case 105: {
                [self showErrorView:@"用户不存在"];
                _registerButton.enabled = YES;
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
                _registerButton.enabled = YES;
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        _registerButton.enabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

#pragma mark --- 计时器事件
- (void)timeFireMethodAction {
    __block int timeout = 120; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_registerButton setTitle:@"重新获取" forState:UIControlStateNormal];
                _registerButton.enabled = YES;
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%@", [@(seconds) stringValue]];
            dispatch_async(dispatch_get_main_queue(), ^{
                //让按钮变为不可点击
                _registerButton.enabled = NO;
                [_registerButton setTitle:[NSString stringWithFormat:@"%@s后重发",strTime] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

@end
