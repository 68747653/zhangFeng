//
//  AddAccountViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AddAccountViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserCenterNetWorkEngine.h"
#import "UserLoginNetWorkEngine.h"
#import "AccountNetWorkEngine.h"
#import "BankViewController.h"
#import "BankInfo.h"

@interface AddAccountViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) UIView *footerView, *lineView;
@property (nonatomic, copy) AddAccountSuccessedBlock addAccountSuccessedBlock;
@property (nonatomic, assign) NSInteger accountType, isDefault;
@property (nonatomic, strong) UITextField *codeTextField, *accountTextField, *nameTextField;
@property (nonatomic, strong) HHSoftButton *verifyButton, *cardButton, *alipayButton, *wxButton;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, copy) NSString *bankName;

@end

@implementation AddAccountViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithAddAccountSuccessedBlock:(AddAccountSuccessedBlock)addAccountSuccessedBlock {
    if(self = [super init]){
        self.addAccountSuccessedBlock = addAccountSuccessedBlock;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消所有编辑
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"添加账户";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    _accountType = 3;
    _isDefault = 1;
    _bankName = @"";
    [self.view addSubview:self.dataTableView];
}

#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
        _dataTableView.tableFooterView = self.footerView;
    }
    return _dataTableView;
}

#pragma mark --- 初始化footerView
- (UIView *)footerView {
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 160)];
        //设置默认账号按钮
        HHSoftButton *setDefaultButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(0, 10, [HHSoftAppInfo AppScreen].width/2.0, 30) innerImage:[UIImage imageNamed:@"addressmanager_default"] innerImageRect:CGRectMake(15, 7.5, 15, 15) descTextRect:CGRectMake(32, 0, [HHSoftAppInfo AppScreen].width/2.0-32, 30) descText:@"设为默认账户" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:13.0] textAligment:NSTextAlignmentLeft];
        setDefaultButton.selected = YES;
        [_footerView addSubview:setDefaultButton];
        [setDefaultButton addTarget:self action:@selector(setDefaultAccountButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //说明
        HHSoftLabel *showLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 40, [HHSoftAppInfo AppScreen].width-30, 40) fontSize:12.0 text:@"短信验证码将发送到账户绑定的手机上，请注意查收。" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
        [_footerView addSubview:showLabel];
        //确定按钮
        UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 100, [HHSoftAppInfo AppScreen].width-30, 40)];
        sureButton.backgroundColor = [GlobalFile themeColor];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        sureButton.layer.cornerRadius = 3.0;
        sureButton.layer.masksToBounds = YES;
        [_footerView addSubview:sureButton];
        [sureButton addTarget:self action:@selector(sureAddAccountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (_accountType == 3) {
        return 4;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *typeCell = @"typeCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:typeCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:typeCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //银行卡
            _cardButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width/2.0, 44.0)];
            [_cardButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [_cardButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateSelected];
            [_cardButton setTitle:@"银行卡" forState:UIControlStateNormal];
            _cardButton.selected = YES;
            [cell addSubview:_cardButton];
            [_cardButton addTarget:self action:@selector(cardButtonClick) forControlEvents:UIControlEventTouchUpInside];
            //支付宝
            _alipayButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0, 0, [HHSoftAppInfo AppScreen].width/2.0, 44.0)];
            [_alipayButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [_alipayButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateSelected];
            [_alipayButton setTitle:@"支付宝" forState:UIControlStateNormal];
            _alipayButton.selected = NO;
            [cell addSubview:_alipayButton];
            [_alipayButton addTarget:self action:@selector(alipayButtonClick) forControlEvents:UIControlEventTouchUpInside];
//            //微信
//            _wxButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0, 0, [HHSoftAppInfo AppScreen].width/2.0, 44.0)];
//            [_wxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//            [_wxButton setTitleColor:[HHSoftAppInfo defaultDeepSystemColor] forState:UIControlStateSelected];
//            [_wxButton setTitle:@"微信" forState:UIControlStateNormal];
//            _wxButton.selected = NO;
//            [cell addSubview:_wxButton];
//            [_wxButton addTarget:self action:@selector(wxButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 42, [HHSoftAppInfo AppScreen].width/2.0 - 40, 2)];
            _lineView.backgroundColor = [GlobalFile themeColor];
            [cell addSubview:_lineView];
        }
        return cell;
    } else {
        if (indexPath.row == 0) {
            static NSString *codeCell = @"codeCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:codeCell];
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:codeCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                //验证码
                _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, [HHSoftAppInfo AppScreen].width-90-90-15-5, 44)];
                _codeTextField.placeholder = @"请输入验证码";
                _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
                _codeTextField.font = [UIFont systemFontOfSize:14.0];
                _codeTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
                _codeTextField.textAlignment = NSTextAlignmentLeft;
                _codeTextField.delegate = self;
                [cell addSubview:_codeTextField];
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-106, 7, 1, 30)];
                lineView.backgroundColor = [GlobalFile colorWithRed:223.0 green:223.0 blue:223.0 alpha:1.0];
                [cell addSubview:lineView];
                //按钮
                //获取验证码
                _verifyButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-105, 7, 90, 30)];
                [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                _verifyButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//                _verificationButton.layer.cornerRadius = 3.0;
//                _verificationButton.layer.masksToBounds = YES;
//                _verificationButton.layer.borderColor = [GlobalFile themeColor].CGColor;
//                _verificationButton.layer.borderWidth = 1;
                [_verifyButton setTitleColor:[GlobalFile themeColor] forState:0];
                [_verifyButton addTarget:self action:@selector(verifyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:_verifyButton];
            }
            cell.textLabel.text = @"验   证   码";
            cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            return cell;
        } else {
            if (_accountType == 3 && indexPath.row == 1) {
                static NSString *menuCell = @"BankInfoCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:menuCell];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
                    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
                    cell.detailTextLabel.textColor = [HHSoftAppInfo defaultLightSystemColor];
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
                }
                cell.textLabel.text = @"开户银行";
                if (_bankName.length) {
                    cell.detailTextLabel.text = _bankName;
                } else {
                    cell.detailTextLabel.text = @"请选择开户银行";
                }
                return cell;
            }
            static NSString *menuCell = @"menuCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //输入框
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, [HHSoftAppInfo AppScreen].width-90-15, 44.0)];
                textField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
                textField.font = [UIFont systemFontOfSize:14.0];
                textField.tag = 365;
                textField.delegate = self;
                [cell.contentView addSubview:textField];
            }
            //输入框
            UITextField *textField = (UITextField *)[cell.contentView viewWithTag:365];
            if (_accountType == 3) {
                if (indexPath.row == 2) {
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                    textField.placeholder = @"请输入账号";
                    cell.textLabel.text = @"账         号";
                    _accountTextField = textField;
                } else if (indexPath.row == 3) {
                    textField.keyboardType = UIKeyboardTypeDefault;
                    cell.textLabel.text = @"账号所属人";
                    textField.placeholder = @"请输入姓名";
                    _nameTextField = textField;
                }
            } else {
                if (indexPath.row == 1) {
                    textField.keyboardType = UIKeyboardTypeASCIICapable;
                    textField.placeholder = @"请输入账号";
                    cell.textLabel.text = @"账         号";
                    _accountTextField = textField;
                } else if (indexPath.row == 2) {
                    textField.keyboardType = UIKeyboardTypeDefault;
                    cell.textLabel.text = @"账号所属人";
                    textField.placeholder = @"请输入姓名";
                    _nameTextField = textField;
                }
            }
            cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_accountType == 3) {
        if (indexPath.section) {
            if (indexPath.row) {
                BankViewController *bankViewController = [[BankViewController alloc] initWithSelectBankSuccessed:^(BankInfo *bankInfo) {
                    _bankName = bankInfo.bankName;
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.detailTextLabel.text = _bankName;
                }];
                [self.navigationController pushViewController:bankViewController animated:YES];
            }
        }
    }
}
#pragma mark --- 设置默认账户按钮点击事件
- (void)setDefaultAccountButtonClick:(HHSoftButton *)sender {
    if (sender.selected == YES) {
        sender.selected = NO;
        [sender setSelectImage:[UIImage imageNamed:@"addressmanager_notdefault"] descText:@"设为默认账户" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:13.0]];
        _isDefault = 0;
    } else {
        sender.selected=YES;
        [sender setSelectImage:[UIImage imageNamed:@"addressmanager_default"] descText:@"设为默认账户" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:13.0]];
        _isDefault = 1;
    }
}

#pragma mark --- 银行卡按钮点击事件
- (void)cardButtonClick {
    if (_cardButton.selected == NO) {
        [UIView animateWithDuration:0.25 animations:^{
            _lineView.frame = CGRectMake(20, 42, [HHSoftAppInfo AppScreen].width/2.0 - 40, 2);
        }];
        _alipayButton.selected = NO;
//        _wxButton.selected = NO;
        _accountType = 3;
        [self changeAccountType];
    }
}

#pragma mark --- 支付宝按钮点击事件
- (void)alipayButtonClick {
    if (_alipayButton.selected == NO) {
        [UIView animateWithDuration:0.25 animations:^{
            _lineView.frame = CGRectMake([HHSoftAppInfo AppScreen].width/2.0+20, 42, [HHSoftAppInfo AppScreen].width/2.0 - 40, 2);
        }];
        _cardButton.selected = NO;
        _alipayButton.selected = YES;
//        _wxButton.selected = NO;
        _accountType = 1;
        [self changeAccountType];
    }
}

#pragma mark --- 微信按钮点击事件
- (void)wxButtonClick {
//    if (_wxButton.selected == NO)  {
//        [UIView animateWithDuration:0.25 animations:^{
//            _lineView.frame = CGRectMake([HHSoftAppInfo AppScreen].width/2.0+20, 42, [HHSoftAppInfo AppScreen].width/2.0 - 40, 2);
//        }];
//        _cardButton.selected = NO;
//        _alipayButton.selected = NO;
//        _wxButton.selected = YES;
//        _accountType = 2;
//        [self changeAccountType];
//    }
}

- (void)changeAccountType {
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyButton.enabled = YES;
    _codeTextField.text = @"";
    _bankName = @"";
    _accountTextField.text = @"";
    _nameTextField.text = @"";
    [_dataTableView reloadData];
}
#pragma mark --- 获取验证码按钮点击事件
- (void)verifyButtonPressed {
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
        if(timeout <= 0){ //倒计时结束，关闭
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
    _timer = timer;
}

#pragma mark --- UITextViewDelegate
- (void)textFieldTextDidChange:(NSNotification *)noti {
    UITextField *field = noti.object;
    if (field == _accountTextField) {
        NSString *text = field.text;
        NSInteger length = 50-text.length;
        if (field.markedTextRange == nil) {
            if (length < 0) {
                [self showErrorView:@"最多输入50个字"];
                field.text = [text substringToIndex:50];
            }
        }
    } else if (field == _nameTextField) {
        NSString *text = field.text;
        NSInteger length = 50-text.length;
        if (field.markedTextRange == nil) {
            if (length < 0) {
                [self showErrorView:@"最多输入50个字"];
                field.text = [text substringToIndex:50];
            }
        }
    } else {
        NSString *text = field.text;
        NSInteger length = 6-text.length;
        if (field.markedTextRange == nil) {
            if (length < 0) {
                field.text = [text substringToIndex:6];
            }
        }
    }
}

#pragma mark --- 确定按钮点击事件
- (void)sureAddAccountButtonClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_codeTextField.text.length == 0) {
        [self showErrorView:@"请输入验证码"];
        return;
    }
    if (_accountType == 3) {
        if (_bankName.length == 0) {
            [self showErrorView:@"请选择开户银行"];
            return;
        }
    }
    if (_accountTextField.text.length == 0) {
        [self showErrorView:@"请输入账号"];
        return;
    }
    if (_nameTextField.text.length == 0) {
        [self showErrorView:@"请输入姓名"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    [self addUserAccountWithUserID:[UserInfoEngine getUserInfo].userID accountNo:_accountTextField.text accountType:_accountType trueName:_nameTextField.text verifyCode:_codeTextField.text isDefault:_isDefault];
}

#pragma mark --- 添加账户接口
- (void)addUserAccountWithUserID:(NSInteger)userID
                       accountNo:(NSString *)accountNo
                     accountType:(NSInteger)accountType
                        trueName:(NSString *)trueName
                      verifyCode:(NSString *)verifyCode
                      isDefault:(NSInteger)isDefault {
    self.op = [[[AccountNetWorkEngine alloc] init] addUserAccountWithUserID:userID accountNo:accountNo accountType:accountType trueName:trueName verifyCode:verifyCode isDefault:isDefault bankName:_bankName successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"添加成功"];
                if (_addAccountSuccessedBlock) {
                    _addAccountSuccessedBlock();
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
                [self showErrorView:@"无该手机号"];
            }
                break;
                
            case 105: {
                [self showErrorView:@"验证码错误"];
            }
                break;
                
            case 106: {
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
        [self showErrorView:@"网络连接异常,请稍后重试"];
    }];
}

@end
