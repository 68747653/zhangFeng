//
//  WithdrawalViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "WithdrawalViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "AccountNetworkEngine.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "WithdrawalViewModel.h"
#import "AccountInfo.h"
#import "AccountManageViewController.h"
#import "HHSoftBarButtonItem.h"
#import "AccountTableCell.h"
#import "SetWithdrawalPwdViewController.h"

@interface WithdrawalViewController () <UITextFieldDelegate, UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) HHSoftButton *applyButton;
@property(nonatomic, strong) WithdrawalViewModel *viewModel;
@property (nonatomic, strong) UITextField *amountTextField, *passwordTextField;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) NSInteger viewType;
@property (nonatomic, copy) WithdrawalSuccessedBlock withdrawalSuccessedBlock;
@property (nonatomic, strong) HHSoftLabel *bateLabel;

@end

@implementation WithdrawalViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消所有编辑
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (instancetype)initWithViewType:(NSInteger)viewType withdrawalSuccessedBlock:(WithdrawalSuccessedBlock)withdrawalSuccessedBlock {
    if (self = [super init]) {
        self.viewType = viewType;
        self.withdrawalSuccessedBlock = withdrawalSuccessedBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"提现";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    HHSoftBarButtonItem *backBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithBackBlock:^{
        if (_viewType == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:self.navigationController.childViewControllers.count - 3] animated:YES];
        }
    }];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取用户余额和默认账户
    [self getWithdrawalInfoWithUserID:[UserInfoEngine getUserInfo].userID];
}
#pragma mark --- 获取提现信息
- (void)getWithdrawalInfoWithUserID:(NSInteger )userID {
    self.op = [[[AccountNetWorkEngine alloc] init] getUserFeesAndDefaultWithUserID:userID successed:^(NSInteger code, WithdrawalViewModel *withdrawalViewModel) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _viewModel = withdrawalViewModel;
                
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }
                [self.dataTableView reloadData];
            }
                break;
                
            case 101: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getWithdrawalInfoWithUserID:userID];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getWithdrawalInfoWithUserID:userID];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getWithdrawalInfoWithUserID:userID];
        }];
    }];
}

#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
        _dataTableView.backgroundColor = [GlobalFile backgroundColor];
        _dataTableView.tableFooterView = self.footerView;
    }
    return _dataTableView;
}

#pragma mark --- 初始化footerView
- (UIView *)footerView {
    if (_footerView == nil) {
//        NSString *str = @"*提交申请后，将在3-5个工作日到账。\n*提现只能是100或100的整数。\n*由于支付宝和银行系统原因，提现会收取%1的手续费";
//        CGSize size = [str boundingRectWithfont:[UIFont systemFontOfSize:13.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width, CGFLOAT_MAX)];
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.dataTableView.bounds), 15+20+40+20)];
        _footerView.backgroundColor = [GlobalFile backgroundColor];
        
//        //说明
//        HHSoftLabel *showLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 15, [HHSoftAppInfo AppScreen].width-30, size.height) fontSize:13.0 text:str textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
//        [_footerView addSubview:showLabel];
        
        _applyButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(15, 15+20, CGRectGetWidth(self.dataTableView.bounds)-30, 40) titleColor:[UIColor whiteColor] titleSize:16.0];
        [_applyButton setTitle:@"提交申请" forState:UIControlStateNormal];
        _applyButton.backgroundColor = [GlobalFile themeColor];
        _applyButton.layer.cornerRadius = 3.0;
        _applyButton.layer.masksToBounds = YES;
        [_footerView addSubview:_applyButton];
        [_applyButton addTarget:self action:@selector(applyButtonPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

#pragma mark --- 提交申请
- (void)submitUserApplyAmountWithUserID:(NSInteger)userID
                              accountID:(NSInteger)accountID
                            applyAmount:(CGFloat)applyAmount
                               applyPwd:(NSString *)applyPwd {
    _applyButton.enabled = NO;
    self.op = [[[AccountNetWorkEngine alloc] init] submitUserApplyAmountWithUserID:userID accountID:accountID applyAmount:applyAmount applyPwd:applyPwd successed:^(NSInteger code) {
        _applyButton.enabled=YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"申请提现成功"];
                if (self.withdrawalSuccessedBlock) {
                    self.withdrawalSuccessedBlock();
                }
                if (_viewType == 0) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:self.navigationController.childViewControllers.count - 2] animated:YES];
                }
            }
                break;
                
            case 101: {
                [self showErrorView:@"提现失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"提现密码错误"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"您的可提现余额不足,请修改提现金额"];
            }
                break;
                
            case 105: {
                [self showErrorView:@"账户不存在"];
            }
                break;
                
            case 106: {
                [self showErrorView:@"提现金额只能是100或100的整数倍"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        _applyButton.enabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

- (void)applyButtonPress {
    [self.dataTableView endEditing:YES];
    if ([_amountTextField.text integerValue] % 100 || ![_amountTextField.text integerValue]) {
        [self showErrorView:@"提现金额只能是100或100的整数倍"];
        return;
    }
    if (![_amountTextField.text integerValue]) {
        [self showErrorView:@"请输入提现金额"];
        return;
    }
    if (_viewModel.userFees < [_amountTextField.text integerValue]*100) {
        [self showErrorView:@"您的可提现余额不足,请修改提现金额"];
        return;
    }
    if (!_viewModel.accountInfo.accountID) {
        [self showErrorView:@"请选择提现账户"];
        return;
    }
    if (!_passwordTextField.text.length) {
        [self showErrorView:@"请输入提现密码"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    [self submitUserApplyAmountWithUserID:[UserInfoEngine getUserInfo].userID accountID:_viewModel.accountInfo.accountID applyAmount:[_amountTextField.text integerValue]*100 applyPwd:_passwordTextField.text];
}

#pragma mark --- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section) {
        if (section > 1) {
            return 1;
        }
        if (_viewModel && _viewModel.accountInfo.accountID) {
            return 2;
        }
        return 1;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        if (indexPath.section > 1) {
            return 44.0;
        }
        if (_viewModel && _viewModel.accountInfo.accountID) {
            if (indexPath.row == 1) {
                return 60.0;
            }
        }
        return 44.0;
    }
    if (indexPath.row == 1) {
        NSString *str = @"*提交申请后，将在3-5个工作日到账。\n*提现只能是100或100的整数。\n*由于支付宝和银行系统原因，提现会收取%1的手续费";
        CGSize size = [str boundingRectWithfont:[UIFont systemFontOfSize:11.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-30, CGFLOAT_MAX)];
        return size.height+20;
    }
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30.0;
    }
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 30)];
        _bateLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width - 30, 30) fontSize:12.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [headerView addSubview:_bateLabel];
        return headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 0) {
                static NSString *strCell = @"UserFeesInfoCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
                    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
                    cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前余额：￥%@", [GlobalFile stringFromeFloat:_viewModel.userFees decimalPlacesCount:2]]];
                [attr addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(6, attr.length - 6)];
                cell.textLabel.attributedText = attr;
                return cell;
            } else if (indexPath.row == 1) {
                static NSString *strCell = @"PromptInfoCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
                    NSString *str = @"*提交申请后，将在3-5个工作日到账。\n*提现只能是100或100的整数。\n*由于支付宝和银行系统原因，提现会收取%1的手续费";
                    CGSize size = [str boundingRectWithfont:[UIFont systemFontOfSize:11.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-30, CGFLOAT_MAX)];
                    cell.backgroundColor = [GlobalFile backgroundColor];
                    
                    //说明
                    HHSoftLabel *showLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 10, [HHSoftAppInfo AppScreen].width-30, size.height) fontSize:11.0 text:str textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
                    [cell addSubview:showLabel];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                return cell;
            } else {
                static NSString *strCell = @"PointsInfoCell";
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
                if(cell == nil){
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    HHSoftLabel *nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, 50, 44) fontSize:14.0 text:@"金额：" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
                    [cell addSubview:nameLabel];
                    //输入框
                    _amountTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, [HHSoftAppInfo AppScreen].width-140, 44)];
                    _amountTextField.delegate = self;
                    _amountTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
                    _amountTextField.font = [UIFont systemFontOfSize:14.0];
                    [cell addSubview:_amountTextField];
                    
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_amountTextField.frame)+1, 0, 1, 44)];
                    lineView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
                    [cell addSubview:lineView];
                    
                    HHSoftLabel *countLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_amountTextField.frame)+1, 0, 69, 44) fontSize:15.0 text:@"x100" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
                    [cell addSubview:countLabel];
                }
                _amountTextField.placeholder = @"请输入提现金额";
                _amountTextField.keyboardType = UIKeyboardTypeNumberPad;
                return cell;
            }
//            static NSString *amountTextFieldCellidentifer = @"AmountTextFieldCellidentifer";
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:amountTextFieldCellidentifer];
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:amountTextFieldCellidentifer];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                
//                HHSoftLabel *titleLable = [[HHSoftLabel alloc]initWithFrame:CGRectMake(15, 0, 90, 44) fontSize:14.0 text:@"提现金额" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
//                titleLable.tag = 130;
//                [cell addSubview:titleLable];
//                
//                _amountTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 5, CGRectGetWidth(tableView.bounds)-110-10, 34)];
//                _amountTextField.delegate = self;
//                _amountTextField.placeholder = @"请输入提现金额";
//                _amountTextField.keyboardType = UIKeyboardTypeNumberPad;
//                _amountTextField.font = [UIFont systemFontOfSize:14.0];
//                
//                [cell addSubview:_amountTextField];
//            }
//            return cell;
        }
            break;
            
        case 2: {
            static NSString *pwdTextFieldCellidentifer = @"PwdTextFieldCellidentifer";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pwdTextFieldCellidentifer];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pwdTextFieldCellidentifer];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                HHSoftLabel *titleLable = [[HHSoftLabel alloc]initWithFrame:CGRectMake(15, 0, 90, 44) fontSize:14.0 text:@"提现密码" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
                titleLable.tag=130;
                [cell addSubview:titleLable];
                
                _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 5, CGRectGetWidth(tableView.bounds)-110-100, 34)];
                _passwordTextField.font = [UIFont systemFontOfSize:14.0];
                _passwordTextField.delegate = self;
                _passwordTextField.secureTextEntry = YES;
                _passwordTextField.placeholder = @"请输入提现密码";
                _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
                
                [cell addSubview:_passwordTextField];
                
                HHSoftButton *findPasswordButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake([HHSoftAppInfo AppScreen].width-90, 0, 80, 44) titleColor:[GlobalFile themeColor] titleSize:14.0];
                [findPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
                [findPasswordButton addTarget:self action:@selector(findPasswordButtonPress) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:findPasswordButton];
            }
            return cell;
        }
            break;
            
        case 1: {
            if (indexPath.row == 0) {
                static NSString *titleCellidentifer = @"TitleCellidentifer";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellidentifer];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellidentifer];
                    cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
                    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
                    cell.textLabel.text = @"选择提现账户";
                }
                return cell;
            } else {
                static NSString *titleCellidentifer = @"titleCellidentifer";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellidentifer];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellidentifer];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    //图片
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 44, 44)];
                    imgView.tag = 256;
                    [cell addSubview:imgView];
                    //姓名
                    HHSoftLabel *nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(64, 0, [HHSoftAppInfo AppScreen].width-64-10, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
                    nameLabel.tag = 258;
                    [cell addSubview:nameLabel];
                    //账号
                    HHSoftLabel *accountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(64, 30, [HHSoftAppInfo AppScreen].width-64-10, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
                    accountLabel.tag = 260;
                    [cell addSubview:accountLabel];
                    
//                    HHSoftLabel *titleLable = [[HHSoftLabel alloc]initWithFrame:CGRectMake(15, 0, 90, 44) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
//                    titleLable.tag = 230;
//                    [cell addSubview:titleLable];
//                    
//                    HHSoftLabel *valueLable = [[HHSoftLabel alloc]initWithFrame:CGRectMake(110, 0, CGRectGetWidth(tableView.bounds)-110-10, 44) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
//                    valueLable.tag = 231;
//                    [cell addSubview:valueLable];
                }
//                HHSoftLabel *titleLable = (HHSoftLabel *)[cell viewWithTag:230];
//                HHSoftLabel *valueLable = (HHSoftLabel *)[cell viewWithTag:231];
//                if (indexPath.row == 1) {
//                    titleLable.text = @"账户类型:";
//                    if (_viewModel.accountInfo.accountType == 1) {
//                        valueLable.text = @"支付宝";
//                    } else if (_viewModel.accountInfo.accountType == 2){
//                        valueLable.text = @"微信";
//                    } else if (_viewModel.accountInfo.accountType == 3){
//                        valueLable.text = @"银行卡";
//                    }
//                } else if (indexPath.row == 2) {
//                    titleLable.text = @"账户账号:";
//                    valueLable.text = _viewModel.accountInfo.accountNo;
//                }
                UIImageView *imgView = (UIImageView *)[cell viewWithTag:256];
                HHSoftLabel *nameLabel = (HHSoftLabel *)[cell viewWithTag:258];
                HHSoftLabel *accountLabel = (HHSoftLabel *)[cell viewWithTag:260];
                //图片
                if (_viewModel.accountInfo.accountType == 1) {
                    imgView.image = [UIImage imageNamed:@"account_alipay"];
                } else if (_viewModel.accountInfo.accountType == 2) {
                    imgView.image = [UIImage imageNamed:@"account_weixin"];
                } else if (_viewModel.accountInfo.accountType == 3) {
                    imgView.image = [UIImage imageNamed:@"account_card"];
                }
                if (_viewModel.accountInfo.accountBankName.length) {
                    //姓名
                    nameLabel.text = [NSString stringWithFormat:@"%@(%@)", [NSString stringByReplaceNullString:_viewModel.accountInfo.accountCardHolder], [NSString stringByReplaceNullString:_viewModel.accountInfo.accountBankName]];
                } else {
                    //姓名
                    nameLabel.text = [NSString stringWithFormat:@"%@", [NSString stringByReplaceNullString:_viewModel.accountInfo.accountCardHolder]];
                }
                //账号
                accountLabel.text = [NSString stringWithFormat:@"账号：%@",[NSString stringByReplaceNullString:_viewModel.accountInfo.accountNo]];
                return cell;
            }
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            AccountManageViewController *accountManageViewController = [[AccountManageViewController alloc] initWithViewType:ViewTypeWithWithdrawal accountInfo:_viewModel.accountInfo selectedAccountSucceedBlock:^(AccountInfo *accountInfo) {
                _viewModel.accountInfo = accountInfo;
                [self.dataTableView reloadData];
            } deleteAccountSucceedBlock:^(){
                //获取用户余额和默认账户
                [self getWithdrawalInfoWithUserID:[UserInfoEngine getUserInfo].userID];
            }];
            [self.navigationController pushViewController:accountManageViewController animated:YES];
            
        }
    }
}

#pragma mark --- UITextViewDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _amountTextField) {
        _bateLabel.text = [NSString stringWithFormat:@"手续费%@元", [GlobalFile stringFromeFloat:[_amountTextField.text integerValue]*_viewModel.userRate decimalPlacesCount:2]];
    }
}

#pragma mark --- 忘记支付密码按钮点击
- (void)findPasswordButtonPress {
    //修改提现密码
    SetWithdrawalPwdViewController *setWithdrawalPwdViewController = [[SetWithdrawalPwdViewController alloc] initWithViewType:2 setWithdrawalPwdSuccessed:nil];
    [self.navigationController pushViewController:setWithdrawalPwdViewController animated:YES];
}

@end
