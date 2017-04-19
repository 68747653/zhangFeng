//
//  RechargeViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RechargeViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "AccountNetWorkEngine.h"
////支付
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiObject.h"
#import "WXApi.h"

@interface RechargeViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,copy) RechargeSuccessedBlock rechargeSuccessedBlock;
@property (nonatomic,assign) NSInteger rechangeType;
@property (nonatomic,strong) UITextField *moneyTextField;
@property (nonatomic, strong) HHSoftLabel *realPayLabel;
@property (nonatomic,assign) NSInteger a,x;

@end

@implementation RechargeViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithRechargeSuccessedBlock:(RechargeSuccessedBlock)rechargeSuccessedBlock {
    if (self = [super init]) {
        self.rechargeSuccessedBlock = rechargeSuccessedBlock;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //取消所有编辑
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessed) name:@"ChatPaySuccessNotification" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"充值";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    _rechangeType = 1;
    [self.view addSubview:self.dataTableView];
}

#pragma mark --- 初始化dataTableView
-(HHSoftTableView *)dataTableView{
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
        //充值按钮
        UIButton *rechangeButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 100, [HHSoftAppInfo AppScreen].width-30, 40)];
        rechangeButton.backgroundColor = [GlobalFile themeColor];
        [rechangeButton setTitle:@"立即充值" forState:UIControlStateNormal];
        [rechangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rechangeButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        rechangeButton.layer.cornerRadius = 3.0;
        rechangeButton.layer.masksToBounds = YES;
        [_footerView addSubview:rechangeButton];
        [rechangeButton addTarget:self action:@selector(newRechangeButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
    } else {
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 64.0;
    }
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        static NSString *typeCell = @"typeCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:typeCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:typeCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *typeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 44, 44)];
            typeImgView.layer.cornerRadius = 3.0;
            typeImgView.layer.masksToBounds = YES;
            typeImgView.tag = 222;
            [cell addSubview:typeImgView];
            HHSoftLabel *typeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(69, 17, [HHSoftAppInfo AppScreen].width - 69 - 54, 30) fontSize:16.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
            typeLabel.tag = 226;
            [cell addSubview:typeLabel];
            HHSoftButton *selectButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width - 44, 10, 44, 44)];
            [selectButton setImage:[UIImage imageNamed:@"addressmanager_notdefault"] forState:UIControlStateNormal];
            [selectButton setImage:[UIImage imageNamed:@"recharge_select"] forState:UIControlStateSelected];
            selectButton.tag = 234;
            [cell addSubview:selectButton];
            
        }
        UIImageView *typeImgView = (UIImageView *)[cell viewWithTag:222];
        HHSoftLabel *typeLabel = (HHSoftLabel *)[cell viewWithTag:226];
        HHSoftButton *selectButton = (HHSoftButton *)[cell viewWithTag:234];
        if (indexPath.row == 0) {
            typeLabel.text = @"支付宝";
            typeImgView.image = [UIImage imageNamed:@"account_alipay"];
            if (_rechangeType == 1) {
                selectButton.selected = YES;
            } else {
                selectButton.selected = NO;
            }
        } else if (indexPath.row == 1) {
            typeLabel.text = @"微信";
            typeImgView.image = [UIImage imageNamed:@"account_weixin"];
            if (_rechangeType == 2) {
                selectButton.selected = YES;
            } else {
                selectButton.selected = NO;
            }
        }
        return cell;
    } else {
        //支付宝、微信金额
        static NSString *menuCell = @"menuCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //输入框
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, [HHSoftAppInfo AppScreen].width-80-15, 44.0)];
            textField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            textField.font = [UIFont systemFontOfSize:14.0];
            textField.tag = 365;
            textField.delegate = self;
            textField.keyboardType = UIKeyboardTypeDecimalPad;
            [cell.contentView addSubview:textField];
        }
        //输入框
        UITextField *textField = (UITextField *)[cell.contentView viewWithTag:365];
        cell.textLabel.text = @"充值金额";
        textField.placeholder = @"请输入充值金额";
        _moneyTextField = textField;
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        switch (indexPath.row) {
            case 0: {//支付宝
                _rechangeType = 1;
            }
                break;
                
            case 1: {//微信
                _rechangeType = 2;
            }
                break;
                
            default:
                break;
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark --- UITextFieldDelegate
- (void)textFieldTextDidChange:(NSNotification *)noti {
    UITextField *textField = noti.object;
    if (textField == _moneyTextField) {
        textField.text = [self getTextFieldStringLimit:textField];
    }
}

#pragma mark --- 限制UITextField字符方法
- (NSString *)getTextFieldStringLimit:(UITextField *)textField {
    if (textField.text.length > 0) {
        NSString *p0 = [textField.text substringWithRange:NSMakeRange(0,1)];
        if ([p0 isEqualToString:@"0"]) {
            if (textField.text.length <= 2) {
                if (textField.text.length < 2) {
                    
                } else if (textField.text.length == 2){
                    NSString *p2 = [textField.text substringWithRange:NSMakeRange(1,1)];
                    if (![p2 isEqualToString:@"."]) {
                        textField.text = @"0.";
                    }
                }
            } else if (textField.text.length == 3) {
                NSString *p3 = [textField.text substringWithRange:NSMakeRange(2,1)];
                if ([p3 isEqualToString:@"."]) {
                    textField.text = @"0.";
                }
            } else {
                NSString *p = [textField.text substringWithRange:NSMakeRange(3,1)];
                if (![p isEqualToString:@"0"]) {
                    textField.text = [textField.text substringToIndex:4];
                } else {
                    if (textField.text.length >= 4) {
                        textField.text = [textField.text substringToIndex:4];
                    }
                }
            }
        } else if ([p0 isEqualToString:@"."]) {
            textField.text = @"0.";
        } else {
            NSString *subString = @".";
            NSArray *array = [textField.text componentsSeparatedByString:subString];
            _x = [array count]-1;
            
            if (_x == 1) {
                //一个小数点
                for (NSInteger i = 0; i<textField.text.length; i++) {
                    NSString *temp = [textField.text substringWithRange:NSMakeRange(i,1)];
                    if ([temp isEqualToString:@"."]) {
                        _a = i+1;
                        break;
                    }else{
                        _a = i+1;
                    }
                }
                
                if (textField.text.length > _a+2) {
                    textField.text = [textField.text substringToIndex:_a+2];
                }
            } else if (_x >= 2) {
                //两个小数点
                for (NSInteger i = 0; i<textField.text.length; i++) {
                    NSString *temp = [textField.text substringWithRange:NSMakeRange(i,1)];
                    if ([temp isEqualToString:@"."]) {
                        _a = i+1;
                        break;
                    }
                }
                textField.text = [textField.text substringToIndex:_a];
            }
        }
    }
    return textField.text;
}

#pragma mark --- 立即充值按钮点击事件
- (void)newRechangeButtonClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //支付宝、微信充值
    if (_moneyTextField.text.length == 0) {
        [self showErrorView:@"请输入充值金额"];
        return;
    }
    if ([_moneyTextField.text floatValue] == 0) {
        [self showErrorView:@"充值金额不能为0"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    //支付宝、微信充值接口
    [self addRechargeWithUserID:[UserInfoEngine getUserInfo].userID payType:_rechangeType rechargeAmount:[_moneyTextField.text floatValue]];
}

#pragma mark --- 支付宝、微信充值接口
- (void)addRechargeWithUserID:(NSInteger)userID
                      payType:(NSInteger)payType
               rechargeAmount:(CGFloat)rechargeAmount {
    self.op = [[[AccountNetWorkEngine alloc] init] addRechargeWithUserID:userID payType:payType rechargeAmount:rechargeAmount successed:^(NSInteger code, NSString *alipayResult, PayReq *payReq) {
        [self hideWaitView];
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                if (payType == 1) {
                    [[AlipaySDK defaultService] payOrder:alipayResult fromScheme:[GlobalFile aliScheme] callback:^(NSDictionary *resultDic) {
                        NSInteger code = [[resultDic objectForKey:@"resultStatus"] integerValue];
                        if (code == 9000) {
                            //充值成功
                            [self paySuccessed];
                        } else if (code == 6001) {
                            //充值取消
                            [self payCancel];
                        } else {
                            //充值失败
                            [self payFail];
                        }
                    }];
                } else if (payType == 2) {
                    [WXApi registerApp:payReq.openID];
                    BOOL canOpen = [WXApi sendReq:payReq];
                    if (!canOpen) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"充值提示" message:@"请安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        [alertController addAction:saveAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                }
            }
                break;
    
            case 101: {
                [self showErrorView:@"充值失败"];
            }
                break;
    
            case 103: {
                [self showErrorView:@"充值金额不能小于0"];
            }
                break;
    
            default: {
                [self showErrorView:@"网络接连异常,请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络接连异常,请稍后重试"];
    }];
}

#pragma mark --- 充值成功
- (void)paySuccessed {
    [self showSuccessView:@"充值成功"];
    if (_rechargeSuccessedBlock) {
        _rechargeSuccessedBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 取消充值
- (void)payCancel {
    [self showErrorView:@"取消充值"];
}

#pragma mark --- 充值失败
- (void)payFail {
    [self showErrorView:@"充值失败"];
}

@end
