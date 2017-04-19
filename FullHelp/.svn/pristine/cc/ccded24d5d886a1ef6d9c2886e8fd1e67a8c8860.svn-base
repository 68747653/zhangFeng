//
//  ApplyRedViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ApplyRedViewController.h"
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

@interface ApplyRedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITextField *redNumTextField, *redAmountTextField;
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic, copy) UserApplyOpenRedBlock userApplyOpenRedBlock;
@property (nonatomic, assign) RedViewType viewType;
@property (nonatomic, assign) NSInteger mark;

@end

@implementation ApplyRedViewController

- (instancetype)initWithUserApplyOpenRedBlock:(UserApplyOpenRedBlock)userApplyOpenRedBlock viewType:(RedViewType)viewType {
    if (self = [super init]) {
        self.userApplyOpenRedBlock = userApplyOpenRedBlock;
        self.viewType = viewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_viewType == OpenRedViewType) {
        self.navigationItem.title = @"开通申请红包打赏";
        _mark = 1;
    } else if (_viewType == SetRedViewType) {
        self.navigationItem.title = @"设置红包打赏";
        _mark = 2;
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
    static NSString *strCell = @"ApplyRedInfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        HHSoftLabel *nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, 105, 44) fontSize:15.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        nameLabel.tag = 311;
        [cell addSubview:nameLabel];
        //输入框
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(125, 0, [HHSoftAppInfo AppScreen].width-140, 44)];
        textField.tag = 322;
        textField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        textField.font = [UIFont systemFontOfSize:14.0];
        [cell addSubview:textField];
        //下线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 43, [HHSoftAppInfo AppScreen].width-30, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
        [cell addSubview:lineView];
    }
    HHSoftLabel *nameLabel = (HHSoftLabel *)[cell viewWithTag:311];
    //输入框
    UITextField *textField = (UITextField *)[cell viewWithTag:322];
    if (indexPath.row == 0) {
        nameLabel.text = @"红包个数";
        textField.placeholder = @"请填写红包个数";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        _redNumTextField = textField;
    } else if (indexPath.row == 1) {
        nameLabel.text = @"红包单个金额";
        textField.placeholder = @"请填写红包金额";
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        _redAmountTextField = textField;
    }
    return cell;
}

#pragma mark --- 提交按钮点击事件
- (void)commitButtonClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_redNumTextField.text.length == 0 || [_redNumTextField.text integerValue] == 0) {
        [self showErrorView:@"请填写红包个数"];
        return;
    }
    if (_redAmountTextField.text.length == 0  || [_redAmountTextField.text floatValue] == 0) {
        [self showErrorView:@"请填写红包金额"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    [self userApplyeRedWithUserID:[UserInfoEngine getUserInfo].userID redNum:[_redNumTextField.text integerValue] redAmount:[_redAmountTextField.text floatValue]];
}
#pragma mark --- 红包打赏
- (void)userApplyeRedWithUserID:(NSInteger)userID redNum:(NSInteger)redNum redAmount:(CGFloat)redAmount {
    self.op = [[[UserCenterNetWorkEngine alloc] init] userApplyeRedWithUserID:userID mark:_mark redNum:redNum redAmount:redAmount successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {//103：余额不足 104：代货商信息不完整 ,105:未申请开通红包打赏
            case 100: {
                if (_userApplyOpenRedBlock) {
                    _userApplyOpenRedBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD showSuccessWithStatus:@"成功"];
            }
                break;
                
            case 101: {
                [self showErrorView:@"失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"余额不足"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"供货商信息不完整"];
            }
                break;
                
            case 105: {
                [self showErrorView:@"未申请开通红包打赏"];
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
